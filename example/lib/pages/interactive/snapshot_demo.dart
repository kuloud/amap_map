import 'dart:typed_data';

import 'package:amap_map/amap_map.dart';
import 'package:amap_map_example/base_page.dart';
import 'package:amap_map_example/const_config.dart';
import 'package:flutter/material.dart';

class SnapshotPage extends BasePage {
  SnapshotPage(String title, String subTitle) : super(title, subTitle);
  @override
  Widget build(BuildContext context) {
    return _SnapShotBody();
  }
}

class _SnapShotBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SnapShotState();
}

class _SnapShotState extends State<_SnapShotBody> {
  AMapController? _mapController;
  Uint8List? _imageBytes;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: AMapWidget(
              onMapCreated: _onMapCreated,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: SizedBox(
              height: 40,
              width: 100,
              child: TextButton(
                child: Text('截屏'),
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
                onPressed: () async {
                  final imageBytes = await _mapController?.takeSnapshot();
                  setState(() {
                    _imageBytes = imageBytes;
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.blueGrey[50]),
              child: _imageBytes != null ? Image.memory(_imageBytes!) : null,
            ),
          ),
        ],
      ),
    );
  }

  _onMapCreated(AMapController controller) {
    _mapController = controller;
  }
}
