part of '../../amap_map.dart';

bool isLocationValid(AMapLocation location) {
  final LatLng latLng = location.latLng;

  if (latLng.latitude < -90 ||
      latLng.latitude > 90 ||
      latLng.longitude < -180 ||
      latLng.longitude > 180) {
    return false;
  }
  if (location.accuracy < 0) {
    return false;
  }

  return true;
}
