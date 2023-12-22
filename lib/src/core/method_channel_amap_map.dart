import 'dart:async';

import 'package:x_amap_base/x_amap_base.dart';
import 'package:amap_map/src/core/amap_flutter_platform.dart';
import 'package:amap_map/src/types/types.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:stream_transform/stream_transform.dart';

import 'map_event.dart';

const VIEW_TYPE = 'com.amap.flutter.map';

/// 使用[MethodChannel]与Native代码通信的[AMapFlutterPlatform]的实现。
class MethodChannelAMapFlutterMap implements AMapFlutterPlatform {
  final Map<int, MethodChannel> _channels = {};

  MethodChannel channel(int mapId) {
    return _channels[mapId]!;
  }

  @override
  Future<void> init(int mapId) {
    MethodChannel? channel = _channels[mapId];
    if (channel == null) {
      channel = MethodChannel('amap_map_$mapId');
      channel.setMethodCallHandler((call) => _handleMethodCall(call, mapId));
      _channels[mapId] = channel;
    }
    return channel.invokeMethod<void>('map#waitForMap');
  }

  ///更新地图参数
  Future<void> updateMapOptions(
    Map<String, dynamic> newOptions, {
    required int mapId,
  }) {
    return channel(mapId).invokeMethod<void>(
      'map#update',
      <String, dynamic>{
        'options': newOptions,
      },
    );
  }

  /// 更新Marker的数据
  Future<void> updateMarkers(
    MarkerUpdates markerUpdates, {
    required int mapId,
  }) {
    return channel(mapId).invokeMethod<void>(
      'markers#update',
      markerUpdates.toMap(),
    );
  }

  /// 更新polyline的数据
  Future<void> updatePolylines(
    PolylineUpdates polylineUpdates, {
    required int mapId,
  }) {
    return channel(mapId).invokeMethod<void>(
      'polylines#update',
      polylineUpdates.toMap(),
    );
  }

  /// 更新polygon的数据
  Future<void> updatePolygons(
    PolygonUpdates polygonUpdates, {
    required int mapId,
  }) {
    return channel(mapId).invokeMethod<void>(
      'polygons#update',
      polygonUpdates.toMap(),
    );
  }

  @override
  void dispose({required int id}) {
    if (_channels.containsKey(id)) {
      _channels.remove(id);
    }
  }

  @override
  Widget buildView(
      Map<String, dynamic> creationParams,
      Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers,
      void Function(int id) onPlatformViewCreated) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      creationParams['debugMode'] = kDebugMode;
      return AndroidView(
        viewType: VIEW_TYPE,
        onPlatformViewCreated: onPlatformViewCreated,
        gestureRecognizers: gestureRecognizers,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: VIEW_TYPE,
        onPlatformViewCreated: onPlatformViewCreated,
        gestureRecognizers: gestureRecognizers,
        creationParams: creationParams,
        creationParamsCodec: const StandardMessageCodec(),
      );
    }
    return Text('当前平台:$defaultTargetPlatform, 不支持使用高德地图插件');
  }

  // handleMethodCall的`broadcast`
  final StreamController<MapEvent> _mapEventStreamController =
      StreamController<MapEvent>.broadcast();

  // 根据mapid返回相应的event.
  Stream<MapEvent> _events(int mapId) =>
      _mapEventStreamController.stream.where((event) => event.mapId == mapId);

  //定位回调
  Stream<LocationChangedEvent> onLocationChanged({required int mapId}) {
    return _events(mapId).whereType<LocationChangedEvent>();
  }

  //Camera 移动回调
  Stream<CameraPositionMoveEvent> onCameraMove({required int mapId}) {
    return _events(mapId).whereType<CameraPositionMoveEvent>();
  }

  ///Camera 移动结束回调
  Stream<CameraPositionMoveEndEvent> onCameraMoveEnd({required int mapId}) {
    return _events(mapId).whereType<CameraPositionMoveEndEvent>();
  }

  Stream<MapTapEvent> onMapTap({required int mapId}) {
    return _events(mapId).whereType<MapTapEvent>();
  }

  Stream<MapLongPressEvent> onMapLongPress({required int mapId}) {
    return _events(mapId).whereType<MapLongPressEvent>();
  }

  Stream<MapPoiTouchEvent> onPoiTouched({required int mapId}) {
    return _events(mapId).whereType<MapPoiTouchEvent>();
  }

  Stream<MarkerTapEvent> onMarkerTap({required int mapId}) {
    return _events(mapId).whereType<MarkerTapEvent>();
  }

  Stream<MarkerDragEndEvent> onMarkerDragEnd({required int mapId}) {
    return _events(mapId).whereType<MarkerDragEndEvent>();
  }

  Stream<PolylineTapEvent> onPolylineTap({required int mapId}) {
    return _events(mapId).whereType<PolylineTapEvent>();
  }

  Future<dynamic> _handleMethodCall(MethodCall call, int mapId) async {
    switch (call.method) {
      case 'location#changed':
        try {
          _mapEventStreamController.add(LocationChangedEvent(
              mapId, AMapLocation.fromMap(call.arguments['location'])!));
        } catch (e) {
          print("location#changed error=======>" + e.toString());
        }
        break;

      case 'camera#onMove':
        try {
          _mapEventStreamController.add(CameraPositionMoveEvent(
              mapId, CameraPosition.fromMap(call.arguments['position'])!));
        } catch (e) {
          print("camera#onMove error===>" + e.toString());
        }
        break;
      case 'camera#onMoveEnd':
        try {
          _mapEventStreamController.add(CameraPositionMoveEndEvent(
              mapId, CameraPosition.fromMap(call.arguments['position'])!));
        } catch (e) {
          print("camera#onMoveEnd error===>" + e.toString());
        }
        break;
      case 'map#onTap':
        _mapEventStreamController.add(
            MapTapEvent(mapId, LatLng.fromJson(call.arguments['latLng'])!));
        break;
      case 'map#onLongPress':
        _mapEventStreamController.add(MapLongPressEvent(
            mapId, LatLng.fromJson(call.arguments['latLng'])!));
        break;

      case 'marker#onTap':
        _mapEventStreamController.add(MarkerTapEvent(
          mapId,
          call.arguments['markerId'],
        ));
        break;
      case 'marker#onDragEnd':
        _mapEventStreamController.add(MarkerDragEndEvent(
            mapId,
            LatLng.fromJson(call.arguments['position'])!,
            call.arguments['markerId']));
        break;
      case 'polyline#onTap':
        _mapEventStreamController
            .add(PolylineTapEvent(mapId, call.arguments['polylineId']));
        break;
      case 'map#onPoiTouched':
        try {
          _mapEventStreamController.add(MapPoiTouchEvent(
              mapId, AMapPoi.fromJson(call.arguments['poi'])!));
        } catch (e) {
          print('map#onPoiTouched error===>' + e.toString());
        }
        break;
    }
  }

  ///移动镜头到一个新的位置
  Future<void> moveCamera(
    CameraUpdate cameraUpdate, {
    required int mapId,
    bool animated = true,
    int duration = 0,
  }) {
    return channel(mapId).invokeMethod<void>('camera#move', <String, dynamic>{
      'cameraUpdate': cameraUpdate.toJson(),
      'animated': animated,
      'duration': duration
    });
  }

  ///设置地图每秒渲染的帧数
  Future<void> setRenderFps(int fps, {required int mapId}) {
    return channel(mapId)
        .invokeMethod<void>('map#setRenderFps', <String, dynamic>{
      'fps': fps,
    });
  }

  ///截屏
  Future<Uint8List?> takeSnapshot({
    required int mapId,
  }) {
    return channel(mapId).invokeMethod<Uint8List>('map#takeSnapshot');
  }

  //获取地图审图号（普通地图）
  Future<String?> getMapContentApprovalNumber({
    required int mapId,
  }) {
    return channel(mapId).invokeMethod<String>('map#contentApprovalNumber');
  }

  //获取地图审图号（卫星地图）
  Future<String?> getSatelliteImageApprovalNumber({
    required int mapId,
  }) {
    return channel(mapId)
        .invokeMethod<String>('map#satelliteImageApprovalNumber');
  }

  Future<void> clearDisk({
    required int mapId,
  }) {
    return channel(mapId).invokeMethod<void>('map#clearDisk');
  }
}
