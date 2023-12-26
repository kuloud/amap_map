# amap_map
[![pub package](https://img.shields.io/pub/v/amap_map.svg)](https://pub.dev/packages/amap_map)

基于[高德开放平台地图SDK](https://lbs.amap.com/api/)的flutter插件

|             | Android | iOS   |
|-------------|---------|-------|
| **AMapSDK** | 9.8.3 | 9.7.0 | 
| **Support** | SDK 16+ | 11.0+ | 


## Usage
使用Flutter插件，请参考[在Flutter里使用Packages](https://flutter.cn/docs/development/packages-and-plugins/using-packages), 添加`amap_map`的引用
```bash
flutter pub add amap_map
```

## Prepare
* 登录[高德开放平台官网](https://lbs.amap.com/)申请ApiKey。Android平台申请配置key请参考[Android获取key](https://lbs.amap.com/api/poi-sdk-android/develop/create-project/get-key/?sug_index=2), iOS平台申请配置请参考[iOS获取key](https://lbs.amap.com/api/poi-sdk-ios/develop/create-project/get-key/?sug_index=1)。


## Demo
``` Dart
import 'package:amap_map_example/base_page.dart';
import 'package:flutter/material.dart';

import 'package:amap_map/amap_map.dart';
import 'package:x_amap_base/x_amap_base.dart';

class ShowMapPage extends BasePage {
  ShowMapPage(String title, String subTitle) : super(title, subTitle);
  @override
  Widget build(BuildContext context) {
    return _ShowMapPageBody();
  }
}

class _ShowMapPageBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShowMapPageState();
}

class _ShowMapPageState extends State<_ShowMapPageBody> {
  static final CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(39.909187, 116.397451),
    zoom: 10.0,
  );
  @override
  Widget build(BuildContext context) {
    final AMapWidget map = AMapWidget(
      initialCameraPosition: _kInitialPosition,
      onMapCreated: onMapCreated,
    );

    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: map,
      ),
    );
  }

  AMapController _mapController;
  void onMapCreated(AMapController controller) {
    setState(() {
      _mapController = controller;
    });
  }

}

```

## Issues
1. [android] app 的 targetSDKVersion >= 30, 地图页返回闪退

  在里的AndroidManifest.xml里的application里增加`android:allowNativeHeapPointerTagging="false"`
  ```xml
      <application android:allowNativeHeapPointerTagging="false">
      ...
      </application>
  ```
  google官方说明地址：https://source.android.com/devices/tech/debug/tagged-pointers




