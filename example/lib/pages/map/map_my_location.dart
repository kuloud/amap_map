import 'package:amap_map/amap_map.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:x_amap_base/x_amap_base.dart';

class MyLocationPage extends StatefulWidget {
  const MyLocationPage({super.key});
  @override
  State<MyLocationPage> createState() => _BodyState();
}

class _BodyState extends State<MyLocationPage> {
  AMapController? _mapController;

  @override
  void initState() {
    super.initState();
    _requestLocaitonPermission();
  }

  @override
  void reassemble() {
    super.reassemble();
    _requestLocaitonPermission();
  }

  void _requestLocaitonPermission() async {
    PermissionStatus status = await Permission.location.request();
    print('permissionStatus=====> $status');
  }

  @override
  Widget build(BuildContext context) {
    final AMapWidget amap = AMapWidget(
      myLocationStyleOptions: MyLocationStyleOptions(
        true,
        circleFillColor: Colors.lightBlue,
        circleStrokeColor: Colors.blue,
        circleStrokeWidth: 1,
      ),
      onLocationChanged: (AMapLocation loc) {
        if (isLocationValid(loc)) {
          print(loc);
          _mapController?.moveCamera(CameraUpdate.newLatLng(loc.latLng));
        }
      },
      onMapCreated: (AMapController controller) {
        _mapController = controller;
      },
    );

    return Container(
      child: amap,
    );
  }
}
