// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui' show Offset;
import 'package:amap_map/src/types/base_overlay.dart';
import 'package:x_amap_base/x_amap_base.dart';
import 'bitmap.dart';

/// Marker拖动回调
typedef MarkerDragEndCallback = void Function(String id, LatLng endPosition);

///Marker的气泡
///
///Android和iOS的实现机制有差异，仅在接口层面拉齐，效果一致
class InfoWindow {
  /// 为 [Marker] 产生一个不可修改的文本气泡.
  const InfoWindow({
    this.title,
    this.snippet,
  });

  /// 无文本的气泡
  static const InfoWindow noText = InfoWindow();

  /// 气泡的title
  final String? title;

  /// 气泡的详细信息
  final String? snippet;

  /// 气泡copy方法
  ///
  InfoWindow copyWith({
    String? titleParam,
    String? snippetParam,
  }) {
    return InfoWindow(
      title: titleParam ?? title,
      snippet: snippetParam ?? snippet,
    );
  }

  Map<String, dynamic> _toMap() {
    final Map<String, dynamic> json = <String, dynamic>{};

    void addIfPresent(String fieldName, dynamic value) {
      if (value != null) {
        json[fieldName] = value;
      }
    }

    addIfPresent('title', title);
    addIfPresent('snippet', snippet);
    return json;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    if (other is! InfoWindow) {
      return false;
    }
    final InfoWindow typedOther = other;
    return title == typedOther.title && snippet == typedOther.snippet;
  }

  @override
  int get hashCode => Object.hashAll(<Object?>[title, snippet]);

  @override
  String toString() {
    return 'InfoWindow{title: $title, snippet: $snippet}';
  }
}

/// 点覆盖物的类
class Marker extends BaseOverlay {
  Marker({
    required this.position,
    double alpha = 1.0,
    Offset anchor = const Offset(0.5, 1.0),
    this.clickable = true,
    this.draggable = false,
    this.icon = BitmapDescriptor.defaultMarker,
    this.infoWindowEnable = true,
    this.infoWindow = InfoWindow.noText,
    this.rotation = 0.0,
    this.visible = true,
    this.zIndex = 0.0,
    this.onTap,
    this.onDragEnd,
  })  : alpha =
            // ignore: unnecessary_null_comparison
            (alpha != null ? (alpha < 0 ? 0 : (alpha > 1 ? 1 : alpha)) : alpha),
        // ignore: unnecessary_null_comparison
        anchor = (anchor == null
            ? const Offset(0.5, 1.0)
            : ((anchor.dx < 0 ||
                    anchor.dx > 1 ||
                    anchor.dy < 0 ||
                    anchor.dy > 1)
                ? const Offset(0.5, 1.0)
                : anchor)),
        super();

  /// 透明度
  final double alpha;

  /// 覆盖物视图相对地图上的经纬度位置的锚点
  final Offset anchor;

  /// 是否可点击，默认为true
  final bool clickable;

  /// 是否可拖拽，默认为false
  final bool draggable;

  /// 覆盖物的图标
  final BitmapDescriptor icon;

  /// 是否显示气泡，如果为true,则点击[Marker]后，会显示该气泡[InfoWindow]
  /// 如果为false,则始终不会显示该气泡
  final bool infoWindowEnable;

  /// 覆盖物上的气泡，当被点击时，如果infoWindowEnable为true,则会显示出来
  final InfoWindow infoWindow;

  /// 位置,不能为空
  final LatLng position;

  /// 旋转角度,以锚点为中心,顺时针旋转（单位：度数）
  ///
  /// 注意：iOS端目前仅支持绕marker中心点旋转
  final double rotation;

  /// 是否可见
  final bool visible;

  /// z轴的值，用于调整该覆盖物的相对绘制层级关系
  /// 值越小，图层越靠下，iOS该值不支持动态修改,仅能在初始化时指定
  final double zIndex;

  /// 回调的参数是对应的id
  final ArgumentCallback<String>? onTap;

  /// Marker被拖拽结束的回调
  final MarkerDragEndCallback? onDragEnd;

  /// copy的真正复制的参数，主要用于需要修改某个属性参数时使用
  Marker copyWith({
    double? alphaParam,
    Offset? anchorParam,
    bool? clickableParam,
    bool? draggableParam,
    BitmapDescriptor? iconParam,
    bool? infoWindowEnableParam,
    InfoWindow? infoWindowParam,
    LatLng? positionParam,
    double? rotationParam,
    bool? visibleParam,
    ArgumentCallback<String?>? onTapParam,
    MarkerDragEndCallback? onDragEndParam,
  }) {
    Marker copyMark = Marker(
      alpha: alphaParam ?? alpha,
      anchor: anchorParam ?? anchor,
      clickable: clickableParam ?? clickable,
      draggable: draggableParam ?? draggable,
      icon: iconParam ?? icon,
      infoWindowEnable: infoWindowEnableParam ?? infoWindowEnable,
      infoWindow: infoWindowParam ?? infoWindow,
      position: positionParam ?? position,
      rotation: rotationParam ?? rotation,
      visible: visibleParam ?? visible,
      zIndex: zIndex,
      onTap: onTapParam ?? onTap,
      onDragEnd: onDragEndParam ?? onDragEnd,
    );
    copyMark.setIdForCopy(id);
    return copyMark;
  }

  @override
  Marker clone() => copyWith();

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> json = <String, dynamic>{};

    void addIfPresent(String fieldName, dynamic value) {
      if (value != null) {
        json[fieldName] = value;
      }
    }

    addIfPresent('id', id);
    addIfPresent('alpha', alpha);
    addIfPresent('anchor', _offsetToJson(anchor));
    addIfPresent('clickable', clickable);
    addIfPresent('draggable', draggable);
    addIfPresent('icon', icon.toMap());
    addIfPresent('infoWindowEnable', infoWindowEnable);
    addIfPresent('infoWindow', infoWindow._toMap());
    addIfPresent('position', position.toJson());
    addIfPresent('rotation', rotation);
    addIfPresent('visible', visible);
    addIfPresent('zIndex', zIndex);
    return json;
  }

  dynamic _offsetToJson(Offset offset) {
    return <dynamic>[offset.dx, offset.dy];
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    if (other is! Marker) return false;
    final Marker typedOther = other;
    return id == typedOther.id &&
        alpha == typedOther.alpha &&
        anchor == typedOther.anchor &&
        clickable == typedOther.clickable &&
        draggable == typedOther.draggable &&
        icon == typedOther.icon &&
        infoWindowEnable == typedOther.infoWindowEnable &&
        infoWindow == typedOther.infoWindow &&
        position == typedOther.position &&
        rotation == typedOther.rotation &&
        visible == typedOther.visible &&
        zIndex == typedOther.zIndex;
  }

  @override
  String toString() {
    return 'Marker{id: $id, alpha: $alpha, anchor: $anchor, '
        'clickable: $clickable, draggable: $draggable,'
        'icon: $icon, infoWindowEnable: $infoWindowEnable, infoWindow: $infoWindow, position: $position, rotation: $rotation, '
        'visible: $visible, zIndex: $zIndex, onTap: $onTap}';
  }

  @override
  int get hashCode => Object.hashAll(<Object?>[
        id,
        alpha,
        anchor,
        clickable,
        draggable,
        icon,
        infoWindowEnable,
        infoWindow,
        position,
        rotation,
        visible,
        zIndex
      ]);
}

Map<String, Marker> keyByMarkerId(Iterable<Marker> markers) {
  return Map<String, Marker>.fromEntries(markers.map(
      (Marker marker) => MapEntry<String, Marker>(marker.id, marker.clone())));
}
