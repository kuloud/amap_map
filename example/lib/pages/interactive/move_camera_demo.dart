import 'package:amap_map/amap_map.dart';
import 'package:x_amap_base/x_amap_base.dart';
import 'package:amap_map_example/base_page.dart';
import 'package:amap_map_example/const_config.dart';
import 'package:amap_map_example/widgets/amap_gridview.dart';
import 'package:flutter/material.dart';

class MoveCameraDemoPage extends BasePage {
  MoveCameraDemoPage(String title, String subTitle) : super(title, subTitle);

  @override
  Widget build(BuildContext context) => _Body();
}

class _Body extends StatefulWidget {
  _Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  AMapController? _mapController;
  String? _currentZoom;
  @override
  Widget build(BuildContext context) {
    final AMapWidget amap = AMapWidget(
      apiKey: ConstConfig.amapApiKeys,
      onMapCreated: _onMapCreated,
      onCameraMove: _onCameraMove,
      onCameraMoveEnd: _onCameraMoveEnd,
    );
    List<Widget> _optionsWidget = [
      _createMyFloatButton('改变显示区域', _changeLatLngBounds),
      _createMyFloatButton('改变中心点', _changeCameraPosition),
      _createMyFloatButton('改变缩放级别到18', _changeCameraZoom),
      _createMyFloatButton('按照像素移动地图', _scrollBy),
    ];

    Widget _cameraOptions() {
      return Container(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: AMapGradView(
                childrenWidgets: _optionsWidget,
              ),
            ),
          ],
        ),
      );
    }

    return ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
                  minHeight: MediaQuery.of(context).size.height * 0.7),
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width,
                    child: amap,
                  ),
                  Positioned(
                    right: 5,
                    bottom: 5,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkResponse(
                          child: Container(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                            width: 40,
                            height: 40,
                            color: Colors.blue,
                          ),
                          onTap: _zoomIn,
                        ),
                        InkResponse(
                          child: Container(
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                            color: Colors.blue,
                            width: 40,
                            height: 40,
                          ),
                          onTap: _zoomOut,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _currentZoom != null
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey,
                            padding: EdgeInsets.all(5),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _currentZoom!,
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : SizedBox(),
                    Container(
                      child: _cameraOptions(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  void _onMapCreated(AMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

  //移动视野
  void _onCameraMove(CameraPosition cameraPosition) {}

  //移动地图结束
  void _onCameraMoveEnd(CameraPosition cameraPosition) {
    setState(() {
      _currentZoom = '当前缩放级别：${cameraPosition.zoom}';
    });
  }

  void _changeCameraPosition() {
    _mapController?.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            //中心点
            target: LatLng(31.230378, 121.473658),
            //缩放级别
            zoom: 13,
            //俯仰角0°~45°（垂直与地图时为0）
            tilt: 30,
            //偏航角 0~360° (正北方为0)
            bearing: 0),
      ),
      animated: true,
    );
  }

  //改变显示级别
  void _changeCameraZoom() {
    _mapController?.moveCamera(
      CameraUpdate.zoomTo(18),
      animated: true,
    );
  }

  //级别加1
  void _zoomIn() {
    _mapController?.moveCamera(
      CameraUpdate.zoomIn(),
      animated: true,
    );
  }

  //级别减1
  void _zoomOut() {
    _mapController?.moveCamera(
      CameraUpdate.zoomOut(),
      animated: true,
    );
  }

  //改变显示区域
  void _changeLatLngBounds() {
    _mapController?.moveCamera(
      CameraUpdate.newLatLngBounds(
          LatLngBounds(
              southwest: LatLng(33.789925, 104.838326),
              northeast: LatLng(38.740688, 114.647472)),
          15.0),
      animated: true,
    );
  }

  //按照像素移动
  void _scrollBy() {
    _mapController?.moveCamera(
      CameraUpdate.scrollBy(50, 50),
      animated: true,
      duration: 1000,
    );
  }

  TextButton _createMyFloatButton(String label, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
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
      child: Text(label),
    );
  }
}
