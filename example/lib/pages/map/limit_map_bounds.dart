import 'package:amap_map/amap_map.dart';
import 'package:x_amap_base/x_amap_base.dart';
import 'package:flutter/material.dart';

class LimitMapBoundsPage extends StatefulWidget {
  LimitMapBoundsPage({super.key});

  @override
  State<LimitMapBoundsPage> createState() => _BodyState();
}

class _BodyState extends State<LimitMapBoundsPage> {
  @override
  Widget build(BuildContext context) {
    final AMapWidget amap = AMapWidget(
      limitBounds: LatLngBounds(
          southwest: LatLng(39.83309, 116.290176),
          northeast: LatLng(39.99951, 116.501663)),
    );
    return Container(
      child: amap,
    );
  }
}
