// Copyright 2025 kuloud. All rights reserved.
// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:x_amap_base/x_amap_base.dart' show LatLng;

String objectsToAddKey(String name) => '${name}sToAdd';
String objectsToChangeKey(String name) => '${name}sToChange';
String objectIdsToRemoveKey(String name) => '${name}IdsToRemove';

class MapBuilder {
  final Map<String, dynamic> map;

  MapBuilder() : map = <String, dynamic>{};

  void addIfNonNull(String fieldName, dynamic value) {
    if (value != null) {
      map[fieldName] = value;
    }
  }

  void addAllIfNonNull(Map<String, dynamic> values) {
    values.forEach((String key, dynamic value) {
      addIfNonNull(key, value);
    });
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
