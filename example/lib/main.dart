import 'package:amap_map_example/pages/overlays/marker_add_after_map.dart';
import 'package:amap_map_example/pages/overlays/marker_add_with_map.dart';
import 'package:amap_map_example/pages/overlays/marker_config.dart';
import 'package:amap_map_example/pages/overlays/marker_custom_icon.dart';
import 'package:amap_map_example/pages/overlays/place_polygon.dart';
import 'package:amap_map_example/pages/overlays/place_polyline.dart';
import 'package:amap_map_example/pages/interactive/map_gestures_options.dart';
import 'package:amap_map_example/pages/interactive/map_ui_options.dart';
import 'package:amap_map_example/pages/interactive/move_camera_demo.dart';
import 'package:amap_map_example/pages/interactive/poi_click_demo.dart';
import 'package:amap_map_example/pages/interactive/snapshot_demo.dart';
import 'package:amap_map_example/pages/map/change_map_type.dart';
import 'package:amap_map_example/pages/map/custom_map_style.dart';
import 'package:amap_map_example/pages/map/limit_map_bounds.dart';
import 'package:amap_map_example/pages/map/map_all_config.dart';
import 'package:amap_map_example/pages/map/map_my_location.dart';
import 'package:amap_map_example/pages/map/min_max_zoom.dart';
import 'package:amap_map_example/pages/map/multi_map.dart';
import 'package:amap_map_example/pages/map/show_map_page.dart';
import 'package:amap_map_example/pages/overlays/polyline_geodesic.dart';
import 'package:amap_map_example/pages/overlays/polyline_texture.dart';
import 'package:amap_map_example/widgets/demo_group.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'base_page.dart';

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

final List<Permission> needPermissionList = [
  Permission.location,
  Permission.storage,
  Permission.phone,
];

class AMapDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DemoWidget();
  }
}

class DemoWidget extends State<AMapDemo> {
  @override
  void initState() {
    super.initState();
    _checkPermissions();
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
    return Scaffold(
      appBar: AppBar(title: const Text('高德地图示例')),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                DemoGroupWidget(
                  groupLabel: '创建地图',
                  itemPages: _mapDemoPages,
                ),
                DemoGroupWidget(
                  groupLabel: '地图交互',
                  itemPages: _interactiveDemoPages,
                ),
                DemoGroupWidget(
                  groupLabel: '绘制点标记',
                  itemPages: _markerPages,
                ),
                DemoGroupWidget(
                  groupLabel: '绘制线和面',
                  itemPages: _overlayPages,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  // debugProfileBuildsEnabled = true;
  // debugProfilePaintsEnabled = true;
  // debugPaintLayerBordersEnabled = true;
  runApp(MaterialApp(home: AMapDemo()));
}
