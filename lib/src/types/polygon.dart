// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:amap_map/src/compatibility/color_extensions.dart';
import 'package:flutter/foundation.dart' show listEquals;
import 'package:flutter/material.dart' show Color;
import 'package:x_amap_base/x_amap_base.dart';
import 'base_overlay.dart';
import 'polyline.dart';

/// 线相关的覆盖物类，内部的属性，描述了覆盖物的纹理、颜色、线宽等特征
class Polygon extends BaseOverlay {
  /// 默认构造函数
  Polygon(
      {required this.points,
      double strokeWidth = 10,
      this.strokeColor = const Color(0xCC00BFFF),
      this.fillColor = const Color(0xC487CEFA),
      this.visible = true,
      this.joinType = JoinType.bevel})
      : assert(points.isNotEmpty),
        strokeWidth = (strokeWidth <= 0 ? 10 : strokeWidth),
        super();

  /// 覆盖物的坐标点数组,不能为空
  final List<LatLng> points;

  /// 边框宽度,单位为逻辑像素，同Android中的dp，iOS中的point
  final double strokeWidth;

  /// 边框颜色,默认值为(0xCCC4E0F0)
  final Color strokeColor;

  /// 填充颜色,默认值为(0xC4E0F0CC)
  final Color fillColor;

  /// 是否可见
  final bool visible;

  /// 连接点类型,该参数不支持copy时修改，仅能在初始化时设置一次
  final JoinType joinType;

  /// 实际copy函数
  Polygon copyWith({
    List<LatLng>? pointsParam,
    double? strokeWidthParam,
    Color? strokeColorParam,
    Color? fillColorParam,
    bool? visibleParam,
  }) {
    Polygon copyPolyline = Polygon(
      points: pointsParam ?? points,
      strokeWidth: strokeWidthParam ?? strokeWidth,
      strokeColor: strokeColorParam ?? strokeColor,
      fillColor: fillColorParam ?? fillColor,
      visible: visibleParam ?? visible,
      joinType: joinType,
    );
    copyPolyline.setIdForCopy(id);
    return copyPolyline;
  }

  @override
  Polygon clone() => copyWith();

  /// 转换成可以序列化的map
  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> json = <String, dynamic>{};

    void addIfPresent(String fieldName, dynamic value) {
      if (value != null) {
        json[fieldName] = value;
      }
    }

    addIfPresent('id', id);
    json['points'] = _pointsToJson();
    addIfPresent('strokeWidth', strokeWidth);
    addIfPresent('strokeColor', strokeColor.argbValue);
    addIfPresent('fillColor', fillColor.argbValue);
    addIfPresent('visible', visible);
    addIfPresent('joinType', joinType.index);
    return json;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    if (other is! Polygon) return false;
    final Polygon typedOther = other;
    return id == typedOther.id &&
        listEquals(points, typedOther.points) &&
        strokeWidth == typedOther.strokeWidth &&
        strokeColor == typedOther.strokeColor &&
        fillColor == typedOther.fillColor &&
        visible == typedOther.visible &&
        joinType == typedOther.joinType;
  }

  @override
  int get hashCode => Object.hashAll(<Object?>[
        id,
        points,
        strokeWidth,
        strokeColor,
        fillColor,
        visible,
        joinType
      ]);

  dynamic _pointsToJson() {
    final List<dynamic> result = <dynamic>[];
    for (final LatLng point in points) {
      result.add(point.toJson());
    }
    return result;
  }
}

Map<String, Polygon> keyByPolygonId(Iterable<Polygon> polylines) {
  // ignore: unnecessary_null_comparison
  if (polylines == null) {
    return <String, Polygon>{};
  }
  return Map<String, Polygon>.fromEntries(polylines.map((Polygon polyline) =>
      MapEntry<String, Polygon>(polyline.id, polyline.clone())));
}
