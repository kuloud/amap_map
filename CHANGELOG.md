## 1.0.6
2024-07-28.
* Close Issue [#10](https://github.com/kuloud/amap_map/issues/10) 添加Logo位置设置，参见example: map_ui_options.dart

## 1.0.6
2024-06-27.
* 升级amap android sdk版本 V10.0.700_loc6.4.5_sea9.7.2 2024-05-13 看高德更新日志，应该是计划后续版本捆绑loc+search一起更新了

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