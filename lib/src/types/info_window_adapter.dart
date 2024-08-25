import 'package:amap_map/amap_map.dart';
import 'package:flutter/widgets.dart';

abstract class InfoWindowAdapter {
  Widget? getInfoWindow(BuildContext context, Marker marker);
}

abstract class BaseInfoWindowAdapter implements InfoWindowAdapter {
  final AMapController? controller;

  BaseInfoWindowAdapter(this.controller);

  @override
  Widget? getInfoWindow(BuildContext context, Marker marker) {
    final contentView = buildInfoWindowContent(context, marker);
    return (contentView != null)
        ? FutureBuilder(
            future: controller?.toScreenCoordinate(marker.position),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                double devicePixelRatio =
                    MediaQuery.of(context).devicePixelRatio;
                return Positioned(
                  left: snapshot.data!.x.toDouble() / devicePixelRatio,
                  top: snapshot.data!.y.toDouble() / devicePixelRatio,
                  child: contentView,
                );
              } else {
                return Container(); // 当未获取到数据时，返回空的 `Container`
              }
            },
          )
        : null;
  }

  Widget? buildInfoWindowContent(BuildContext context, Marker marker);
}
