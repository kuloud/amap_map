import 'dart:collection';

import 'package:amap_map_example/main.dart';
import 'package:amap_map_example/pages/interactive/map_ui_options.dart';
import 'package:amap_map_example/pages/map/change_map_lang.dart';
import 'package:amap_map_example/pages/map/limit_map_bounds.dart';
import 'package:amap_map_example/pages/map/map_my_location.dart';
import 'package:amap_map_example/pages/map/show_map_page.dart';
import 'package:amap_map_example/pages/overlays/custom_info_window.dart';
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
  return <Demo>[
    Demo(
        title: '显示地图',
        category: DemoCategory.basic,
        subtitle: '基本地图显示',
        slug: 'show-map',
        configurations: <DemoConfiguration>[
          DemoConfiguration(buildRoute: (BuildContext context) => ShowMapPage())
        ]),
    Demo(
        title: '显示定位蓝点',
        category: DemoCategory.basic,
        subtitle: '定位蓝点指的是进入地图后显示当前位置点的功能',
        slug: 'my-location',
        configurations: <DemoConfiguration>[
          DemoConfiguration(
              buildRoute: (BuildContext context) => MyLocationPage())
        ]),
    Demo(
        title: '限制地图显示范围',
        category: DemoCategory.basic,
        subtitle: '演示限定手机屏幕显示地图的范围',
        slug: 'limit-map-bounds',
        configurations: <DemoConfiguration>[
          DemoConfiguration(
              buildRoute: (BuildContext context) => LimitMapBoundsPage())
        ]),
    Demo(
        title: '地图显示语言',
        category: DemoCategory.basic,
        subtitle: '演示限定手机屏幕显示地图的范围',
        slug: 'map-lang',
        configurations: <DemoConfiguration>[
          DemoConfiguration(
              buildRoute: (BuildContext context) => ChangeMapLangPage())
        ]),
  ];
}

List<Demo> interactiveDemos() {
  return <Demo>[
    Demo(
        title: 'UI控制',
        category: DemoCategory.interactive,
        subtitle: '浮在地图图面上用于操作地图的组件，例如缩放按钮、指南针、定位按钮、比例尺等。',
        slug: 'map-ui',
        configurations: <DemoConfiguration>[
          DemoConfiguration(
              buildRoute: (BuildContext context) => MapUIDemoPage())
        ])
  ];
}

List<Demo> overlayDemos() {
  return <Demo>[
    Demo(
        title: '绘制点标记',
        category: DemoCategory.overlay,
        subtitle: '演示Marker的相关属性的操作',
        slug: 'marker-config',
        configurations: <DemoConfiguration>[
          DemoConfiguration(
              buildRoute: (BuildContext context) => MarkerConfigDemoPage())
        ]),
    Demo(
        title: '自定义InfoWindow',
        category: DemoCategory.overlay,
        subtitle: '自定义与Marker绑定的InfoWindow样式',
        slug: 'custom-info-window',
        configurations: <DemoConfiguration>[
          DemoConfiguration(
              buildRoute: (BuildContext context) => CustomInfoWindowDemoPage())
        ])
  ];
}

Map<String?, Demo> slugToDemo(BuildContext context) {
  return LinkedHashMap<String?, Demo>.fromIterable(
    allDemos(),
    key: (dynamic demo) => demo.slug as String?,
  );
}
