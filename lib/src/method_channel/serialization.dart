// Copyright 2025 kuloud. All rights reserved.
// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:x_amap_base/x_amap_base.dart' show LatLng;

String _objectsToAddKey(String name) => '${name}sToAdd';
String _objectsToChangeKey(String name) => '${name}sToChange';
String _objectIdsToRemoveKey(String name) => '${name}IdsToRemove';

void _addIfNonNull(Map<String, Object?> map, String fieldName, Object? value) {
  if (value != null) {
    map[fieldName] = value;
  }
}

/// Serialize [LatLng]
Object serializeLatLng(LatLng latLng) {
  return <Object>[latLng.latitude, latLng.longitude];
}

/// Deserialize [LatLng]
LatLng? deserializeLatLng(Object? json) {
  if (json == null) {
    return null;
  }
  assert(json is List && json.length == 2);
  final List<Object?> list = json as List<Object?>;
  return LatLng(list[0]! as double, list[1]! as double);
}
