import 'package:amap_map/amap_map.dart';
import 'package:amap_map_example/animated_category_item.dart';
import 'package:amap_map_example/category_list_item.dart';
import 'package:amap_map_example/const_config.dart';
import 'package:amap_map_example/data/demos.dart';
import 'package:amap_map_example/routes.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

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
    AMapInitializer.init(context, apiKey: ConstConfig.amapApiKeys);
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
