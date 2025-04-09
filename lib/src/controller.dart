// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: library_private_types_in_public_api

part of '../amap_map.dart';

/// Controller for a single GoogleMap instance running on the host platform.
class AMapController {
  AMapController._(
    this._aMapState, {
    required this.mapId,
  }) {
    _connectStreams(mapId);
  }

  /// The mapId for this controller
  final int mapId;

  /// Initialize control of a [AMap] with [id].
  ///
  /// Mainly for internal use when instantiating a [AMapController] passed
  /// in [AMap.onMapCreated] callback.
  static Future<AMapController> init(
    int id,
    CameraPosition initialCameraPosition,
    _AMapState aMapState,
  ) async {
    await AMapFlutterPlatform.instance.init(id);
    return AMapController._(
      aMapState,
      mapId: id,
    );
  }

  final _AMapState _aMapState;

  void _connectStreams(int mapId) {
    if (_aMapState.widget.onCameraMoveStarted != null) {
      AMapFlutterPlatform.instance
          .onCameraMoveStarted(mapId: mapId)
          .listen((_) => _aMapState.widget.onCameraMoveStarted!());
    }
    if (_aMapState.widget.onCameraMove != null) {
      AMapFlutterPlatform.instance.onCameraMove(mapId: mapId).listen(
          (CameraMoveEvent e) => _aMapState.widget.onCameraMove!(e.value));
    }
    if (_aMapState.widget.onCameraIdle != null) {
      AMapFlutterPlatform.instance
          .onCameraIdle(mapId: mapId)
          .listen((_) => _aMapState.widget.onCameraIdle!());
    }
    AMapFlutterPlatform.instance
        .onMarkerTap(mapId: mapId)
        .listen((MarkerTapEvent e) => _aMapState.onMarkerTap(e.value));
    AMapFlutterPlatform.instance.onMarkerDragStart(mapId: mapId).listen(
        (MarkerDragStartEvent e) =>
            _aMapState.onMarkerDragStart(e.value, e.position));
    AMapFlutterPlatform.instance.onMarkerDrag(mapId: mapId).listen(
        (MarkerDragEvent e) => _aMapState.onMarkerDrag(e.value, e.position));
    AMapFlutterPlatform.instance.onMarkerDragEnd(mapId: mapId).listen(
        (MarkerDragEndEvent e) =>
            _aMapState.onMarkerDragEnd(e.value, e.position));
    AMapFlutterPlatform.instance
        .onInfoWindowTap(mapId: mapId)
        .listen((InfoWindowTapEvent e) => _aMapState.onInfoWindowTap(e.value));
    AMapFlutterPlatform.instance
        .onPolylineTap(mapId: mapId)
        .listen((PolylineTapEvent e) => _aMapState.onPolylineTap(e.value));
    AMapFlutterPlatform.instance
        .onPolygonTap(mapId: mapId)
        .listen((PolygonTapEvent e) => _aMapState.onPolygonTap(e.value));
    AMapFlutterPlatform.instance
        .onCircleTap(mapId: mapId)
        .listen((CircleTapEvent e) => _aMapState.onCircleTap(e.value));
    AMapFlutterPlatform.instance.onGroundOverlayTap(mapId: mapId).listen(
        (GroundOverlayTapEvent e) => _aMapState.onGroundOverlayTap(e.value));
    AMapFlutterPlatform.instance
        .onTap(mapId: mapId)
        .listen((MapTapEvent e) => _aMapState.onTap(e.position));
    AMapFlutterPlatform.instance
        .onLongPress(mapId: mapId)
        .listen((MapLongPressEvent e) => _aMapState.onLongPress(e.position));
    AMapFlutterPlatform.instance
        .onClusterTap(mapId: mapId)
        .listen((ClusterTapEvent e) => _aMapState.onClusterTap(e.value));
  }

  /// Updates configuration options of the map user interface.
  ///
  /// Change listeners are notified once the update has been made on the
  /// platform side.
  ///
  /// The returned [Future] completes after listeners have been notified.
  Future<void> _updateMapConfiguration(MapConfiguration update) {
    return AMapFlutterPlatform.instance
        .updateMapConfiguration(update, mapId: mapId);
  }

  /// Updates marker configuration.
  ///
  /// Change listeners are notified once the update has been made on the
  /// platform side.
  ///
  /// The returned [Future] completes after listeners have been notified.
  Future<void> _updateMarkers(MarkerUpdates markerUpdates) {
    return AMapFlutterPlatform.instance
        .updateMarkers(markerUpdates, mapId: mapId);
  }

  /// Updates cluster manager configuration.
  ///
  /// Change listeners are notified once the update has been made on the
  /// platform side.
  ///
  /// The returned [Future] completes after listeners have been notified.
  Future<void> _updateClusterManagers(
      ClusterManagerUpdates clusterManagerUpdates) {
    return AMapFlutterPlatform.instance
        .updateClusterManagers(clusterManagerUpdates, mapId: mapId);
  }

  /// Updates ground overlay configuration.
  ///
  /// Change listeners are notified once the update has been made on the
  /// platform side.
  ///
  /// The returned [Future] completes after listeners have been notified.
  Future<void> _updateGroundOverlays(
      GroundOverlayUpdates groundOverlayUpdates) {
    return AMapFlutterPlatform.instance
        .updateGroundOverlays(groundOverlayUpdates, mapId: mapId);
  }

  /// Updates polygon configuration.
  ///
  /// Change listeners are notified once the update has been made on the
  /// platform side.
  ///
  /// The returned [Future] completes after listeners have been notified.
  Future<void> _updatePolygons(PolygonUpdates polygonUpdates) {
    return AMapFlutterPlatform.instance
        .updatePolygons(polygonUpdates, mapId: mapId);
  }

  /// Updates polyline configuration.
  ///
  /// Change listeners are notified once the update has been made on the
  /// platform side.
  ///
  /// The returned [Future] completes after listeners have been notified.
  Future<void> _updatePolylines(PolylineUpdates polylineUpdates) {
    return AMapFlutterPlatform.instance
        .updatePolylines(polylineUpdates, mapId: mapId);
  }

  /// Updates circle configuration.
  ///
  /// Change listeners are notified once the update has been made on the
  /// platform side.
  ///
  /// The returned [Future] completes after listeners have been notified.
  Future<void> _updateCircles(CircleUpdates circleUpdates) {
    return AMapFlutterPlatform.instance
        .updateCircles(circleUpdates, mapId: mapId);
  }

  /// Updates heatmap configuration.
  ///
  /// Change listeners are notified once the update has been made on the
  /// platform side.
  ///
  /// The returned [Future] completes after listeners have been notified.
  Future<void> _updateHeatmaps(HeatmapUpdates heatmapUpdates) {
    return AMapFlutterPlatform.instance
        .updateHeatmaps(heatmapUpdates, mapId: mapId);
  }

  /// Updates tile overlays configuration.
  ///
  /// Change listeners are notified once the update has been made on the
  /// platform side.
  ///
  /// The returned [Future] completes after listeners have been notified.
  Future<void> _updateTileOverlays(Set<TileOverlay> newTileOverlays) {
    return AMapFlutterPlatform.instance
        .updateTileOverlays(newTileOverlays: newTileOverlays, mapId: mapId);
  }

  /// Clears the tile cache so that all tiles will be requested again from the
  /// [TileProvider].
  ///
  /// The current tiles from this tile overlay will also be
  /// cleared from the map after calling this method. The API maintains a small
  /// in-memory cache of tiles. If you want to cache tiles for longer, you
  /// should implement an on-disk cache.
  Future<void> clearTileCache(TileOverlayId tileOverlayId) async {
    return AMapFlutterPlatform.instance
        .clearTileCache(tileOverlayId, mapId: mapId);
  }

  /// Starts an animated change of the map camera position.
  ///
  /// The [duration] parameter specifies the duration of the animation.
  /// If null, the platform will decide the default value.
  ///
  /// The returned [Future] completes after the change has been started on the
  /// platform side.
  Future<void> animateCamera(CameraUpdate cameraUpdate, {Duration? duration}) {
    return AMapFlutterPlatform.instance.animateCameraWithConfiguration(
        cameraUpdate, CameraUpdateAnimationConfiguration(duration: duration),
        mapId: mapId);
  }

  /// Changes the map camera position.
  ///
  /// The returned [Future] completes after the change has been made on the
  /// platform side.
  Future<void> moveCamera(CameraUpdate cameraUpdate) {
    return AMapFlutterPlatform.instance.moveCamera(cameraUpdate, mapId: mapId);
  }

  /// Sets the styling of the base map.
  ///
  /// Set to `null` to clear any previous custom styling.
  ///
  /// If problems were detected with the [mapStyle], including un-parsable
  /// styling JSON, unrecognized feature type, unrecognized element type, or
  /// invalid styler keys: [MapStyleException] is thrown and the current
  /// style is left unchanged.
  ///
  /// The style string can be generated using [map style tool](https://mapstyle.withgoogle.com/).
  /// Also, refer [iOS](https://developers.google.com/maps/documentation/ios-sdk/style-reference)
  /// and [Android](https://developers.google.com/maps/documentation/android-sdk/style-reference)
  /// style reference for more information regarding the supported styles.
  @Deprecated('Use GoogleMap.style instead.')
  Future<void> setMapStyle(String? mapStyle) {
    return AMapFlutterPlatform.instance.setMapStyle(mapStyle, mapId: mapId);
  }

  /// Returns the last style error, if any.
  Future<String?> getStyleError() {
    return AMapFlutterPlatform.instance.getStyleError(mapId: mapId);
  }

  /// Return [LatLngBounds] defining the region that is visible in a map.
  Future<LatLngBounds> getVisibleRegion() {
    return AMapFlutterPlatform.instance.getVisibleRegion(mapId: mapId);
  }

  /// Return [ScreenCoordinate] of the [LatLng] in the current map view.
  ///
  /// A projection is used to translate between on screen location and geographic coordinates.
  /// Screen location is in screen pixels (not display pixels) with respect to the top left corner
  /// of the map, not necessarily of the whole screen.
  Future<ScreenCoordinate> getScreenCoordinate(LatLng latLng) {
    return AMapFlutterPlatform.instance
        .getScreenCoordinate(latLng, mapId: mapId);
  }

  /// Returns [LatLng] corresponding to the [ScreenCoordinate] in the current map view.
  ///
  /// Returned [LatLng] corresponds to a screen location. The screen location is specified in screen
  /// pixels (not display pixels) relative to the top left of the map, not top left of the whole screen.
  Future<LatLng> getLatLng(ScreenCoordinate screenCoordinate) {
    return AMapFlutterPlatform.instance
        .getLatLng(screenCoordinate, mapId: mapId);
  }

  /// Programmatically show the Info Window for a [Marker].
  ///
  /// The `markerId` must match one of the markers on the map.
  /// An invalid `markerId` triggers an "Invalid markerId" error.
  ///
  /// * See also:
  ///   * [hideMarkerInfoWindow] to hide the Info Window.
  ///   * [isMarkerInfoWindowShown] to check if the Info Window is showing.
  Future<void> showMarkerInfoWindow(MarkerId markerId) {
    return AMapFlutterPlatform.instance
        .showMarkerInfoWindow(markerId, mapId: mapId);
  }

  /// Programmatically hide the Info Window for a [Marker].
  ///
  /// The `markerId` must match one of the markers on the map.
  /// An invalid `markerId` triggers an "Invalid markerId" error.
  ///
  /// * See also:
  ///   * [showMarkerInfoWindow] to show the Info Window.
  ///   * [isMarkerInfoWindowShown] to check if the Info Window is showing.
  Future<void> hideMarkerInfoWindow(MarkerId markerId) {
    return AMapFlutterPlatform.instance
        .hideMarkerInfoWindow(markerId, mapId: mapId);
  }

  /// Returns `true` when the [InfoWindow] is showing, `false` otherwise.
  ///
  /// The `markerId` must match one of the markers on the map.
  /// An invalid `markerId` triggers an "Invalid markerId" error.
  ///
  /// * See also:
  ///   * [showMarkerInfoWindow] to show the Info Window.
  ///   * [hideMarkerInfoWindow] to hide the Info Window.
  Future<bool> isMarkerInfoWindowShown(MarkerId markerId) {
    return AMapFlutterPlatform.instance
        .isMarkerInfoWindowShown(markerId, mapId: mapId);
  }

  /// Returns the current zoom level of the map
  Future<double> getZoomLevel() {
    return AMapFlutterPlatform.instance.getZoomLevel(mapId: mapId);
  }

  /// Returns the image bytes of the map
  Future<Uint8List?> takeSnapshot() {
    return AMapFlutterPlatform.instance.takeSnapshot(mapId: mapId);
  }

  /// Disposes of the platform resources
  void dispose() {
    AMapFlutterPlatform.instance.dispose(mapId: mapId);
  }
}
