import 'package:amap_map/amap_map.dart';
import 'package:flutter/material.dart';

import 'package:x_amap_base/x_amap_base.dart';

class PolylineTextureDemoPage extends StatefulWidget {
  const PolylineTextureDemoPage();

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<PolylineTextureDemoPage> {
  _State();

  final Map<String, Polyline> _polylines = <String, Polyline>{};
  late String selectedPolylineId;

  void _onMapCreated(AMapController controller) {}

  List<LatLng> _createPoints() {
    final List<LatLng> points = <LatLng>[];
    final int polylineCount = _polylines.length;
    final double offset = polylineCount * -(0.01);
    points.add(LatLng(39.938698 + offset, 116.275177));
    points.add(LatLng(39.966069 + offset, 116.289253));
    points.add(LatLng(39.944226 + offset, 116.306076));
    points.add(LatLng(39.966069 + offset, 116.322899));
    points.add(LatLng(39.938698 + offset, 116.336975));
    return points;
  }

  void _add() {
    final Polyline polyline = Polyline(
        width: 20,
        customTexture:
            BitmapDescriptor.fromIconPath('assets/texture_green.png'),
        joinType: JoinType.round,
        points: _createPoints());

    setState(() {
      _polylines[polyline.id] = polyline;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AMapWidget map = AMapWidget(
      onMapCreated: _onMapCreated,
      polylines: Set<Polyline>.of(_polylines.values),
    );

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 10,
            child: map,
          ),
          Expanded(
              flex: 1,
              child: TextButton(
                onPressed: _add,
                style: ButtonStyle(
                  shape: WidgetStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
                  //文字颜色
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                  //水波纹颜色
                  overlayColor: WidgetStateProperty.all(Colors.blueAccent),
                  //背景颜色
                  backgroundColor: WidgetStateProperty.resolveWith((states) {
                    //设置按下时的背景颜色
                    if (states.contains(WidgetState.pressed)) {
                      return Colors.blueAccent;
                    }
                    //默认背景颜色
                    return Colors.blue;
                  }),
                ),
                child: Text('添加纹理线'),
              )),
        ],
      ),
    );
  }
}
