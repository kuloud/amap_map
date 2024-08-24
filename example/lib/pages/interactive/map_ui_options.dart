import 'package:amap_map/amap_map.dart';
import 'package:amap_map_example/widgets/amap_gridview.dart';
import 'package:amap_map_example/widgets/amap_radio_group.dart';
import 'package:amap_map_example/widgets/amap_switch_button.dart';
import 'package:flutter/material.dart';
import 'package:x_amap_base/x_amap_base.dart';

class MapUIDemoPage extends StatefulWidget {
  MapUIDemoPage({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<MapUIDemoPage> {
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

  LogoPosition _logoPosition = LogoPosition.BOTTOM_LEFT;
  int _logoBottomMargin = 0;
  int _logoLeftMargin = 0;

  final Map<String, LogoPosition?> _radioValueMap = {
    '底部居左': LogoPosition.BOTTOM_LEFT,
    '底部居中': LogoPosition.BOTTOM_CENTER,
    '底部居右': LogoPosition.BOTTOM_RIGHT,
  };

  @override
  Widget build(BuildContext context) {
    final AMapWidget map = AMapWidget(
      trafficEnabled: _trafficEnabled,
      buildingsEnabled: _buildingsEnabled,
      compassEnabled: _compassEnabled,
      labelsEnabled: _labelsEnabled,
      scaleEnabled: _scaleEnabled,
      logoPosition: _logoPosition,
      logoBottomMargin: _logoBottomMargin,
      logoLeftMargin: _logoLeftMargin,
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
            AMapRadioGroup<LogoPosition?>(
              groupLabel: 'Logo位置',
              groupValue: _logoPosition,
              radioValueMap: _radioValueMap,
              onChanged: (value) => {
                //改变当前地图样式为选中的样式
                setState(() {
                  _logoPosition = value!;
                })
              },
            ),
            Text('Logo底部边距: $_logoBottomMargin'),
            Slider(
              value: _logoBottomMargin.toDouble(),
              min: 0,
              max: 100,
              divisions: 100,
              label: _logoBottomMargin.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _logoBottomMargin = value.round();
                });
              },
            ),
            Text('Logo左侧边距: $_logoLeftMargin'),
            Slider(
              value: _logoLeftMargin.toDouble(),
              min: 0,
              max: 100,
              divisions: 100,
              label: _logoLeftMargin.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _logoLeftMargin = value.round();
                });
              },
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
            height: MediaQuery.of(context).size.height * 0.5,
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
