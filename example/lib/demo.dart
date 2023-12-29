import 'package:amap_map_example/data/demos.dart';
import 'package:amap_map_example/main.dart';
import 'package:flutter/material.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({
    super.key,
    required this.slug,
  });

  final String? slug;

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  late Map<String?, Demo> slugToDemoMap;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    slugToDemoMap = slugToDemo(context);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.slug == null || !slugToDemoMap.containsKey(widget.slug)) {
      // Return to root if invalid slug.
      Navigator.of(context).pop();
    }
    return ScaffoldMessenger(
        child: AMapDemoPage(
      restorationId: widget.slug!,
      demo: slugToDemoMap[widget.slug]!,
    ));
  }
}

class AMapDemoPage extends StatefulWidget {
  const AMapDemoPage({
    super.key,
    required this.restorationId,
    required this.demo,
  });

  final String restorationId;
  final Demo demo;

  @override
  State<StatefulWidget> createState() => _AMapDemoPageState(demo);
}

class _AMapDemoPageState extends State<AMapDemoPage> {
  _AMapDemoPageState(this.demo);

  final Demo demo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(demo.title)),
      body: SafeArea(
        child: Builder(builder: demo.configurations.first.buildRoute),
      ),
    );
  }
}
