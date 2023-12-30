import 'package:amap_map/amap_map.dart';
import 'package:amap_map_example/animated_category_item.dart';
import 'package:amap_map_example/category_list_item.dart';
import 'package:amap_map_example/const_config.dart';
import 'package:amap_map_example/data/demos.dart';
import 'package:amap_map_example/routes.dart';
import 'package:amap_map_example/theme.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

// final List<BasePage> _mapDemoPages = <BasePage>[
//   AllMapConfigDemoPage('总体演示', '演示AMapWidget的所有配置项'),

//   MinMaxZoomDemoPage('指定显示级别范围', '演示指定最小最大级别功能'),
//   ChangeMapTypePage('切换地图图层', '演示内置的地图图层'),
//   CustomMapStylePage('自定义地图', '根据自定义的地图样式文件显示地图'),
//   MultiMapDemoPage('地图多实例', '同时显示多个地图'),
// ];

// final List<BasePage> _interactiveDemoPages = <BasePage>[
//   MapUIDemoPage('UI控制', 'ui开关演示'),
//   GesturesDemoPage('手势交互', '手势交互'),
//   PoiClickDemoPage('点击poi功能', '演示点击poi之后的回调和信息透出'),
//   MoveCameraDemoPage('改变地图视角', '演示改变地图的中心点、可视区域、缩放级别等功能'),
//   SnapshotPage('地图截屏', '地图截屏示例'),
// ];

// final List<BasePage> _markerPages = <BasePage>[
//   MarkerAddWithMapPage("随地图添加", "演示初始化地图时直接添加marker"),
//   MarkerAddAfterMapPage("单独添加", "演示地图初始化之后单独添加marker功能"),
//   MarkerCustomIconPage('自定义图标', '演示marker使用自定义图标功能'),
// ];

// final List<BasePage> _overlayPages = <BasePage>[
//   PolylineDemoPage('Polyline操作', '演示Polyline的相关属性的操作'),
//   PolylineGeodesicDemoPage('Polyline大地曲线', '演示大地曲线的添加'),
//   PolylineTextureDemoPage('Polyline纹理线', '演示纹理线的添加'),
//   PolygonDemoPage('Polygon操作', '演示Polygon的相关属性的操作'),
// ];

final List<Permission> needPermissionList = [
  Permission.location,
  Permission.storage,
  Permission.phone,
];

class AMapDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AMapDemoState();
}

class _AMapDemoState extends State<AMapDemo>
    with RestorationMixin, SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final RestorableBool _isMapListExpanded = RestorableBool(false);

  @override
  void initState() {
    super.initState();

    _checkPermissions();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  }

  @override
  void reassemble() {
    super.reassemble();
    _checkPermissions();
  }

  void _checkPermissions() async {
    Map<Permission, PermissionStatus> statuses =
        await needPermissionList.request();
    statuses.forEach((key, value) {
      print('$key premissionStatus is $value');
    });
  }

  @override
  Widget build(BuildContext context) {
    AMapInitializer.init(context, ConstConfig.amapApiKeys);
    AMapInitializer.updatePrivacyAgree(ConstConfig.amapPrivacyStatement);
    return Scaffold(
      appBar: AppBar(title: const Text('高德地图示例')),
      body: ListView(
        children: [
          AnimatedCategoryItem(
              startDelayFraction: 0,
              controller: _animationController,
              child: CategoryListItem(
                category: DemoCategory.basic,
                demos: mapDemos(),
              )),
          AnimatedCategoryItem(
              startDelayFraction: 0.05,
              controller: _animationController,
              child: CategoryListItem(
                category: DemoCategory.interactive,
                demos: interactiveDemos(),
              )),
          AnimatedCategoryItem(
              startDelayFraction: 0.1,
              controller: _animationController,
              child: CategoryListItem(
                category: DemoCategory.overlay,
                demos: overlayDemos(),
              )),
          AnimatedCategoryItem(
              startDelayFraction: 0.15,
              controller: _animationController,
              child: CategoryListItem(
                category: DemoCategory.extension,
                demos: extensionDemos(),
              )),
        ],
      ),
    );
  }

  @override
  String? get restorationId => 'demos';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_isMapListExpanded, 'map_list');
  }
}

void main() {
  runApp(MaterialApp(
      theme: ThemeData(colorScheme: DemoThemeData.lightColorScheme),
      themeMode: ThemeMode.light,
      onGenerateRoute: RouteConfig.onGenerateRoute,
      home: AMapDemo()));
}

enum DemoCategory {
  basic,
  interactive,
  overlay,
  extension;

  String toDisplayTitle() {
    switch (this) {
      case basic:
        return '创建地图';
      case interactive:
        return '与地图交互';
      case overlay:
        return '在地图上绘制';
      case extension:
        return '拓展插件';
    }
  }
}

class Demo {
  const Demo({
    required this.title,
    required this.category,
    required this.subtitle,
    // Parameters below are required for non-study demos.
    this.slug,
    this.configurations = const [],
  }) : assert(slug != null);

  final String title;
  final DemoCategory category;
  final String subtitle;
  final String? slug;
  final List<DemoConfiguration> configurations;

  String get describe => '$slug@${category.name}';
}
