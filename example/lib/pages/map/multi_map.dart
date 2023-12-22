import 'package:amap_map/amap_map.dart';
import 'package:x_amap_base/x_amap_base.dart';
import 'package:amap_map_example/base_page.dart';
import 'package:flutter/material.dart';

class MultiMapDemoPage extends BasePage {
  MultiMapDemoPage(String title, String subTitle) : super(title, subTitle);
  @override
  Widget build(BuildContext context) {
    return const _MultiMapDemoBody();
  }
}

class _MultiMapDemoBody extends StatefulWidget {
  const _MultiMapDemoBody();
  @override
  State<StatefulWidget> createState() => _MultiMapDemoState();
}

class _MultiMapDemoState extends State<_MultiMapDemoBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(child: AMapWidget()),
          Padding(padding: EdgeInsets.all(5.0)),
          //第二个地图指定初始位置为上海
          Expanded(
              child: AMapWidget(
            initialCameraPosition:
                CameraPosition(target: LatLng(31.230378, 121.473658)),
          )),
        ],
      ),
    );
  }
}
