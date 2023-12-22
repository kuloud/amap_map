import 'package:amap_map_example/base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:amap_map/amap_map.dart';
import 'package:amap_map/amap_map.dart';

class PolylineGeodesicDemoPage extends BasePage {
  PolylineGeodesicDemoPage(String title, String subTitle)
      : super(title, subTitle);
  @override
  Widget build(BuildContext context) {
    return _Body();
  }
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<_Body> {
  _State();

// Values when toggling polyline color
  int colorsIndex = 0;
  List<Color> colors = <Color>[
    Colors.purple,
    Colors.red,
    Colors.green,
    Colors.pink,
  ];
  Map<String, Polyline> _polylines = <String, Polyline>{};
  late String selectedPolylineId;
  AMapController? _controller;

  void _onMapCreated(AMapController controller) {
    _controller = controller;
  }

  List<LatLng> _createPoints() {
    final List<LatLng> points = <LatLng>[];
    final int polylineCount = _polylines.length;
    final int offset = polylineCount * (-1);
    points.add(LatLng(39.905151 + offset, 116.401726));
    points.add(LatLng(38.905151 + offset, 70.401726));
    return points;
  }

  void _add() {
    final Polyline polyline = Polyline(
        color: colors[++colorsIndex % colors.length],
        width: 10,
        geodesic: true,
        points: _createPoints());

    setState(() {
      _polylines[polyline.id] = polyline;
    });
    //移动到合适的范围
    LatLngBounds bound =
        LatLngBounds(southwest: LatLng(25.0, 70.0), northeast: LatLng(45, 117));
    CameraUpdate update = CameraUpdate.newLatLngBounds(bound, 10);
    _controller?.moveCamera(update);
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
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
                  //文字颜色
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  //水波纹颜色
                  overlayColor: MaterialStateProperty.all(Colors.blueAccent),
                  //背景颜色
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    //设置按下时的背景颜色
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.blueAccent;
                    }
                    //默认背景颜色
                    return Colors.blue;
                  }),
                ),
                child: Text('添加大地曲线'),
              )),
        ],
      ),
    );
  }
}
