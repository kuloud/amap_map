import 'dart:collection';

import 'package:amap_map_example/main.dart';
import 'package:amap_map_example/pages/interactive/map_ui_options.dart';
import 'package:amap_map_example/pages/map/limit_map_bounds.dart';
import 'package:amap_map_example/pages/map/map_my_location.dart';
import 'package:amap_map_example/pages/map/show_map_page.dart';
import 'package:amap_map_example/pages/overlays/marker_config.dart';
import 'package:flutter/material.dart';

class DemoConfiguration {
  const DemoConfiguration({
    required this.buildRoute,
  });

  final WidgetBuilder buildRoute;
}

List<Demo> allDemos() => mapDemos() + interactiveDemos() + overlayDemos();

List<Demo> mapDemos() {
  return [
    Demo(
        title: '显示地图',
        category: DemoCategory.basic,
        subtitle: '基本地图显示',
        slug: 'show-map',
        configurations: [
          DemoConfiguration(buildRoute: (context) => ShowMapPage())
        ]),
    Demo(
        title: '显示定位蓝点',
        category: DemoCategory.basic,
        subtitle: '定位蓝点指的是进入地图后显示当前位置点的功能',
        slug: 'my-location',
        configurations: [
          DemoConfiguration(buildRoute: (context) => LimitMapBoundsPage())
        ]),
    Demo(
        title: '限制地图显示范围',
        category: DemoCategory.basic,
        subtitle: '演示限定手机屏幕显示地图的范围',
        slug: 'limit-map-bounds',
        configurations: [
          DemoConfiguration(buildRoute: (context) => MyLocationPage())
        ]),
  ];
}

List<Demo> interactiveDemos() {
  return [
    Demo(
        title: 'UI控制',
        category: DemoCategory.interactive,
        subtitle: '浮在地图图面上用于操作地图的组件，例如缩放按钮、指南针、定位按钮、比例尺等。',
        slug: 'map-ui',
        configurations: [
          DemoConfiguration(buildRoute: (context) => MapUIDemoPage())
        ])
  ];
}

List<Demo> overlayDemos() {
  return [
    Demo(
        title: '绘制点标记',
        category: DemoCategory.overlay,
        subtitle: '演示Marker的相关属性的操作',
        slug: 'marker-config',
        configurations: [
          DemoConfiguration(buildRoute: (context) => MarkerConfigDemoPage())
        ])
  ];
}

Map<String?, Demo> slugToDemo(BuildContext context) {
  return LinkedHashMap<String?, Demo>.fromIterable(
    allDemos(),
    key: (dynamic demo) => demo.slug as String?,
  );
}
