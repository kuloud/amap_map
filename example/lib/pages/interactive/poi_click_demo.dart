import 'package:amap_map/amap_map.dart';
import 'package:x_amap_base/x_amap_base.dart';
import 'package:flutter/material.dart';

class PoiClickDemoPage extends StatefulWidget {
  PoiClickDemoPage({super.key});

  @override
  State<PoiClickDemoPage> createState() => _BodyState();
}

class _BodyState extends State<PoiClickDemoPage> {
  Widget? _poiInfo;
  @override
  Widget build(BuildContext context) {
    final AMapWidget amap = AMapWidget(
      touchPoiEnabled: true,
      onPoiTouched: _onPoiTouched,
    );
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: amap,
          ),
          Positioned(
            top: 40,
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Container(
              child: _poiInfo,
            ),
          )
        ],
      ),
    );
  }

  Widget showPoiInfo(AMapPoi poi) {
    return Container(
      alignment: Alignment.center,
      color: Color(0x8200CCFF),
      child: Text(
        '您点击了 ${poi.name}',
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  void _onPoiTouched(AMapPoi poi) {
    setState(() {
      _poiInfo = showPoiInfo(poi);
    });
  }
}
