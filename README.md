# amap_map

[![pub package](https://img.shields.io/pub/v/amap_map.svg)](https://pub.dev/packages/amap_map)

基于[高德开放平台地图 SDK](https://lbs.amap.com/api/)的 flutter 插件

|             | Android                    | iOS      |
| ----------- | -------------------------- | -------- |
| **AMapSDK** | 10.1.200_loc6.4.9_sea9.7.4 | 10.1.200 |
| **Support** | SDK 21+                    | 12.0+    |


## Usage

使用 Flutter 插件，请参考[在 Flutter 里使用 Packages](https://flutter.cn/docs/development/packages-and-plugins/using-packages), 添加`amap_map`的引用

```bash
flutter pub add amap_map
```

## Prepare

- 登录[高德开放平台官网](https://lbs.amap.com/)申请 ApiKey。
  - Android 平台申请配置 key 请参考[Android 获取 key](https://lbs.amap.com/api/poi-sdk-android/develop/create-project/get-key/?sug_index=2)
  - iOS 平台申请配置请参考[iOS 获取 key](https://lbs.amap.com/api/poi-sdk-ios/develop/create-project/get-key/?sug_index=1)

## Demo

### 初始化

在 runApp 启动的**第一个**Widget 中，使用`context`进行组件初始化

```dart
import 'package:amap_map/amap_map.dart';
import 'package:x_amap_base/x_amap_base.dart'; // AMapApiKey 和 AMapPrivacyStatement 定义在 package `x_amap_base` 中，需要一并引入

class DemoWidget extends State<AMapDemo> {

  @override
  Widget build(BuildContext context) {
    AMapInitializer.init(context, apiKey: ConstConfig.amapApiKeys);

    return Scaffold(
      // ...
    );
  }
}
```

### 合规处理

高德 SDK 合规使用方案请参考：https://lbs.amap.com/news/sdkhgsy ，需要进行授权交互，然后通知组件。

```dart
AMapInitializer.updatePrivacyAgree(ConstConfig.amapPrivacyStatement);
```

### 使用地图

```dart
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

<img src="https://github.com/kuloud/amap_map/raw/main/showcase/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202024-01-03%20at%2017.18.55.png" width="30%"/>

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

  /// logo 位置，此字段高德只支持Android，本插件iOS借用logoCenter做了实现
  final LogoPosition? logoPosition;

  /// logo 底部间距(px)，此字段高德只支持Android，本插件iOS借用logoCenter做了实现
  final int? logoBottomMargin;

  /// logo 靠左间距(px)，此字段高德只支持Android，本插件iOS借用logoCenter做了实现
  final int? logoLeftMargin;

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

  /// 设置地图语言
  final MapLanguage? mapLanguage;

  /// Marker InfoWindow 适配器
  final InfoWindowAdapter? infoWindowAdapter;
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

    在里的 AndroidManifest.xml 里的 application 里增加`android:allowNativeHeapPointerTagging="false"`

    ```xml
        <application android:allowNativeHeapPointerTagging="false">
        ...
        </application>
    ```

    google 官方说明地址：https://source.android.com/devices/tech/debug/tagged-pointers

1. 如果模拟器运行遇到 `com.amap.api.col.3sl.dl$b.createContext(GlesUtility.java:73)` 闪退，可尝试切换模拟器图像加速模式为`Software`以获得更好的兼容性。[Issue #27](https://github.com/kuloud/amap_map/issues/27)
