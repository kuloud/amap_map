import 'package:amap_map/amap_map.dart';
import 'package:amap_map_example/widgets/amap_gridview.dart';
import 'package:amap_map_example/widgets/amap_radio_group.dart';
import 'package:amap_map_example/widgets/amap_switch_button.dart';
import 'package:flutter/material.dart';
import 'package:x_amap_base/x_amap_base.dart';

class MapUIDemoPage extends StatefulWidget {
  MapUIDemoPage({super.key});

  @override
  State<MapUIDemoPage> createState() => _BodyState();
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

  final Map<String, LogoPosition?> _radioValueMap = <String, LogoPosition?>{
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
    final List<Widget> uiOptions = <Widget>[
      AMapSwitchButton(
        label: const Text('显示路况'),
        defaultValue: _trafficEnabled,
        onSwitchChanged: (value) => <void>{
          setState(() {
            _trafficEnabled = value;
          })
        },
      ),
      AMapSwitchButton(
        label: const Text('显示3D建筑物'),
        defaultValue: _buildingsEnabled,
        onSwitchChanged: (value) => <void>{
          setState(() {
            _buildingsEnabled = value;
          })
        },
      ),
      AMapSwitchButton(
        label: const Text('显示指南针'),
        defaultValue: _compassEnabled,
        onSwitchChanged: (value) => <void>{
          setState(() {
            _compassEnabled = value;
          })
        },
      ),
      AMapSwitchButton(
        label: const Text('显示地图文字'),
        defaultValue: _labelsEnabled,
        onSwitchChanged: (value) => <void>{
          setState(() {
            _labelsEnabled = value;
          })
        },
      ),
      AMapSwitchButton(
        label: const Text('显示比例尺'),
        defaultValue: _scaleEnabled,
        onSwitchChanged: (value) => <void>{
          setState(() {
            _scaleEnabled = value;
          })
        },
      ),
    ];

    Widget uiOptionsWidget() {
      return Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('UI操作', style: TextStyle(fontWeight: FontWeight.w600)),
            Container(
              padding: const EdgeInsets.only(left: 10),
              child: AMapGradView(childrenWidgets: uiOptions),
            ),
            AMapRadioGroup<LogoPosition?>(
              groupLabel: 'Logo位置',
              groupValue: _logoPosition,
              radioValueMap: _radioValueMap,
              onChanged: (LogoPosition? value) => <void>{
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

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            child: map,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: uiOptionsWidget(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
