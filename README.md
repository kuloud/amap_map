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
### 初始化
在runApp启动的**第一个**Widget中，使用`context`进行组件初始化

```dart
import 'package:amap_map/amap_map.dart';
import 'package:x_amap_base/x_amap_base.dart'; // AMapApiKey 和 AMapPrivacyStatement 定义在 package `x_amap_base` 中，需要一并引入

class DemoWidget extends State<AMapDemo> {

  @override
  Widget build(BuildContext context) {
    AMapInitializer.init(context, ConstConfig.amapApiKeys);
    
    return Scaffold(
      // ...
    );
  }
}
```
### 合规处理
高德SDK合规使用方案请参考：https://lbs.amap.com/news/sdkhgsy ，需要进行授权交互，然后通知组件。

```dart
AMapInitializer.updatePrivacyAgree(ConstConfig.amapPrivacyStatement);
```

### 使用地图
``` dart
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

## 更多示例

```dart
final List<BasePage> _mapDemoPages = <BasePage>[
  AllMapConfigDemoPage('总体演示', '演示AMapWidget的所有配置项'),
  ShowMapPage('显示地图', '基本地图显示'),
  LimitMapBoundsPage('限制地图显示范围', '演示限定手机屏幕显示地图的范围'),
  MinMaxZoomDemoPage('指定显示级别范围', '演示指定最小最大级别功能'),
  ChangeMapTypePage('切换地图图层', '演示内置的地图图层'),
  CustomMapStylePage('自定义地图', '根据自定义的地图样式文件显示地图'),
  MultiMapDemoPage('地图多实例', '同时显示多个地图'),
];

final List<BasePage> _interactiveDemoPages = <BasePage>[
  MapUIDemoPage('UI控制', 'ui开关演示'),
  GesturesDemoPage('手势交互', '手势交互'),
  PoiClickDemoPage('点击poi功能', '演示点击poi之后的回调和信息透出'),
  MoveCameraDemoPage('改变地图视角', '演示改变地图的中心点、可视区域、缩放级别等功能'),
  SnapshotPage('地图截屏', '地图截屏示例'),
  MyLocationPage('显示我的位置', '在地图上显示我的位置'),
];

final List<BasePage> _markerPages = <BasePage>[
  MarkerConfigDemoPage('Marker操作', '演示Marker的相关属性的操作'),
  MarkerAddWithMapPage("随地图添加", "演示初始化地图时直接添加marker"),
  MarkerAddAfterMapPage("单独添加", "演示地图初始化之后单独添加marker功能"),
  MarkerCustomIconPage('自定义图标', '演示marker使用自定义图标功能'),
];

final List<BasePage> _overlayPages = <BasePage>[
  PolylineDemoPage('Polyline操作', '演示Polyline的相关属性的操作'),
  PolylineGeodesicDemoPage('Polyline大地曲线', '演示大地曲线的添加'),
  PolylineTextureDemoPage('Polyline纹理线', '演示纹理线的添加'),
  PolygonDemoPage('Polygon操作', '演示Polygon的相关属性的操作'),
];
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




