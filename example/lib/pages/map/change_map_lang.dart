// Copyright 2024 kuloud

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at

//     http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,

import 'package:amap_map/amap_map.dart';
import 'package:amap_map_example/widgets/amap_radio_group.dart';
import 'package:flutter/material.dart';

class ChangeMapLangPage extends StatefulWidget {
  const ChangeMapLangPage({super.key});

  @override
  State<ChangeMapLangPage> createState() => _PageBodyState();
}

class _PageBodyState extends State<ChangeMapLangPage> {
  MapLanguage? _mapLang;
  final Map<String, MapLanguage> _radioValueMap = <String, MapLanguage>{
    '中文': MapLanguage.chinese,
    'English': MapLanguage.english,
  };
  @override
  void initState() {
    super.initState();
    _mapLang = MapLanguage.chinese;
  }

  @override
  Widget build(BuildContext context) {
    //创建地图
    final AMapWidget map = AMapWidget(
      mapLanguage: _mapLang,
    );
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            child: map,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: AMapRadioGroup(
                groupLabel: '地图语言',
                groupValue: _mapLang,
                radioValueMap: _radioValueMap,
                onChanged: (MapLanguage? value) => <void>{
                  setState(() {
                    _mapLang = value;
                  })
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
