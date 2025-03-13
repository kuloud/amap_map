import 'package:amap_map/amap_map.dart';
import 'package:x_amap_base/x_amap_base.dart';
import 'package:flutter/material.dart';

class MarkerAddAfterMapPage extends StatefulWidget {
  const MarkerAddAfterMapPage({super.key});

  @override
  State<MarkerAddAfterMapPage> createState() => _BodyState();
}

class _BodyState extends State<MarkerAddAfterMapPage> {
  static const LatLng defaultPosition = LatLng(39.909187, 116.397451);
  //需要先设置一个空的map赋值给AMapWidget的markers，否则后续无法添加marker
  final Map<String, Marker> _markers = <String, Marker>{};
  LatLng _currentLatLng = defaultPosition;
  //添加一个marker
  void _addMarker() {
    final LatLng markerPosition =
        LatLng(_currentLatLng.latitude, _currentLatLng.longitude + 2 / 1000);
    final Marker marker = Marker(
      position: markerPosition,
      //使用默认hue的方式设置Marker的图标
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    );
    //调用setState触发AMapWidget的更新，从而完成marker的添加
    setState(() {
      _currentLatLng = markerPosition;
      //将新的marker添加到map里
      _markers[marker.id] = marker;
    });
  }

  TextButton _createMyFloatButton(String label, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
        //文字颜色
        foregroundColor: WidgetStateProperty.all(Colors.white),
        //水波纹颜色
        overlayColor: WidgetStateProperty.all(Colors.blueAccent),
        //背景颜色
        backgroundColor:
            WidgetStateProperty.resolveWith((Set<WidgetState> states) {
          //设置按下时的背景颜色
          if (states.contains(WidgetState.pressed)) {
            return Colors.blueAccent;
          }
          //默认背景颜色
          return Colors.blue;
        }),
      ),
      child: Text(label),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AMapWidget amap = AMapWidget(
      // //创建地图时，给marker属性赋值一个空的set，否则后续无法添加marker
      markers: Set<Marker>.of(_markers.values),
    );
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 10,
            child: amap,
          ),
          Expanded(
            flex: 1,
            child: _createMyFloatButton('添加marker', _addMarker),
          ),
        ],
      ),
    );
  }
}
