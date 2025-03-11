// Copyright 2023-2024 kuloud
// Copyright 2020 lbs.amap.com

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at

//     http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,

/// 高德地图Flutter插件入口文件
library;

import 'dart:async';

import 'package:x_amap_base/x_amap_base.dart';
import 'package:amap_map/src/core/amap_flutter_platform.dart';
import 'package:amap_map/src/core/map_event.dart';
import 'package:amap_map/src/core/method_channel_amap_map.dart';
import 'package:amap_map/src/types/types.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

export 'package:amap_map/src/types/types.dart';

part 'src/amap_initializer.dart';
part 'src/amap_controller.dart';
part 'src/amap_widget.dart';
part 'src/utils/location_utils.dart';
