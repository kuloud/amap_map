// Copyright 2023-2024 kuloud
// Copyright 2020 lbs.amap.com

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at

//     http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,

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

// ignore: constant_identifier_names
const String VIEW_TYPE = 'com.amap.flutter.map';

/// 使用[MethodChannel]与Native代码通信的[AMapFlutterPlatform]的实现。
class MethodChannelAMapFlutterMap implements AMapFlutterPlatform {
  final Map<int, MethodChannel> _channels = <int, MethodChannel>{};

  MethodChannel channel(int mapId) {
    return _channels[mapId]!;
  }

  @override
  Future<void> init(int mapId) {
    MethodChannel? channel = _channels[mapId];
    if (channel == null) {
      channel = MethodChannel('amap_map_$mapId');
      channel.setMethodCallHandler(
          (MethodCall call) => _handleMethodCall(call, mapId));
      _channels[mapId] = channel;
    }
    return channel.invokeMethod<void>('map#waitForMap');
  }

  /// 更新地图参数
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
  final StreamController<MapEvent<dynamic>> _mapEventStreamController =
      StreamController<MapEvent<dynamic>>.broadcast();

  // 根据mapid返回相应的event.
  Stream<MapEvent<dynamic>> _events(int mapId) =>
      _mapEventStreamController.stream
          .where((MapEvent<dynamic> event) => event.mapId == mapId);

  //定位回调
  Stream<LocationChangedEvent> onLocationChanged({required int mapId}) {
    return _events(mapId).whereType<LocationChangedEvent>();
  }

  // Camera 移动回调
  Stream<CameraMoveEvent> onCameraMove({required int mapId}) {
    return _events(mapId).whereType<CameraMoveEvent>();
  }

  /// Camera 移动结束回调
  Stream<CameraMoveEndEvent> onCameraMoveEnd({required int mapId}) {
    return _events(mapId).whereType<CameraMoveEndEvent>();
  }

  /// Camera 地图点击回调
  Stream<MapTapEvent> onMapTap({required int mapId}) {
    return _events(mapId).whereType<MapTapEvent>();
  }

  /// Camera 地图长按回调
  Stream<MapLongPressEvent> onMapLongPress({required int mapId}) {
    return _events(mapId).whereType<MapLongPressEvent>();
  }

  /// Camera 地图POI点点击回调
  Stream<MapPoiTouchEvent> onPoiTouched({required int mapId}) {
    return _events(mapId).whereType<MapPoiTouchEvent>();
  }

  /// Camera 地图锚点点击回调
  Stream<MarkerTapEvent> onMarkerTap({required int mapId}) {
    return _events(mapId).whereType<MarkerTapEvent>();
  }

  /// Camera 地图锚点拖拽结束回调
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
          print("location#changed error=======>$e");
        }
        break;

      case 'camera#onMove':
        try {
          _mapEventStreamController.add(CameraMoveEvent(
              mapId, CameraPosition.fromMap(call.arguments['position'])!));
        } catch (e) {
          print("camera#onMove error===>$e");
        }
        break;
      case 'camera#onMoveEnd':
        try {
          _mapEventStreamController.add(CameraMoveEndEvent(
              mapId, CameraPosition.fromMap(call.arguments['position'])!));
        } catch (e) {
          print("camera#onMoveEnd error===>$e");
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
          print('map#onPoiTouched error===>$e');
        }
        break;
    }
  }

  /// 移动镜头到一个新的位置
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

  ///截屏
  Future<Uint8List?> takeSnapshot({
    required int mapId,
  }) {
    return channel(mapId).invokeMethod<Uint8List>('map#takeSnapshot');
  }

  Future<void> clearDisk({
    required int mapId,
  }) {
    return channel(mapId).invokeMethod<void>('map#clearDisk');
  }

  Future<ScreenCoordinate> toScreenLocation(
    LatLng latLng, {
    required int mapId,
  }) async {
    final Map<String, int>? point = await channel(mapId)
        .invokeMapMethod<String, int>(
            'map#toScreenCoordinate', latLng.toJson());
    return ScreenCoordinate(x: point!['x']!, y: point['y']!);
  }

  Future<LatLng> fromScreenLocation(
    ScreenCoordinate screenCoordinate, {
    required int mapId,
  }) async {
    final List<dynamic>? latLng = await channel(mapId)
        .invokeMethod<List<dynamic>>(
            'map#fromScreenCoordinate', screenCoordinate.toJson());
    return LatLng(latLng![0] as double, latLng[1] as double);
  }

  Future<String> getMapContentApprovalNumber({
    required int mapId,
  }) async {
    return await channel(mapId)
            .invokeMethod<String>('map#contentApprovalNumber') ??
        '';
  }

  Future<String> getSatelliteImageApprovalNumber({
    required int mapId,
  }) async {
    return await channel(mapId)
            .invokeMethod<String>('map#satelliteImageApprovalNumber') ??
        '';
  }
}
