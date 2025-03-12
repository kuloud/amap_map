import 'dart:async';

import 'package:amap_map_example/widgets/amap_switch_button.dart';
import 'package:flutter/material.dart';

import 'package:amap_map/amap_map.dart';
import 'package:x_amap_base/x_amap_base.dart';
import 'dart:math';

/// 自定义[InfoWindow]用例
class CustomInfoWindowDemoPage extends StatefulWidget {
  const CustomInfoWindowDemoPage();

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<CustomInfoWindowDemoPage> {
  static final LatLng mapCenter = const LatLng(39.909187, 116.397451);

  final Map<String, Marker> _markers = <String, Marker>{};
  BitmapDescriptor? _markerIcon;
  String? selectedMarkerId;
  bool showInfoWindow = false;
  AMapController? _controller;

  Future<void> _onMapCreated(AMapController controller) async {
    setState(() {
      _controller = controller;
    });
  }

  void _add() {
    final int markerCount = _markers.length;
    LatLng markPostion = LatLng(
        mapCenter.latitude + sin(markerCount * pi / 12.0) / 20.0,
        mapCenter.longitude + cos(markerCount * pi / 12.0) / 20.0);
    final Marker marker = Marker(
      position: markPostion,
      icon: _markerIcon!,
      infoWindow: InfoWindow(title: '第 $markerCount 个Marker'),
      onTap: (String markerId) => _onMarkerTapped(markerId),
      onDragEnd: (String markerId, LatLng endPosition) =>
          _onMarkerDragEnd(markerId, endPosition),
    );

    setState(() {
      _markers[marker.id] = marker;
    });
  }

  void _onMarkerTapped(String markerId) {
    final Marker? tappedMarker = _markers[markerId];
    final String? title = tappedMarker!.infoWindow.title;
    print('$title 被点击了,markerId: $markerId');
    setState(() {
      selectedMarkerId = markerId;
    });
  }

  void _onMarkerDragEnd(String markerId, LatLng position) {
    final Marker? tappedMarker = _markers[markerId];
    final String? title = tappedMarker!.infoWindow.title;
    print('$title markerId: $markerId 被拖拽到了: $position');
  }

  void _remove() {
    final Marker? selectedMarker = _markers[selectedMarkerId];
    //有选中的Marker
    if (selectedMarker != null) {
      setState(() {
        _markers.remove(selectedMarkerId);
      });
    } else {
      print('无选中的Marker，无法删除');
    }
  }

  void _removeAll() {
    if (_markers.isNotEmpty) {
      setState(() {
        _markers.clear();
        selectedMarkerId = null.toString();
      });
    }
  }

  void _changeInfo() async {
    final Marker marker = _markers[selectedMarkerId]!;
    final String newTitle = '${marker.infoWindow.title!}*';
    if (selectedMarkerId != null) {
      setState(() {
        _markers[selectedMarkerId!] = marker.copyWith(
          infoWindowParam: marker.infoWindow.copyWith(
            titleParam: newTitle,
          ),
        );
      });
    }
  }

  void _changeAnchor() {
    final Marker marker = _markers[selectedMarkerId]!;
    final Offset currentAnchor = marker.anchor;
    double dx = 0;
    double dy = 0;
    if (currentAnchor.dx < 1) {
      dx = currentAnchor.dx + 0.1;
    } else {
      dx = 0;
    }
    if (currentAnchor.dy < 1) {
      dy = currentAnchor.dy + 0.1;
    } else {
      dy = 0;
    }
    final Offset newAnchor = Offset(dx, dy);
    setState(() {
      _markers[selectedMarkerId!] = marker.copyWith(
        anchorParam: newAnchor,
      );
    });
  }

  void _changePosition() {
    final Marker marker = _markers[selectedMarkerId]!;
    final LatLng current = marker.position;
    final Offset offset = Offset(
      mapCenter.latitude - current.latitude,
      mapCenter.longitude - current.longitude,
    );
    setState(() {
      _markers[selectedMarkerId!] = marker.copyWith(
        positionParam: LatLng(
          mapCenter.latitude + offset.dy,
          mapCenter.longitude + offset.dx,
        ),
      );
    });
  }

  Future<void> _changeAlpha() async {
    final Marker marker = _markers[selectedMarkerId]!;
    final double current = marker.alpha;
    setState(() {
      _markers[selectedMarkerId!] = marker.copyWith(
        alphaParam: current < 0.1 ? 1.0 : current * 0.75,
      );
    });
  }

  Future<void> _changeRotation() async {
    final Marker marker = _markers[selectedMarkerId]!;
    final double current = marker.rotation;
    setState(() {
      _markers[selectedMarkerId!] = marker.copyWith(
        rotationParam: current == 330.0 ? 0.0 : current + 30.0,
      );
    });
  }

  Future<void> _toggleVisible(value) async {
    final Marker marker = _markers[selectedMarkerId]!;

    setState(() {
      showInfoWindow = value;
      _markers[selectedMarkerId!] = marker.copyWith(
        visibleParam: value,
      );
    });
  }

  Future<void> _toggleDraggable(value) async {
    final Marker marker = _markers[selectedMarkerId]!;
    setState(() {
      _markers[selectedMarkerId!] = marker.copyWith(
        draggableParam: value,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    ///以下几种获取自定图片的方式使用其中一种即可。
    //最简单的方式
    _markerIcon ??= BitmapDescriptor.fromIconPath('assets/location_marker.png');

    AMapWidget map = AMapWidget(
      onMapCreated: _onMapCreated,
      markers: Set<Marker>.of(_markers.values),
      infoWindowAdapter: CustomInfoWindowAdapter(_controller, selectedMarkerId),
    );
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            child: map,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          TextButton(
                            onPressed: _add,
                            child: const Text('添加'),
                          ),
                          TextButton(
                            onPressed:
                                (selectedMarkerId == null) ? null : _remove,
                            child: const Text('移除'),
                          ),
                          TextButton(
                            onPressed:
                                (selectedMarkerId == null) ? null : _changeInfo,
                            child: const Text('更新InfoWidow'),
                          ),
                          TextButton(
                            onPressed: (selectedMarkerId == null)
                                ? null
                                : _changeAnchor,
                            child: const Text('修改锚点'),
                          ),
                          TextButton(
                            onPressed: (selectedMarkerId == null)
                                ? null
                                : _changeAlpha,
                            child: const Text('修改透明度'),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          TextButton(
                            onPressed: _markers.isNotEmpty ? _removeAll : null,
                            child: const Text('全部移除'),
                          ),
                          AMapSwitchButton(
                            label: const Text('允许拖动'),
                            onSwitchChanged: (selectedMarkerId == null)
                                ? null
                                : _toggleDraggable,
                            defaultValue: false,
                          ),
                          AMapSwitchButton(
                            label: const Text('显示'),
                            onSwitchChanged: (selectedMarkerId == null)
                                ? null
                                : _toggleVisible,
                            defaultValue: true,
                          ),
                          TextButton(
                            onPressed: (selectedMarkerId == null)
                                ? null
                                : _changePosition,
                            child: const Text('修改坐标'),
                          ),
                          TextButton(
                            onPressed: (selectedMarkerId == null)
                                ? null
                                : _changeRotation,
                            child: const Text('修改旋转角度'),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomInfoWindowAdapter extends BaseInfoWindowAdapter {
  CustomInfoWindowAdapter(super.controller, this.selectedMarkerId);

  final String? selectedMarkerId;

  @override
  Widget? buildInfoWindowContent(BuildContext context, Marker marker) {
    if (marker.id != selectedMarkerId) {
      return null;
    }
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          const BoxShadow(
            color: Colors.black26,
            blurRadius: 4.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            marker.infoWindow.title ?? 'No Title',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            marker.infoWindow.snippet ?? 'No Snippet',
          ),
        ],
      ),
    );
  }
}
