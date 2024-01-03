// Copyright 2023-2024 kuloud
// Copyright 2020 lbs.amap.com

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at

//     http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,

import 'package:amap_map_extensions/amap_map_extensions.dart';
import 'package:flutter/material.dart';

import 'dart:typed_data';

import 'package:amap_map/amap_map.dart';

class MapWithExtensionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MapWithExtensionPageState();
}

class _MapWithExtensionPageState extends State<MapWithExtensionPage> {
  List<Widget> _approvalNumberWidget = <Widget>[];
  final _extension = AmapMapExtensions();

  @override
  Widget build(BuildContext context) {
    final AMapWidget map = AMapWidget(
      onMapCreated: onMapCreated,
      // extensions: [_extension],
    );

    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: map,
          ),
          Positioned(
              right: 10,
              bottom: 15,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: _approvalNumberWidget),
              ))
        ],
      ),
    );
  }

  late AMapController _mapController;
  void onMapCreated(AMapController controller) {
    setState(() {
      _mapController = controller;
      getApprovalNumber();
    });
  }

  /// 获取审图号
  void getApprovalNumber() async {
    // //普通地图审图号
    // String mapContentApprovalNumber =
    //     (await _extension.getMapContentApprovalNumber())!;
    // //卫星地图审图号
    // String satelliteImageApprovalNumber =
    //     (await _extension.getSatelliteImageApprovalNumber())!;
    // setState(() {
    //   _approvalNumberWidget.add(Text(mapContentApprovalNumber));
    //   _approvalNumberWidget.add(Text(satelliteImageApprovalNumber));
    // });
    // print('地图审图号（普通地图）: $mapContentApprovalNumber');
    // print('地图审图号（卫星地图): $satelliteImageApprovalNumber');
  }
}
