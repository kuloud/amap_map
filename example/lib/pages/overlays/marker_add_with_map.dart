import 'dart:math';

import 'package:amap_map/amap_map.dart';
import 'package:x_amap_base/x_amap_base.dart';
import 'package:flutter/material.dart';

class MarkerAddWithMapPage extends StatefulWidget {
  const MarkerAddWithMapPage({super.key});

  @override
  State<MarkerAddWithMapPage> createState() => _BodyState();
}

class _BodyState extends State<MarkerAddWithMapPage> {
  static const LatLng mapCenter = LatLng(39.909187, 116.397451);
  final Map<MarkerId, Marker> _initMarkerMap = <MarkerId, Marker>{};

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 10; i++) {
      LatLng position = LatLng(mapCenter.latitude + sin(i * pi / 12.0) / 20.0,
          mapCenter.longitude + cos(i * pi / 12.0) / 20.0);
      MarkerId markerId = MarkerId(
          'marker_${DateTime.now().millisecondsSinceEpoch}_${UniqueKey()}');
      Marker marker = Marker(markerId: markerId, position: position);
      _initMarkerMap[markerId] = marker;
    }

    final AMapWidget amap = AMapWidget(
      markers: Set<Marker>.of(_initMarkerMap.values),
    );
    return Container(
      child: amap,
    );
  }
}
