// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library;

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:x_amap_base/amap_flutter_base.dart';

export 'package:x_amap_base/amap_flutter_base.dart'
    show
        ArgumentCallback,
        ArgumentCallbacks,
        AssetMapBitmap,
        BitmapDescriptor,
        BytesMapBitmap,
        CameraPosition,
        CameraPositionCallback,
        CameraTargetBounds,
        CameraUpdate,
        Cap,
        Circle,
        CircleId,
        Cluster,
        ClusterManager,
        ClusterManagerId,
        GroundOverlay,
        GroundOverlayId,
        Heatmap,
        HeatmapGradient,
        HeatmapGradientColor,
        HeatmapId,
        HeatmapRadius,
        InfoWindow,
        JointType,
        LatLng,
        LatLngBounds,
        MapBitmapScaling,
        MapStyleException,
        MapType,
        Marker,
        MarkerId,
        MinMaxZoomPreference,
        PatternItem,
        Polygon,
        PolygonId,
        Polyline,
        PolylineId,
        ScreenCoordinate,
        Tile,
        TileOverlay,
        TileOverlayId,
        TileProvider,
        WeightedLatLng,
        AMapApiKey,
        AMapPrivacyStatement;

part 'src/amap_initializer.dart';
part 'src/controller.dart';
part 'src/amap.dart';
