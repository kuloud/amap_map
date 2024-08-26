import 'package:amap_map/amap_map.dart';
import 'package:amap_map_example/widgets/amap_switch_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomMapStylePage extends StatefulWidget {
  CustomMapStylePage({super.key});

  @override
  State<CustomMapStylePage> createState() => _CustomMapStyleState();
}

class _CustomMapStyleState extends State<CustomMapStylePage> {
  bool _mapCreated = false;

  final CustomStyleOptions _customStyleOptions = CustomStyleOptions(false);
  //加载自定义地图样式
  void _loadCustomData() async {
    ByteData styleByteData = await rootBundle.load('assets/style.data');
    _customStyleOptions.styleData = styleByteData.buffer.asUint8List();
    ByteData styleExtraByteData =
        await rootBundle.load('assets/style_extra.data');
    _customStyleOptions.styleExtraData =
        styleExtraByteData.buffer.asUint8List();
    //如果需要加载完成后直接展示自定义地图，可以通过setState修改CustomStyleOptions的enable为true
    setState(() {
      _customStyleOptions.enabled = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCustomData();
  }

  @override
  Widget build(BuildContext context) {
    final AMapWidget map = AMapWidget(
      onMapCreated: onMapCreated,
      customStyleOptions: _customStyleOptions,
    );
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: map,
          ),
          Positioned(
            top: 30,
            child: Container(
              color: Color(0xFF00BFFF),
              child: AMapSwitchButton(
                label: Text(
                  '自定义地图',
                  style: TextStyle(color: Colors.white),
                ),
                defaultValue: _customStyleOptions.enabled,
                onSwitchChanged: (value) => {
                  if (_mapCreated)
                    {
                      setState(() {
                        _customStyleOptions.enabled = value;
                      })
                    }
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  void onMapCreated(AMapController controller) {
    _mapCreated = true;
  }
}
