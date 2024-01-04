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

part of amap_map;

/// 加载器，在[AMapWidget]的生命周期上绑定拓展
class AMapLoader extends StatefulWidget {
  const AMapLoader(
      {super.key, required this.mapView, required this.extensions});

  final Widget mapView;
  final List<AMapExtension> extensions;

  @override
  State<AMapLoader> createState() => _AMapLoaderState();

  static void prepare() {
    // TODO Loader 初始化静态方法，在initState时做些逻辑
  }

  /// 传递构建视图，拓展按需进行包装和挂载定制视图
  Widget buildFromExtension(AMapContext aMapContext) {
    Widget child = mapView;
    for (var e in extensions) {
      child = e.build(aMapContext, child);
    }
    return child;
  }

  /// [didChangeDependencies] 状态更新时，挨个遍历进行拓展的更新操作
  void prepareFromExtension(AMapContext aMapContext) {
    for (var e in extensions) {
      e.prepare(aMapContext);
    }
  }

  /// [didChangeDependencies] 状态更新时，挨个遍历进行拓展的更新操作
  void updateFromExtension(AMapContext aMapContext) {
    for (var e in extensions) {
      e.update(aMapContext);
    }
    // Future.forEach(extensions, (ext) => ext.update(aMapContext));
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
  void didUpdateWidget(covariant AMapLoader oldWidget) {
    final aMapContext = AMapContext(
        buildContext: context,
        currentStep: CurrentStep.updating,
        loader: widget);
    widget.updateFromExtension(aMapContext);
    super.didUpdateWidget(oldWidget);
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
