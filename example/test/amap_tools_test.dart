import 'package:flutter_test/flutter_test.dart';
import 'package:x_amap_base/x_amap_base.dart';

void main() {
  test('Distance between two different point', () {
    LatLng p1 = const LatLng(1, 1);
    LatLng p2 = const LatLng(2, 2);
    double distance = AMapTools.distanceBetween(p1, p2);
    expect(distance, 157401.56104583555);
  });

  test('Distance between two same point', () {
    LatLng p1 = const LatLng(1, 1);
    LatLng p2 = const LatLng(1, 1);
    double distance = AMapTools.distanceBetween(p1, p2);
    expect(distance, 0);
  });

  test('Distance between two different point with equal lat', () {
    LatLng p1 = const LatLng(1, 1);
    LatLng p2 = const LatLng(1, 2);
    double distance = AMapTools.distanceBetween(p1, p2);
    expect(distance, 111302.53586533663);
  });

  test('Distance between two different point with equal lng', () {
    LatLng p1 = const LatLng(1, 1);
    LatLng p2 = const LatLng(2, 1);
    double distance = AMapTools.distanceBetween(p1, p2);
    expect(distance, 111319.49079327357);
  });

  test('Distance between two different point with close point', () {
    LatLng p1 = const LatLng(39.938212, 116.455139);
    LatLng p2 = const LatLng(39.987656, 116.265605);
    double distance = AMapTools.distanceBetween(p1, p2);
    expect(distance, 17082.425889709597);
  });
}
