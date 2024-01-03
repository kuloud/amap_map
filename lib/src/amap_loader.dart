// Copyright 2023-2024 kuloud

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at

//     http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,

part of amap_map;

class AMapLoader extends StatefulWidget {
  const AMapLoader(
      {super.key, required this.mapView, required this.extensions});

  final Widget mapView;
  final List<AMapExtension> extensions;

  @override
  State<AMapLoader> createState() => _AMapLoaderState();

  static void prepare() {
    // TODO loop handle with extensions
  }

  Widget buildFromExtension(AMapContext aMapContext) {
    // TODO loop handle with extensions
    return mapView;
  }

  void prepareFromExtension(AMapContext aMapContext) {
    for (var e in extensions) {
      e.prepare(aMapContext);
    }
  }
}

class _AMapLoaderState extends State<AMapLoader> {
  @override
  void didChangeDependencies() {
    final aMapContext = AMapContext(
        buildContext: context,
        currentStep: CurrentStep.preparing,
        loader: widget);
    widget.prepareFromExtension(aMapContext);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    for (var e in widget.extensions) {
      e.onDispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Set the extension context for this node.
    final aMapContext = AMapContext(
        buildContext: context,
        currentStep: CurrentStep.building,
        loader: widget);

    return widget.buildFromExtension(aMapContext);
  }
}
