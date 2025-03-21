// Copyright 2025 kuloud

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at

//     http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,

// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:amap_map/src/compatibility/compatibility_utils.dart';

extension ColorCompatibilityExtension on Color {
  int get argbValue {
    if (CompatibilityUtils.isSdkVersionGreaterOrEqual(3, 28, 0)) {
      return (this as dynamic).toARGB32();
    }
    return value;
  }
}