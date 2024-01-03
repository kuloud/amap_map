# amap_map
[![pub package](https://img.shields.io/pub/v/amap_map.svg)](https://pub.dev/packages/amap_map)

基于[高德开放平台地图SDK](https://lbs.amap.com/api/)的flutter插件

|             | Android | iOS   |
|-------------|---------|-------|
| **AMapSDK** | 9.8.3 | 9.7.0 | 
| **Support** | SDK 16+ | 12.0+ | 

本插件基于 amap_flutter_map 3.0.0 进行二开的原因：
1. 原插件21年开始已无更新，插件年久失修，依赖SDK版本老旧
1. 原插件只实现了基础的地图展示和交互功能，无法满足常见定制化需求

## Usage
使用Flutter插件，请参考[在Flutter里使用Packages](https://flutter.cn/docs/development/packages-and-plugins/using-packages), 添加`amap_map`的引用
```bash
flutter pub add amap_map
```

## Prepare
* 登录[高德开放平台官网](https://lbs.amap.com/)申请ApiKey。
  - Android平台申请配置key请参考[Android获取key](https://lbs.amap.com/api/poi-sdk-android/develop/create-project/get-key/?sug_index=2)
  - iOS平台申请配置请参考[iOS获取key](https://lbs.amap.com/api/poi-sdk-ios/develop/create-project/get-key/?sug_index=1)


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
<img src="./showcase/Simulator Screenshot - iPhone 15 Pro Max - 2024-01-03 at 17.18.55.png" width="30%"/>

### 地图视图
```dart
///用于展示高德地图的Widget
class AMapWidget extends StatefulWidget {
  /// 初始化时的地图中心点
  final CameraPosition initialCameraPosition;

  ///地图类型
  final MapType mapType;

  ///自定义地图样式
  final CustomStyleOptions? customStyleOptions;

  ///定位小蓝点
  final MyLocationStyleOptions? myLocationStyleOptions;

  ///缩放级别范围
  final MinMaxZoomPreference? minMaxZoomPreference;

  ///地图显示范围
  final LatLngBounds? limitBounds;

  ///显示路况开关
  final bool trafficEnabled;

  /// 地图poi是否允许点击
  final bool touchPoiEnabled;

  ///是否显示3D建筑物
  final bool buildingsEnabled;

  ///是否显示底图文字标注
  final bool labelsEnabled;

  ///是否显示指南针
  final bool compassEnabled;

  ///是否显示比例尺
  final bool scaleEnabled;

  ///是否支持缩放手势
  final bool zoomGesturesEnabled;

  ///是否支持滑动手势
  final bool scrollGesturesEnabled;

  ///是否支持旋转手势
  final bool rotateGesturesEnabled;

  ///是否支持倾斜手势
  final bool tiltGesturesEnabled;

  /// 地图上显示的Marker
  final Set<Marker> markers;

  /// 地图上显示的polyline
  final Set<Polyline> polylines;

  /// 地图上显示的polygon
  final Set<Polygon> polygons;

  /// 地图创建成功的回调, 收到此回调之后才可以操作地图
  final MapCreatedCallback? onMapCreated;

  /// 相机视角持续移动的回调
  final ArgumentCallback<CameraPosition>? onCameraMove;

  /// 相机视角移动结束的回调
  final ArgumentCallback<CameraPosition>? onCameraMoveEnd;

  /// 地图单击事件的回调
  final ArgumentCallback<LatLng>? onTap;

  /// 地图长按事件的回调
  final ArgumentCallback<LatLng>? onLongPress;

  /// 地图POI的点击回调，需要`touchPoiEnabled`true，才能回调
  final ArgumentCallback<AMapPoi>? onPoiTouched;

  ///位置回调
  final ArgumentCallback<AMapLocation>? onLocationChanged;

  ///需要应用到地图上的手势集合
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;

  ///拓展插件，提供更多定制化功能
  final List<AMapExtension> extensions;
}
```


### 地图控制器
```dart 

class AMapController {

  ///改变地图视角
  ///
  ///通过[CameraUpdate]对象设置新的中心点、缩放比例、放大缩小、显示区域等内容
  ///
  ///（注意：iOS端设置显示区域时，不支持duration参数，动画时长使用iOS地图默认值350毫秒）
  ///
  ///可选属性[animated]用于控制是否执行动画移动
  ///
  ///可选属性[duration]用于控制执行动画的时长,默认250毫秒,单位:毫秒
  Future<void> moveCamera(CameraUpdate cameraUpdate,
      {bool animated = true, int duration = 250});

  ///地图截屏
  Future<Uint8List?> takeSnapshot();

  /// 清空缓存
  Future<void> clearDisk();

  /// 经纬度转屏幕坐标
  Future<ScreenCoordinate> toScreenCoordinate(LatLng latLng);

  /// 屏幕坐标转经纬度
  Future<LatLng> fromScreenCoordinate(ScreenCoordinate screenCoordinate);
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




