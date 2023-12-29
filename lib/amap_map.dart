/// 高德地图Flutter插件入口文件
library amap_map;

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
