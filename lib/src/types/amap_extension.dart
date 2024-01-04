// Copyright 2023-2024 kuloud
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,

import 'package:amap_map/amap_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:x_amap_base/x_amap_base.dart';

/// 插件拓展，绑定[AMapWidget]的生命周期和控制器，实现基于地图的拓展能力（通常是地图交互的可
/// 选功能）
abstract class AMapExtension {
  late String _id;

  String get id => _id;

  AMapExtension() {
    this._id = this.hashCode.toString();
  }

  /// 视图层级变化
  /// since v1.0.4
  void prepare(AMapContext aMapContext) {}

  /// 视图变化
  /// since v1.0.4
  void update(AMapContext aMapContext) {}

  void onDispose() {}

  @Deprecated('使用 bindMapController ，计划在1.0.6移除')
  bindMethodChannel(MethodChannel channel) {}

  /// 注入[AMapController] 方便地图交互
  bindMapController(AMapController controller) {}

  Widget build(AMapContext aMapContext, Widget child) {
    /// 默认传递[AMapWidget]，有部分场景需要在[AMapWidget]外包装容器，根据传递拓展列表顺序
    /// 链式执行
    return child;
  }

  /// since v1.0.4
  onCameraMove(CameraPosition cameraPosition) {}

  /// since v1.0.4
  onCameraMoveEnd(CameraPosition cameraPosition) {}

  /// since v1.0.4
  onLongPress(LatLng latLng) {}

  /// since v1.0.4
  onPoiTouched(AMapPoi poi) {}

  /// since v1.0.4
  onMarkerTap(String value) {}

  /// since v1.0.4
  onMarkerDragEnd(String value) {}

  /// since v1.0.4
  onPolylineTap(String value) {}
}

Map<String, AMapExtension> keyByExtensionId(
    Iterable<AMapExtension> extensions) {
  // ignore: unnecessary_null_comparison
  if (extensions == null) {
    return <String, AMapExtension>{};
  }
  return Map<String, AMapExtension>.fromEntries(extensions.map(
      (AMapExtension extension) =>
          MapEntry<String, AMapExtension>(extension.id, extension)));
}
