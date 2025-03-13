// Copyright 2025 kuloud. All rights reserved.
// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:amap_map/amap_map.dart'
    show CameraTargetBounds, MapType, MinMaxZoomPreference;
import 'package:flutter/widgets.dart';

/// Configuration options for the AMap user interface.
@immutable
class MapConfiguration {
  /// Creates a new configuration instance with the given options.
  ///
  /// Any options that aren't passed will be null, which allows this to serve
  /// as either a full configuration selection, or an update to an existing
  /// configuration where only non-null values are updated.
  const MapConfiguration({
    this.compassEnabled,
    this.cameraTargetBounds,
    this.mapType,
    this.minMaxZoomPreference,
    this.rotateGesturesEnabled,
    this.scrollGesturesEnabled,
    this.tiltGesturesEnabled,
    this.zoomControlsEnabled,
    this.zoomGesturesEnabled,
    this.myLocationEnabled,
    this.myLocationButtonEnabled,
    this.padding,
    this.indoorViewEnabled,
    this.trafficEnabled,
    this.buildingsEnabled,
    this.labelsEnabled,
    this.scaleEnabled,
    this.touchPoiEnabled,
    this.logoPosition,
    this.logoBottomMargin,
    this.logoLeftMargin,
    this.mapLanguage,
  });

  /// True if the compass UI should be shown.
  final bool? compassEnabled;

  /// The bounds to display.
  final CameraTargetBounds? cameraTargetBounds;

  /// The type of the map.
  final MapType? mapType;

  /// The preferred zoom range.
  final MinMaxZoomPreference? minMaxZoomPreference;

  /// True if rotate gestures should be enabled.
  final bool? rotateGesturesEnabled;

  /// True if scroll gestures should be enabled.
  ///
  /// Android/iOS only.
  final bool? scrollGesturesEnabled;

  /// True if tilt gestures should be enabled.
  final bool? tiltGesturesEnabled;

  /// True if zoom controls should be displayed.
  final bool? zoomControlsEnabled;

  /// True if zoom gestures should be enabled.
  final bool? zoomGesturesEnabled;

  /// True if the current location should be tracked and displayed.
  final bool? myLocationEnabled;

  /// True if the control to jump to the current location should be displayed.
  final bool? myLocationButtonEnabled;

  /// The padding for the map display.
  final EdgeInsets? padding;

  /// True if indoor map views should be enabled.
  final bool? indoorViewEnabled;

  /// True if the traffic overlay should be enabled.
  final bool? trafficEnabled;

  /// True if 3D building display should be enabled.
  final bool? buildingsEnabled;

  /// True if map labels should be enabled.
  final bool? labelsEnabled;

  /// True if the scale control should be enabled.
  final bool? scaleEnabled;

  /// True if touch events on POIs should be enabled.
  final bool? touchPoiEnabled;

  /// The position of the map logo.
  final int? logoPosition;

  /// The bottom margin of the map logo.
  final int? logoBottomMargin;

  /// The left margin of the map logo.
  final int? logoLeftMargin;

  /// The language of the map.
  final String? mapLanguage;

  /// Returns a new options object containing only the values of this instance
  /// that are different from [other].
  MapConfiguration diffFrom(MapConfiguration other) {
    return MapConfiguration(
      compassEnabled:
          compassEnabled != other.compassEnabled ? compassEnabled : null,
      cameraTargetBounds: cameraTargetBounds != other.cameraTargetBounds
          ? cameraTargetBounds
          : null,
      mapType: mapType != other.mapType ? mapType : null,
      minMaxZoomPreference: minMaxZoomPreference != other.minMaxZoomPreference
          ? minMaxZoomPreference
          : null,
      rotateGesturesEnabled:
          rotateGesturesEnabled != other.rotateGesturesEnabled
              ? rotateGesturesEnabled
              : null,
      scrollGesturesEnabled:
          scrollGesturesEnabled != other.scrollGesturesEnabled
              ? scrollGesturesEnabled
              : null,
      tiltGesturesEnabled: tiltGesturesEnabled != other.tiltGesturesEnabled
          ? tiltGesturesEnabled
          : null,
      zoomControlsEnabled: zoomControlsEnabled != other.zoomControlsEnabled
          ? zoomControlsEnabled
          : null,
      zoomGesturesEnabled: zoomGesturesEnabled != other.zoomGesturesEnabled
          ? zoomGesturesEnabled
          : null,
      myLocationEnabled: myLocationEnabled != other.myLocationEnabled
          ? myLocationEnabled
          : null,
      myLocationButtonEnabled:
          myLocationButtonEnabled != other.myLocationButtonEnabled
              ? myLocationButtonEnabled
              : null,
      padding: padding != other.padding ? padding : null,
      indoorViewEnabled: indoorViewEnabled != other.indoorViewEnabled
          ? indoorViewEnabled
          : null,
      trafficEnabled:
          trafficEnabled != other.trafficEnabled ? trafficEnabled : null,
      buildingsEnabled:
          buildingsEnabled != other.buildingsEnabled ? buildingsEnabled : null,
      labelsEnabled:
          labelsEnabled != other.labelsEnabled ? labelsEnabled : null,
      scaleEnabled: scaleEnabled != other.scaleEnabled ? scaleEnabled : null,
      touchPoiEnabled:
          touchPoiEnabled != other.touchPoiEnabled ? touchPoiEnabled : null,
      logoPosition: logoPosition != other.logoPosition ? logoPosition : null,
      logoBottomMargin:
          logoBottomMargin != other.logoBottomMargin ? logoBottomMargin : null,
      logoLeftMargin:
          logoLeftMargin != other.logoLeftMargin ? logoLeftMargin : null,
      mapLanguage: mapLanguage != other.mapLanguage ? mapLanguage : null,
    );
  }

  /// Returns a copy of this instance with any non-null settings form [diff]
  /// replacing the previous values.
  MapConfiguration applyDiff(MapConfiguration diff) {
    return MapConfiguration(
      compassEnabled: diff.compassEnabled ?? compassEnabled,
      cameraTargetBounds: diff.cameraTargetBounds ?? cameraTargetBounds,
      mapType: diff.mapType ?? mapType,
      minMaxZoomPreference: diff.minMaxZoomPreference ?? minMaxZoomPreference,
      rotateGesturesEnabled:
          diff.rotateGesturesEnabled ?? rotateGesturesEnabled,
      scrollGesturesEnabled:
          diff.scrollGesturesEnabled ?? scrollGesturesEnabled,
      tiltGesturesEnabled: diff.tiltGesturesEnabled ?? tiltGesturesEnabled,
      zoomControlsEnabled: diff.zoomControlsEnabled ?? zoomControlsEnabled,
      zoomGesturesEnabled: diff.zoomGesturesEnabled ?? zoomGesturesEnabled,
      myLocationEnabled: diff.myLocationEnabled ?? myLocationEnabled,
      myLocationButtonEnabled:
          diff.myLocationButtonEnabled ?? myLocationButtonEnabled,
      padding: diff.padding ?? padding,
      indoorViewEnabled: diff.indoorViewEnabled ?? indoorViewEnabled,
      trafficEnabled: diff.trafficEnabled ?? trafficEnabled,
      buildingsEnabled: diff.buildingsEnabled ?? buildingsEnabled,
      labelsEnabled: diff.labelsEnabled ?? labelsEnabled,
      scaleEnabled: diff.scaleEnabled ?? scaleEnabled,
      touchPoiEnabled: diff.touchPoiEnabled ?? touchPoiEnabled,
      logoPosition: diff.logoPosition ?? logoPosition,
      logoBottomMargin: diff.logoBottomMargin ?? logoBottomMargin,
      logoLeftMargin: diff.logoLeftMargin ?? logoLeftMargin,
      mapLanguage: diff.mapLanguage ?? mapLanguage,
    );
  }

  /// True if no options are set.
  bool get isEmpty =>
      compassEnabled == null &&
      cameraTargetBounds == null &&
      mapType == null &&
      minMaxZoomPreference == null &&
      rotateGesturesEnabled == null &&
      scrollGesturesEnabled == null &&
      tiltGesturesEnabled == null &&
      zoomControlsEnabled == null &&
      zoomGesturesEnabled == null &&
      myLocationEnabled == null &&
      myLocationButtonEnabled == null &&
      padding == null &&
      indoorViewEnabled == null &&
      trafficEnabled == null &&
      buildingsEnabled == null &&
      labelsEnabled == null &&
      scaleEnabled == null &&
      touchPoiEnabled == null &&
      logoPosition == null &&
      logoBottomMargin == null &&
      logoLeftMargin == null &&
      mapLanguage == null;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is MapConfiguration &&
        compassEnabled == other.compassEnabled &&
        cameraTargetBounds == other.cameraTargetBounds &&
        mapType == other.mapType &&
        minMaxZoomPreference == other.minMaxZoomPreference &&
        rotateGesturesEnabled == other.rotateGesturesEnabled &&
        scrollGesturesEnabled == other.scrollGesturesEnabled &&
        tiltGesturesEnabled == other.tiltGesturesEnabled &&
        zoomControlsEnabled == other.zoomControlsEnabled &&
        zoomGesturesEnabled == other.zoomGesturesEnabled &&
        myLocationEnabled == other.myLocationEnabled &&
        myLocationButtonEnabled == other.myLocationButtonEnabled &&
        padding == other.padding &&
        indoorViewEnabled == other.indoorViewEnabled &&
        trafficEnabled == other.trafficEnabled &&
        buildingsEnabled == other.buildingsEnabled &&
        labelsEnabled == other.labelsEnabled &&
        scaleEnabled == other.scaleEnabled &&
        touchPoiEnabled == other.touchPoiEnabled &&
        logoPosition == other.logoPosition &&
        logoBottomMargin == other.logoBottomMargin &&
        logoLeftMargin == other.logoLeftMargin &&
        mapLanguage == other.mapLanguage;
  }

  @override
  int get hashCode => Object.hashAll(<Object?>[
        compassEnabled,
        cameraTargetBounds,
        mapType,
        minMaxZoomPreference,
        rotateGesturesEnabled,
        scrollGesturesEnabled,
        tiltGesturesEnabled,
        zoomControlsEnabled,
        zoomGesturesEnabled,
        myLocationEnabled,
        myLocationButtonEnabled,
        padding,
        indoorViewEnabled,
        trafficEnabled,
        buildingsEnabled,
        labelsEnabled,
        scaleEnabled,
        touchPoiEnabled,
        logoPosition,
        logoBottomMargin,
        logoLeftMargin,
        mapLanguage,
      ]);

  @override
  String toString() {
    return 'MapConfiguration('
        'compassEnabled: $compassEnabled, '
        'cameraTargetBounds: $cameraTargetBounds, '
        'mapType: $mapType, '
        'minMaxZoomPreference: $minMaxZoomPreference, '
        'rotateGesturesEnabled: $rotateGesturesEnabled, '
        'scrollGesturesEnabled: $scrollGesturesEnabled, '
        'tiltGesturesEnabled: $tiltGesturesEnabled, '
        'zoomControlsEnabled: $zoomControlsEnabled, '
        'zoomGesturesEnabled: $zoomGesturesEnabled, '
        'myLocationEnabled: $myLocationEnabled, '
        'myLocationButtonEnabled: $myLocationButtonEnabled, '
        'padding: $padding, '
        'indoorViewEnabled: $indoorViewEnabled, '
        'trafficEnabled: $trafficEnabled, '
        'buildingsEnabled: $buildingsEnabled, '
        'labelsEnabled: $labelsEnabled, '
        'scaleEnabled: $scaleEnabled, '
        'touchPoiEnabled: $touchPoiEnabled, '
        'logoPosition: $logoPosition, '
        'logoBottomMargin: $logoBottomMargin, '
        'logoLeftMargin: $logoLeftMargin, '
        'mapLanguage: $mapLanguage'
        ')';
  }
}
