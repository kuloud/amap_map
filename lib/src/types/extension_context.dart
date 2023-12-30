import 'package:amap_map/amap_map.dart';
import 'package:flutter/material.dart';

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
  building,
}
