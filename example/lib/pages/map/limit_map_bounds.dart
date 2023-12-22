import 'package:amap_map/amap_map.dart';
import 'package:amap_map/amap_map.dart';
import 'package:amap_map_example/base_page.dart';
import 'package:amap_map_example/const_config.dart';
import 'package:flutter/material.dart';

class LimitMapBoundsPage extends BasePage {
  LimitMapBoundsPage(String title, String subTitle) : super(title, subTitle);

  @override
  Widget build(BuildContext context) => _Body();
}

class _Body extends StatefulWidget {
  _Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    final AMapWidget amap = AMapWidget(
      apiKey: ConstConfig.amapApiKeys,
      limitBounds: LatLngBounds(
          southwest: LatLng(39.83309, 116.290176),
          northeast: LatLng(39.99951, 116.501663)),
    );
    return Container(
      child: amap,
    );
  }
}
