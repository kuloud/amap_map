// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:amap_map/src/compatibility/color_extensions.dart';
import 'package:amap_map/src/types/bitmap.dart';
import 'package:flutter/foundation.dart' show listEquals;
import 'package:flutter/material.dart' show Color;
import 'package:x_amap_base/x_amap_base.dart';
import 'base_overlay.dart';

/// 虚线类型
enum DashLineType {
  /// 不画虚线
  none,

  /// 方块样式
  square,

  /// 圆点样式
  circle,
}

/// 线头类型
enum CapType {
  /// 普通头
  butt,

  /// 扩展头
  square,

  /// 箭头
  arrow,

  /// 圆形头
  round,
}

/// 连接点类型
enum JoinType {
  /// 斜面连接点
  bevel,

  /// 斜接连接点
  miter,

  /// 圆角连接点
  round,
}

/// 线相关的覆盖物类，内部的属性，描述了覆盖物的纹理、颜色、线宽等特征
class Polyline extends BaseOverlay {
  /// 默认构造函数
  Polyline({
    required this.points,
    double width = 10,
    this.visible = true,
    this.geodesic = false,
    double alpha = 1.0,
    this.dashLineType = DashLineType.none,
    this.capType = CapType.butt,
    this.joinType = JoinType.bevel,
    this.customTexture,
    this.onTap,
    this.color = const Color(0xCCC4E0F0),
  })  : assert(points.isNotEmpty),
        width = (width <= 0 ? 10 : width),
        alpha = (alpha < 0 ? 0 : (alpha > 1 ? 1 : alpha)),
        super();

  /// 覆盖物的坐标点数组,points不能为空
  final List<LatLng> points;

  /// 线宽,单位为逻辑像素，同Android中的dp，iOS中的point
  final double width;

  /// 是否可见
  final bool visible;

  /// 透明度
  final double alpha;

  /// 覆盖物颜色，默认值为(0xCCC4E0F0).
  final Color color;

  /// 自定义纹理图片,注意: 如果设置了自定义纹理图片，则color的设置将无效;
  final BitmapDescriptor? customTexture;

  /// 是否为大地曲线
  final bool geodesic;

  /// 虚线类型
  final DashLineType dashLineType;

  /// 连接点类型
  final JoinType joinType;

  /// 线头类型
  final CapType capType;

  /// 点击回调（回调参数为id)
  final ArgumentCallback<String>? onTap;

  /// 实际copy函数
  Polyline copyWith({
    List<LatLng>? pointsParam,
    double? widthParam,
    int? zIndexParam,
    bool? visibleParam,
    double? alphaParam,
    DashLineType? dashLineTypeParam,
    CapType? capTypeParam,
    JoinType? joinTypeParam,
    BitmapDescriptor? customTextureParam,
    ArgumentCallback<String>? onTapParam,
    Color? colorParam,
  }) {
    Polyline copyPolyline = Polyline(
      points: pointsParam ?? points,
      width: widthParam ?? width,
      visible: visibleParam ?? visible,
      geodesic: geodesic,
      alpha: alphaParam ?? alpha,
      dashLineType: dashLineTypeParam ?? dashLineType,
      capType: capTypeParam ?? capType,
      joinType: joinTypeParam ?? joinType,
      customTexture: customTextureParam ?? customTexture,
      onTap: onTapParam ?? onTap,
      color: colorParam ?? color,
    );
    copyPolyline.setIdForCopy(id);
    return copyPolyline;
  }

  @override
  Polyline clone() => copyWith();

  /// 将对象转换为可序列化的map.
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
    addIfPresent('width', width);
    addIfPresent('visible', visible);
    addIfPresent('geodesic', geodesic);
    addIfPresent('alpha', alpha);
    addIfPresent('dashLineType', dashLineType.index);
    addIfPresent('capType', capType.index);
    addIfPresent('joinType', joinType.index);
    addIfPresent('customTexture', customTexture?.toMap());
    addIfPresent('color', color.argbValue);
    return json;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    if (other is! Polyline) return false;
    final Polyline typedOther = other;
    return id == typedOther.id &&
        listEquals(points, typedOther.points) &&
        width == typedOther.width &&
        visible == typedOther.visible &&
        geodesic == typedOther.geodesic &&
        alpha == typedOther.alpha &&
        dashLineType == typedOther.dashLineType &&
        capType == typedOther.capType &&
        joinType == typedOther.joinType &&
        color == typedOther.color;
  }

  dynamic _pointsToJson() {
    final List<dynamic> result = <dynamic>[];
    for (final LatLng point in points) {
      result.add(point.toJson());
    }
    return result;
  }

  @override
  int get hashCode => Object.hashAll(<Object?>[
        id,
        points,
        width,
        visible,
        geodesic,
        alpha,
        dashLineType,
        capType,
        joinType,
        color
      ]);
}

Map<String, Polyline> keyByPolylineId(Iterable<Polyline> polylines) {
  // ignore: unnecessary_null_comparison
  if (polylines == null) {
    return <String, Polyline>{};
  }
  return Map<String, Polyline>.fromEntries(polylines.map((Polyline polyline) =>
      MapEntry<String, Polyline>(polyline.id, polyline.clone())));
}
