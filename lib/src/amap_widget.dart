// Copyright 2023 kuloud
// Copyright 2020 lbs.amap.com

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at

//     http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,

part of '../amap_map.dart';

typedef MapCreatedCallback = void Function(AMapController controller);

///用于展示高德地图的Widget
class AMapWidget extends StatefulWidget {
  /// 初始化时的地图中心点
  final CameraPosition initialCameraPosition;

  /// 地图类型
  final MapType mapType;

  /// 自定义地图样式
  final CustomStyleOptions? customStyleOptions;

  /// 定位小蓝点
  final MyLocationStyleOptions? myLocationStyleOptions;

  /// 缩放级别范围
  final MinMaxZoomPreference? minMaxZoomPreference;

  /// 地图显示范围
  final LatLngBounds? limitBounds;

  /// 显示路况开关
  final bool trafficEnabled;

  /// 地图poi是否允许点击
  final bool touchPoiEnabled;

  /// 是否显示3D建筑物，默认显示
  final bool buildingsEnabled;

  /// 是否显示底图文字标注
  final bool labelsEnabled;

  /// 是否显示指南针
  final bool compassEnabled;

  /// 是否显示比例尺
  final bool scaleEnabled;

  /// 是否支持缩放手势
  final bool zoomGesturesEnabled;

  /// 是否支持滑动手势
  final bool scrollGesturesEnabled;

  ///是否支持旋转手势
  final bool rotateGesturesEnabled;

  ///是否支持倾斜手势
  final bool tiltGesturesEnabled;

  /// logo 位置，此字段高德只支持Android，本插件iOS借用logoCenter做了实现
  final LogoPosition? logoPosition;

  /// logo 底部间距(px)，此字段高德只支持Android，本插件iOS借用logoCenter做了实现
  final int? logoBottomMargin;

  /// logo 靠左间距(px)，此字段高德只支持Android，本插件iOS借用logoCenter做了实现
  final int? logoLeftMargin;

  /// 地图上显示的Marker
  final Set<Marker> markers;

  /// 地图上显示的polyline
  final Set<Polyline> polylines;

  /// 地图上显示的polygon
  final Set<Polygon> polygons;

  /// 地图创建成功的回调, 收到此回调之后才可以操作地图
  final MapCreatedCallback? onMapCreated;

  /// 相机视角持续移动的回调
  final ArgumentCallback<CameraPosition>? onCameraMove;

  /// 相机视角移动结束的回调
  final ArgumentCallback<CameraPosition>? onCameraMoveEnd;

  /// 地图单击事件的回调
  final ArgumentCallback<LatLng>? onTap;

  /// 地图长按事件的回调
  final ArgumentCallback<LatLng>? onLongPress;

  /// 地图POI的点击回调，需要`touchPoiEnabled`true，才能回调
  final ArgumentCallback<AMapPoi>? onPoiTouched;

  ///位置回调
  final ArgumentCallback<AMapLocation>? onLocationChanged;

  ///需要应用到地图上的手势集合
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;

  /// 设置地图语言
  final MapLanguage? mapLanguage;

  /// Marker InfoWindow 适配器
  final InfoWindowAdapter? infoWindowAdapter;

  /// 创建一个展示高德地图的widget
  ///
  /// 在app首次启动时必须传入高德合规声明配置[privacyStatement],后续如果没有变化不需要重复设置
  /// <li>[privacyStatement.hasContains] 隐私权政策是否包含高德开平隐私权政策</li>
  /// <li>[privacyStatement.hasShow] 是否已经弹窗展示给用户</li>
  /// <li>[privacyStatement.hasAgree] 隐私权政策是否已经取得用户同意</li>
  /// 以上三个值，任何一个为false都会造成地图插件不工作（白屏情况）
  ///
  /// 高德SDK合规使用方案请参考：https://lbs.amap.com/news/sdkhgsy
  ///
  /// [AssertionError] will be thrown if [initialCameraPosition] is null;
  const AMapWidget(
      {super.key,
      this.initialCameraPosition =
          const CameraPosition(target: LatLng(39.909187, 116.397451), zoom: 10),
      this.mapType = MapType.normal,
      this.buildingsEnabled = true,
      this.compassEnabled = false,
      this.labelsEnabled = true,
      this.limitBounds,
      this.minMaxZoomPreference,
      this.rotateGesturesEnabled = true,
      this.scaleEnabled = true,
      this.scrollGesturesEnabled = true,
      this.tiltGesturesEnabled = true,
      this.touchPoiEnabled = true,
      this.trafficEnabled = false,
      this.zoomGesturesEnabled = true,
      this.onMapCreated,
      this.gestureRecognizers = const <Factory<OneSequenceGestureRecognizer>>{},
      this.customStyleOptions,
      this.myLocationStyleOptions,
      this.onCameraMove,
      this.onCameraMoveEnd,
      this.onLocationChanged,
      this.onTap,
      this.onLongPress,
      this.onPoiTouched,
      this.markers = const <Marker>{},
      this.polylines = const <Polyline>{},
      this.polygons = const <Polygon>{},
      this.mapLanguage,
      this.infoWindowAdapter,
      this.logoPosition,
      this.logoBottomMargin,
      this.logoLeftMargin});

  ///
  @override
  State<StatefulWidget> createState() => _MapState();
}

class _MapState extends State<AMapWidget> {
  Map<String, Marker> _markers = <String, Marker>{};
  Map<String, Polyline> _polylines = <String, Polyline>{};
  Map<String, Polygon> _polygons = <String, Polygon>{};
  final Map<String, Widget?> _infoWindows = <String, Widget?>{};

  final Completer<AMapController> _controller = Completer<AMapController>();
  late _AMapOptions _mapOptions;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> creationParams = <String, dynamic>{
      'privacyStatement': AMapInitializer._privacyStatement?.toMap(),
      'apiKey': AMapInitializer._apiKey?.toMap(),
      'initialCameraPosition': widget.initialCameraPosition.toMap(),
      'options': _mapOptions.toMap(),
      'markersToAdd': serializeOverlaySet(widget.markers),
      'polylinesToAdd': serializeOverlaySet(widget.polylines),
      'polygonsToAdd': serializeOverlaySet(widget.polygons),
    };
    Widget mapView = _methodChannel.buildView(
      creationParams,
      widget.gestureRecognizers,
      onPlatformViewCreated,
    );

    return Stack(
      children: <Widget>[mapView, ..._infoWindows.values.nonNulls],
    );
  }

  @override
  void initState() {
    super.initState();
    _mapOptions = _AMapOptions.fromWidget(widget);
    _markers = keyByMarkerId(widget.markers);
    _polygons = keyByPolygonId(widget.polygons);
    _polylines = keyByPolylineId(widget.polylines);

    print('initState AMapWidget');
  }

  @override
  void dispose() async {
    super.dispose();
    AMapController controller = await _controller.future;
    controller.disponse();
    print('dispose AMapWidget with mapId: ${controller.mapId}');
  }

  @override
  void reassemble() {
    super.reassemble();
    print('reassemble AMapWidget');
  }

  @override
  void deactivate() async {
    super.deactivate();
    print('deactivate AMapWidget');
  }

  @override
  void didUpdateWidget(covariant AMapWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateOptions();
    updateMarkers();
    _updatePolylines();
    _updatePolygons();
  }

  Future<void> onPlatformViewCreated(int id) async {
    final AMapController controller = await AMapController.init(
      id,
      widget.initialCameraPosition,
      this,
    );
    _controller.complete(controller);

    final MapCreatedCallback? onMapCreated = widget.onMapCreated;
    if (onMapCreated != null) {
      onMapCreated(controller);
    }
  }

  void onMarkerTap(String markerId) {
    final Marker? marker = _markers[markerId];
    if (marker != null) {
      final ArgumentCallback<String>? onTap = marker.onTap;
      if (onTap != null) {
        onTap(markerId);
      }
    }
  }

  void onMarkerDragEnd(String markerId, LatLng position) {
    final Marker? marker = _markers[markerId];
    if (marker != null) {
      final MarkerDragEndCallback? onDragEnd = marker.onDragEnd;
      if (onDragEnd != null) {
        onDragEnd(markerId, position);
      }
    }
  }

  void onPolylineTap(String polylineId) {
    final Polyline? polyline = _polylines[polylineId];
    if (polyline != null) {
      final ArgumentCallback<String>? onTap = polyline.onTap;
      if (onTap != null) {
        onTap(polylineId);
      }
    }
  }

  void _updateOptions() async {
    final _AMapOptions newOptions = _AMapOptions.fromWidget(widget);
    final Map<String, dynamic> updates = _mapOptions._updatesMap(newOptions);
    if (updates.isEmpty) {
      return;
    }
    final AMapController controller = await _controller.future;
    // ignore: unawaited_futures
    controller._updateMapOptions(updates);
    _mapOptions = newOptions;
  }

  void updateMarkers() async {
    final AMapController controller = await _controller.future;
    MarkerUpdates markerUpdates =
        MarkerUpdates.from(_markers.values.toSet(), widget.markers);

    markerUpdates.markerIdsToRemove?.forEach((String markerId) {
      _removeInfoWindow(markerId);
    });

    // ignore: unawaited_futures
    controller._updateMarkers(markerUpdates);
    _markers = keyByMarkerId(widget.markers);

    if (widget.infoWindowAdapter != null) {
      for (final Marker marker in _markers.values) {
        _onInfoWindowUpdate(marker);
      }
    }
  }

  void _updatePolylines() async {
    final AMapController controller = await _controller.future;
    controller._updatePolylines(
        PolylineUpdates.from(_polylines.values.toSet(), widget.polylines));
    _polylines = keyByPolylineId(widget.polylines);
  }

  void _updatePolygons() async {
    final AMapController controller = await _controller.future;
    controller._updatePolygons(
        PolygonUpdates.from(_polygons.values.toSet(), widget.polygons));
    _polygons = keyByPolygonId(widget.polygons);
  }

  void _onInfoWindowUpdate(Marker marker) {
    if (widget.infoWindowAdapter != null) {
      setState(() {
        _infoWindows[marker.id] =
            widget.infoWindowAdapter!.getInfoWindow(context, marker);
      });
    }
  }

  void _removeInfoWindow(String markerId) {
    setState(() {
      _infoWindows.remove(markerId);
    });
  }
}

//高德地图参数设置
class _AMapOptions {
  ///地图类型
  final MapType mapType;

  ///自定义地图样式
  final CustomStyleOptions? customStyleOptions;

  ///定位小蓝点
  final MyLocationStyleOptions? myLocationStyleOptions;

  //缩放级别范围
  final MinMaxZoomPreference? minMaxZoomPreference;

  ///地图显示范围
  final LatLngBounds? limitBounds;

  ///显示路况开关
  final bool? trafficEnabled;

  /// 地图poi是否允许点击
  final bool? touchPoiEnabled;

  ///是否显示3D建筑物
  final bool? buildingsEnabled;

  /// 是否显示底图文字标注，默认显示
  final bool? labelsEnabled;

  ///是否显示指南针
  final bool? compassEnabled;

  ///是否显示比例尺
  final bool? scaleEnabled;

  ///是否支持缩放手势
  final bool? zoomGesturesEnabled;

  ///是否支持滑动手势
  final bool? scrollGesturesEnabled;

  ///是否支持旋转手势
  final bool? rotateGesturesEnabled;

  ///是否支持仰角手势
  final bool? tiltGesturesEnabled;

  /// logo的位置
  final int? logoPosition;

  final int? logoBottomMargin;
  final int? logoLeftMargin;

  final MapLanguage? mapLanguage;

  _AMapOptions(
      {this.mapType = MapType.normal,
      this.buildingsEnabled,
      this.customStyleOptions,
      this.myLocationStyleOptions,
      this.compassEnabled,
      this.labelsEnabled,
      this.limitBounds,
      this.minMaxZoomPreference,
      this.scaleEnabled,
      this.touchPoiEnabled,
      this.trafficEnabled,
      this.rotateGesturesEnabled,
      this.scrollGesturesEnabled,
      this.tiltGesturesEnabled,
      this.zoomGesturesEnabled,
      this.logoPosition,
      this.logoBottomMargin,
      this.logoLeftMargin,
      this.mapLanguage});

  static _AMapOptions fromWidget(AMapWidget map) {
    return _AMapOptions(
      mapType: map.mapType,
      buildingsEnabled: map.buildingsEnabled,
      compassEnabled: map.compassEnabled,
      labelsEnabled: map.labelsEnabled,
      limitBounds: map.limitBounds,
      minMaxZoomPreference: map.minMaxZoomPreference,
      scaleEnabled: map.scaleEnabled,
      touchPoiEnabled: map.touchPoiEnabled,
      trafficEnabled: map.trafficEnabled,
      rotateGesturesEnabled: map.rotateGesturesEnabled,
      scrollGesturesEnabled: map.scrollGesturesEnabled,
      tiltGesturesEnabled: map.tiltGesturesEnabled,
      zoomGesturesEnabled: map.zoomGesturesEnabled,
      customStyleOptions: map.customStyleOptions?.clone(),
      myLocationStyleOptions: map.myLocationStyleOptions?.clone(),
      logoPosition: map.logoPosition?.index,
      logoBottomMargin: map.logoBottomMargin,
      logoLeftMargin: map.logoLeftMargin,
      mapLanguage: map.mapLanguage,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> optionsMap = <String, dynamic>{};
    void addIfNonNull(String fieldName, dynamic value) {
      if (value != null) {
        optionsMap[fieldName] = value;
      }
    }

    addIfNonNull('mapType', mapType.index);
    addIfNonNull('buildingsEnabled', buildingsEnabled);
    addIfNonNull('customStyleOptions', customStyleOptions?.clone().toMap());
    addIfNonNull('compassEnabled', compassEnabled);
    addIfNonNull('labelsEnabled', labelsEnabled);
    addIfNonNull('limitBounds', limitBounds?.toJson());
    addIfNonNull('minMaxZoomPreference', minMaxZoomPreference?.toJson());
    addIfNonNull('scaleEnabled', scaleEnabled);
    addIfNonNull('touchPoiEnabled', touchPoiEnabled);
    addIfNonNull('trafficEnabled', trafficEnabled);
    addIfNonNull('rotateGesturesEnabled', rotateGesturesEnabled);
    addIfNonNull('scrollGesturesEnabled', scrollGesturesEnabled);
    addIfNonNull('tiltGesturesEnabled', tiltGesturesEnabled);
    addIfNonNull('zoomGesturesEnabled', zoomGesturesEnabled);
    addIfNonNull('myLocationStyle', myLocationStyleOptions?.clone().toMap());
    addIfNonNull('logoPosition', logoPosition);
    addIfNonNull('logoBottomMargin', logoBottomMargin);
    addIfNonNull('logoLeftMargin', logoLeftMargin);
    addIfNonNull('mapLanguage', mapLanguage?.value);
    return optionsMap;
  }

  Map<String, dynamic> _updatesMap(_AMapOptions newOptions) {
    final Map<String, dynamic> prevOptionsMap = toMap();

    return newOptions.toMap()
      ..removeWhere((String key, dynamic value) =>
          (_checkChange(key, prevOptionsMap[key], value)));
  }

  bool _checkChange(String key, dynamic preValue, dynamic newValue) {
    if (key == 'myLocationStyle' || key == 'customStyleOptions') {
      return preValue?.toString() == newValue?.toString();
    } else {
      return preValue == newValue;
    }
  }
}
