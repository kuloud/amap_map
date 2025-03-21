## 1.0.15
2025-03-21
* add MapConfiguration and serialize utils
* add compatibility with Color.fromARGB()
* code lint

## 1.0.14
2025-03-12
* code lint

## 1.0.13
2025-03-11
* 升级amap android sdk版本 10.1.200_loc6.4.9_sea9.7.4 | 2025-03-11
* 升级amap iOS sdk版本 10.1.200 | 2024-12-26
* 修复问题：android 构建异常，过期接口 io.flutter.view.FlutterMain 替换
* 修复问题：android 构建异常，过期接口 PluginRegistry.Registrar 替换


## 1.0.12
2024-08-26
* code lint

## 1.0.11
2024-08-25
* 升级amap iOS sdk版本 10.0.900 | 2024-08-23
* code lint

## 1.0.10
2024-08-25
* 移除extension实现机制
* 添加 getMapContentApprovalNumber / getSatelliteImageApprovalNumber（参见example#ShowMapPage）
* 添加 InfoWindowAdapter（参见example#CustomInfoWindowDemoPage）,结合 infoWindowEnable 和 BaseInfoWindowAdapter 自行实现具体逻辑
* permission_handler 11.3.0 -> 11.3.1

## 1.0.9
2024-08-24
* 设置地图语言，支持中文、英文（按SDK描述：1、不能和自定义地图样式同时使用；2、英文状态只在标准地图生效）

## 1.0.8
2024-07-29.
* 升级amap android sdk版本 10.0.800_loc6.4.5_sea9.7.2 | 2024-07-19 

## 1.0.7
2024-07-28.
* Close Issue [#10](https://github.com/kuloud/amap_map/issues/10) 添加Logo位置设置，参见example: map_ui_options.dart

## 1.0.6
2024-06-27.
* 升级amap android sdk版本 V10.0.700_loc6.4.5_sea9.7.2 | 2024-05-13 `看高德更新日志，应该是计划后续版本捆绑loc+search一起更新了`

## 1.0.5
2024-03-20.
* 升级amap android sdk版本 V10.0.600 2024-03-15
* 升级amap ios sdk版本 V10.0.600 2024-03-15
* [example] 适配迁移Gradle声明性插件 https://docs.flutter.dev/release/breaking-changes/flutter-gradle-plugin-apply
* permission_handler 11.1.0 -> 11.3.0

## 1.0.4
2024-01-04.
* 添加 InfoWindowExtension，支持自定义 InfoWindow 样式

## 1.0.3+1
2024-01-03.
* 处理lint，更新文档

## 1.0.3
2024-01-03.
* AMapController 添加 toScreenCoordinate / fromScreenCoordinate，实现屏幕坐标和经纬度的互相转换

## 1.0.2
2023-12-30.
* 增加插件支持

## 1.0.1
2023-12-29.
* 移除 `AMapWidget` 中的 `apiKey` / `privacyStatement` 字段

## 1.0.0+8
2023-12-29.
* 废弃 `AMapWidget` 中的 `apiKey` / `privacyStatement` 字段，使用 `AMapInitializer` 初始化

## 1.0.0+7 - 2023-12-26.
* github action automate publish support

## 1.0.0+6 - 2023-12-26.
* update android sdk version 9.8.3
* update iOS sdk version 9.7.0 

## 1.0.0+1 - 2023-12-22.
* fork from https://pub.dev/packages/amap_flutter_map