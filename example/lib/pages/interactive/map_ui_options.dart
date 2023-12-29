import 'package:amap_map/amap_map.dart';
import 'package:amap_map_example/base_page.dart';
import 'package:amap_map_example/const_config.dart';
import 'package:amap_map_example/widgets/amap_gridview.dart';
import 'package:amap_map_example/widgets/amap_switch_button.dart';
import 'package:flutter/material.dart';

class MapUIDemoPage extends BasePage {
  MapUIDemoPage(String title, String subTitle) : super(title, subTitle);

  @override
  Widget build(BuildContext context) => _Body();
}

class _Body extends StatefulWidget {
  _Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  ///显示路况开关
  bool _trafficEnabled = false;

  ///是否显示3D建筑物
  bool _buildingsEnabled = true;

  ///是否显示底图文字标注
  bool _labelsEnabled = true;

  ///是否显示指南针
  bool _compassEnabled = false;

  ///是否显示比例尺
  bool _scaleEnabled = true;

  @override
  Widget build(BuildContext context) {
    final AMapWidget map = AMapWidget(
      trafficEnabled: _trafficEnabled,
      buildingsEnabled: _buildingsEnabled,
      compassEnabled: _compassEnabled,
      labelsEnabled: _labelsEnabled,
      scaleEnabled: _scaleEnabled,
    );

    //ui控制
    final List<Widget> _uiOptions = [
      AMapSwitchButton(
        label: Text('显示路况'),
        defaultValue: _trafficEnabled,
        onSwitchChanged: (value) => {
          setState(() {
            _trafficEnabled = value;
          })
        },
      ),
      AMapSwitchButton(
        label: Text('显示3D建筑物'),
        defaultValue: _buildingsEnabled,
        onSwitchChanged: (value) => {
          setState(() {
            _buildingsEnabled = value;
          })
        },
      ),
      AMapSwitchButton(
        label: Text('显示指南针'),
        defaultValue: _compassEnabled,
        onSwitchChanged: (value) => {
          setState(() {
            _compassEnabled = value;
          })
        },
      ),
      AMapSwitchButton(
        label: Text('显示地图文字'),
        defaultValue: _labelsEnabled,
        onSwitchChanged: (value) => {
          setState(() {
            _labelsEnabled = value;
          })
        },
      ),
      AMapSwitchButton(
        label: Text('显示比例尺'),
        defaultValue: _scaleEnabled,
        onSwitchChanged: (value) => {
          setState(() {
            _scaleEnabled = value;
          })
        },
      ),
    ];

    Widget _uiOptionsWidget() {
      return Container(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('UI操作', style: TextStyle(fontWeight: FontWeight.w600)),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: AMapGradView(childrenWidgets: _uiOptions),
            ),
          ],
        ),
      );
    }

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width,
            child: map,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: _uiOptionsWidget(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
