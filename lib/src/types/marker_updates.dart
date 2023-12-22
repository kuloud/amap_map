import 'dart:ui' show hashValues;

import 'package:flutter/foundation.dart' show setEquals;

import 'types.dart';
import 'marker.dart';

/// 用以描述Marker的更新项
class MarkerUpdates {
  /// 根据之前的marker列表[previous]和当前的marker列表[current]创建[MakerUpdates].
  MarkerUpdates.from(Set<Marker> previous, Set<Marker> current) {
    // ignore: unnecessary_null_comparison
    if (previous == null) {
      previous = Set<Marker>.identity();
    }

    // ignore: unnecessary_null_comparison
    if (current == null) {
      current = Set<Marker>.identity();
    }

    final Map<String, Marker> previousMarkers = keyByMarkerId(previous);
    final Map<String, Marker> currentMarkers = keyByMarkerId(current);

    final Set<String> prevMarkerIds = previousMarkers.keys.toSet();
    final Set<String> currentMarkerIds = currentMarkers.keys.toSet();

    Marker idToCurrentMarker(String id) {
      return currentMarkers[id]!;
    }

    final Set<String> _markerIdsToRemove =
        prevMarkerIds.difference(currentMarkerIds);

    final Set<Marker> _markersToAdd = currentMarkerIds
        .difference(prevMarkerIds)
        .map(idToCurrentMarker)
        .toSet();

    bool hasChanged(Marker current) {
      final Marker? previous = previousMarkers[current.id];
      return current != previous;
    }

    final Set<Marker> _markersToChange = currentMarkerIds
        .intersection(prevMarkerIds)
        .map(idToCurrentMarker)
        .where(hasChanged)
        .toSet();

    markersToAdd = _markersToAdd;
    markerIdsToRemove = _markerIdsToRemove;
    markersToChange = _markersToChange;
  }

  /// 想要添加的marker集合.
  Set<Marker>? markersToAdd;

  /// 想要删除的marker的id集合
  Set<String>? markerIdsToRemove;

  /// 想要更新的marker集合.
  Set<Marker>? markersToChange;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> updateMap = <String, dynamic>{};

    void addIfNonNull(String fieldName, dynamic value) {
      if (value != null) {
        updateMap[fieldName] = value;
      }
    }

    addIfNonNull('markersToAdd', serializeOverlaySet(markersToAdd!));
    addIfNonNull('markersToChange', serializeOverlaySet(markersToChange!));
    addIfNonNull('markerIdsToRemove', markerIdsToRemove?.toList());

    return updateMap;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    if(other is !MarkerUpdates) return false;
    final MarkerUpdates typedOther = other;
    return setEquals(markersToAdd, typedOther.markersToAdd) &&
        setEquals(markerIdsToRemove, typedOther.markerIdsToRemove) &&
        setEquals(markersToChange, typedOther.markersToChange);
  }

  @override
  int get hashCode =>
      hashValues(markersToAdd, markerIdsToRemove, markersToChange);

  @override
  String toString() {
    return '_MarkerUpdates{markersToAdd: $markersToAdd, '
        'markerIdsToRemove: $markerIdsToRemove, '
        'markersToChange: $markersToChange}';
  }
}
