// Copyright 2023-2024 kuloud
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,

import 'package:amap_map/amap_map.dart';
import 'package:flutter/material.dart';

/// 上下文
class AMapContext {
  final BuildContext buildContext;
  final CurrentStep currentStep;
  final AMapLoader loader;

  AMapContext(
      {required this.buildContext,
      required this.currentStep,
      required this.loader});
}

enum CurrentStep {
  preparing,
  updating,
  building,
}
