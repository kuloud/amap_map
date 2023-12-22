// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui' show hashValues;

import 'package:flutter/foundation.dart' show setEquals;
import 'types.dart';

/// 该类主要用以描述[Polygon]的增删改等更新操作
class PolygonUpdates {
  /// 通过Polygon的前后更新集合构造一个PolygonUpdates
  PolygonUpdates.from(Set<Polygon> previous, Set<Polygon> current) {
    // ignore: unnecessary_null_comparison
    if (previous == null) {
      previous = Set<Polygon>.identity();
    }

    // ignore: unnecessary_null_comparison
    if (current == null) {
      current = Set<Polygon>.identity();
    }

    final Map<String, Polygon> previousPolygons = keyByPolygonId(previous);
    final Map<String, Polygon> currentPolygons = keyByPolygonId(current);

    final Set<String> prevPolygonIds = previousPolygons.keys.toSet();
    final Set<String> currentPolygonIds = currentPolygons.keys.toSet();

    Polygon idToCurrentPolygon(String id) {
      return currentPolygons[id]!;
    }

    final Set<String> _polygonIdsToRemove =
        prevPolygonIds.difference(currentPolygonIds);

    final Set<Polygon> _polygonsToAdd = currentPolygonIds
        .difference(prevPolygonIds)
        .map(idToCurrentPolygon)
        .toSet();

    bool hasChanged(Polygon current) {
      final Polygon previous = previousPolygons[current.id]!;
      return current != previous;
    }

    final Set<Polygon> _polygonsToChange = currentPolygonIds
        .intersection(prevPolygonIds)
        .map(idToCurrentPolygon)
        .where(hasChanged)
        .toSet();

    polygonsToAdd = _polygonsToAdd;
    polygonIdsToRemove = _polygonIdsToRemove;
    polygonsToChange = _polygonsToChange;
  }

  /// 想要添加的polygon对象集合.
  Set<Polygon>? polygonsToAdd;

  /// 想要删除的polygon的id集合
  Set<String>? polygonIdsToRemove;

  /// 想要更新的polygon对象集合
  Set<Polygon>? polygonsToChange;

  /// 转换成可以序列化的map
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> updateMap = <String, dynamic>{};

    void addIfNonNull(String fieldName, dynamic value) {
      if (value != null) {
        updateMap[fieldName] = value;
      }
    }

    addIfNonNull('polygonsToAdd', serializeOverlaySet(polygonsToAdd!));
    addIfNonNull('polygonsToChange', serializeOverlaySet(polygonsToChange!));
    addIfNonNull('polygonIdsToRemove', polygonIdsToRemove?.toList());

    return updateMap;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    if (other is !PolygonUpdates) return false;
    final PolygonUpdates typedOther = other;
    return setEquals(polygonsToAdd, typedOther.polygonsToAdd) &&
        setEquals(polygonIdsToRemove, typedOther.polygonIdsToRemove) &&
        setEquals(polygonsToChange, typedOther.polygonsToChange);
  }

  @override
  int get hashCode =>
      hashValues(polygonsToAdd, polygonIdsToRemove, polygonsToChange);

  @override
  String toString() {
    return '_PolygonUpdates{polygonsToAdd: $polygonsToAdd, '
        'polygonIdsToRemove: $polygonIdsToRemove, '
        'polygonsToChange: $polygonsToChange}';
  }
}
