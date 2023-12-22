import 'package:amap_map/amap_map.dart';
import 'package:x_amap_base/x_amap_base.dart';

///地图事件处理
class MapEvent<T> {
  /// 地图id
  final int mapId;

  ///返回的内容，对应的[MethodCall]中的[[arguments]]
  final T value;

  /// 构造一个event
  ///
  /// `mapId` 当前地图的id
  /// `value` 需要传输的值，可以为`null`.
  MapEvent(this.mapId, this.value);
}

///定位回调接口
class LocationChangedEvent extends MapEvent<AMapLocation> {
  LocationChangedEvent(int mapId, AMapLocation value) : super(mapId, value);
}

///地图移动回调
class CameraPositionMoveEvent extends MapEvent<CameraPosition> {
  CameraPositionMoveEvent(int mapId, CameraPosition value)
      : super(mapId, value);
}

///地图移动结束回调
class CameraPositionMoveEndEvent extends MapEvent<CameraPosition> {
  CameraPositionMoveEndEvent(int mapId, CameraPosition value)
      : super(mapId, value);
}

///点击地图回调
class MapTapEvent extends MapEvent<LatLng> {
  MapTapEvent(int mapId, LatLng value) : super(mapId, value);
}

///长按地图回调
class MapLongPressEvent extends MapEvent<LatLng> {
  MapLongPressEvent(int mapId, LatLng value) : super(mapId, value);
}

/// 带位置回调的地图事件
class _PositionedMapEvent<T> extends MapEvent<T> {
  /// 事件中带的位置信息
  final LatLng position;

  /// 构造一个带位置的地图事件，
  ///
  /// `mapId` 当前地图的id
  /// `value` 需要传输的值，可以为`null`.
  _PositionedMapEvent(int mapId, this.position, T value) : super(mapId, value);
}

/// [Marker] 的点击事件
class MarkerTapEvent extends MapEvent<String> {
  MarkerTapEvent(int mapId, String markerId) : super(mapId, markerId);
}

/// [Marker] 的拖拽结束事件，附带拖拽结束时的位置信息[LatLng].
class MarkerDragEndEvent extends _PositionedMapEvent<String> {
  MarkerDragEndEvent(int mapId, LatLng position, String markerId)
      : super(mapId, position, markerId);
}

/// [Polyline] 的点击事件
class PolylineTapEvent extends MapEvent<String> {
  PolylineTapEvent(int mapId, String polylineId) : super(mapId, polylineId);
}

/// Poi点击事件
class MapPoiTouchEvent extends MapEvent<AMapPoi> {
  MapPoiTouchEvent(int mapId, AMapPoi poi) : super(mapId, poi);
}
