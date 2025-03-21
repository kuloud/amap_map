// Copyright 2025 kuloud. All rights reserved.
// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';

import 'types.dart';

/// A container object for all the types of maps objects.
///
/// This is intended for use as a parameter in platform interface methods, to
/// allow adding new object types to existing methods.
@immutable
class MapObjects {
  /// Creates a new set of map objects with all the given object types.
  const MapObjects({
    this.markers = const <Marker>{},
    this.polygons = const <Polygon>{},
    this.polylines = const <Polyline>{},
  });

  final Set<Marker> markers;
  final Set<Polygon> polygons;
  final Set<Polyline> polylines;
}
