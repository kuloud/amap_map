import 'dart:async';

import 'package:amap_map/amap_map.dart';
import 'package:flutter/material.dart';
import 'package:x_amap_base/x_amap_base.dart';

/// [amap_map]插件支持默认的[InfoWindow]展示[title]和[snippet]字段，如果要自定义
/// [InfoWindow]，需要集成此内置插件。
///
/// ```dart
/// AMapWidget map = AMapWidget(
///   onMapCreated: _onMapCreated,
///   markers: Set<Marker>.of(_markers.values),
///   extensions: [
///     InfoWindowExtension(
///       infoWindow: Container(
///         child: Text('Custom widget'),
///     ))
///   ],
/// )
/// ```
///
/// 此插件会在[AMapWidget]外侧套一层[Stack]，根据屏幕坐标和经纬度进行适配自定义视图
///
/// ```dart
///   Stack(
///       children: [
///         child,
///         Positioned(
///           top: 0,
///           left: 0,
///           child: Visibility(child: infoWindow),
///         ),
///       ],
///     )
/// ```
class InfoWindowExtension extends AMapExtension {
  InfoWindowExtension({required this.infoWindow, this.option});

  StreamController<InfoWindowExtension> _streamController =
      StreamController<InfoWindowExtension>.broadcast();

  final Widget infoWindow;
  InfoWindowOption? option;

  AMapController? mapController;
  double? _x;
  double? _y;

  @override
  void update(AMapContext aMapContext) {
    _update();
  }

  @override
  onCameraMove(CameraPosition value) {
    _update();
  }

  _update() async {
    if (mapController == null || option?.latLng == null) {
      return;
    }

    final coordinate = await mapController!.toScreenCoordinate(option!.latLng!);

    _x = coordinate.x.toDouble();
    _y = coordinate.y.toDouble();

    _streamController.add(this);
  }

  @override
  bindMapController(AMapController controller) {
    debugPrint('[InfoWindowExtension] bindMapController: $controller');
    mapController = controller;
  }

  @override
  Widget build(AMapContext aMapContext, Widget child) {
    return Stack(
      children: [
        child,
        StreamBuilder<InfoWindowExtension>(
            key: ValueKey(this),
            initialData: this,
            stream: _streamController.stream,
            builder: (context, snapshot) {
              final data = snapshot.data;
              if (data == null ||
                  !(data.option?.show ?? false) ||
                  data._x == null) {
                return Container();
              }

              return Positioned(
                top: data._y,
                left: data._x,
                child: Container(
                  margin: data.option?.offset,
                  child: infoWindow,
                ),
              );
            }),
      ],
    );
  }
}

class InfoWindowOption {
  bool show = false;
  LatLng? latLng;
  EdgeInsetsGeometry? offset;

  InfoWindowOption({this.show = false, this.latLng, this.offset});

  @override
  String toString() {
    return 'InfoWindowOption{show: $show, latLng: $latLng, offset: $offset}';
  }
}
