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
  LocationChangedEvent(super.mapId, super.value);
}

///地图移动回调
class CameraMoveEvent extends MapEvent<CameraPosition> {
  CameraMoveEvent(super.mapId, super.value);
}

///地图移动结束回调
class CameraMoveEndEvent extends MapEvent<CameraPosition> {
  CameraMoveEndEvent(super.mapId, super.value);
}

///点击地图回调
class MapTapEvent extends MapEvent<LatLng> {
  MapTapEvent(super.mapId, super.value);
}

///长按地图回调
class MapLongPressEvent extends MapEvent<LatLng> {
  MapLongPressEvent(super.mapId, super.value);
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
  MarkerTapEvent(super.mapId, super.markerId);
}

/// [Marker] 的拖拽结束事件，附带拖拽结束时的位置信息[LatLng].
class MarkerDragEndEvent extends _PositionedMapEvent<String> {
  MarkerDragEndEvent(super.mapId, super.position, super.markerId);
}

/// [Polyline] 的点击事件
class PolylineTapEvent extends MapEvent<String> {
  PolylineTapEvent(super.mapId, super.polylineId);
}

/// Poi点击事件
class MapPoiTouchEvent extends MapEvent<AMapPoi> {
  MapPoiTouchEvent(super.mapId, super.poi);
}
