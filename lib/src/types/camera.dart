import 'package:x_amap_base/x_amap_base.dart';

/// 相机位置，包含可视区域的位置参数。
class CameraPosition {
  /// 构造一个CameraPosition 对象
  ///
  /// 如果[bearing], [target], [tilt], 或者 [zoom] 为null时会返回[AssertionError]
  const CameraPosition({
    this.bearing = 0.0,
    required this.target,
    this.tilt = 0.0,
    this.zoom = 10,
  });

  /// 可视区域指向的方向，以角度为单位，从正北向逆时针方向计算，从0 度到360 度。
  final double bearing;

  /// 目标位置的屏幕中心点经纬度坐标。
  final LatLng target;

  /// 目标可视区域的倾斜度，以角度为单位。范围从0到360度
  final double tilt;

  /// 目标可视区域的缩放级别
  final double zoom;

  /// 将[CameraPosition]装换成Map
  ///
  /// 主要在插件内部使用
  dynamic toMap() => <String, dynamic>{
        'bearing': bearing,
        'target': target.toJson(),
        'tilt': tilt,
        'zoom': zoom,
      };

  /// 从Map转换成[CameraPosition]
  ///
  /// 主要在插件内部使用
  static CameraPosition? fromMap(dynamic json) {
    if (json == null || json is! Map<dynamic, dynamic>) {
      return null;
    }
    final LatLng? target = LatLng.fromJson(json['target']);
    if (target == null) {
      return null;
    }
    return CameraPosition(
      bearing: json['bearing'],
      target: target,
      tilt: json['tilt'],
      zoom: json['zoom'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final CameraPosition typedOther = other as CameraPosition;
    return bearing == typedOther.bearing &&
        target == typedOther.target &&
        tilt == typedOther.tilt &&
        zoom == typedOther.zoom;
  }

  @override
  int get hashCode => Object.hashAll(<Object?>[bearing, target, tilt, zoom]);

  @override
  String toString() =>
      'CameraPosition(bearing: $bearing, target: $target, tilt: $tilt, zoom: $zoom)';
}

/// 描述地图状态将要发生的变化
class CameraUpdate {
  CameraUpdate._(this._json);

  ///返回根据新的[CameraPosition]移动后的[CameraUpdate].
  ///
  ///主要用于改变地图的中心点、缩放级别、倾斜角、角度等信息
  static CameraUpdate newCameraPosition(CameraPosition cameraPosition) {
    return CameraUpdate._(
      <dynamic>['newCameraPosition', cameraPosition.toMap()],
    );
  }

  ///移动到一个新的位置点[latLng]
  ///
  ///主要用于改变地图的中心点
  static CameraUpdate newLatLng(LatLng latLng) {
    return CameraUpdate._(<dynamic>['newLatLng', latLng.toJson()]);
  }

  ///根据指定到摄像头显示范围[bounds]和边界值[padding]创建一个CameraUpdate对象
  ///
  ///主要用于根据指定的显示范围[bounds]以最佳的视野显示地图
  static CameraUpdate newLatLngBounds(LatLngBounds bounds, double padding) {
    return CameraUpdate._(<dynamic>[
      'newLatLngBounds',
      bounds.toJson(),
      padding,
    ]);
  }

  /// 根据指定的新的位置[latLng]和缩放级别[zoom]创建一个CameraUpdate对象
  ///
  /// 主要用于同时改变中心点和缩放级别
  static CameraUpdate newLatLngZoom(LatLng latLng, double zoom) {
    return CameraUpdate._(
      <dynamic>['newLatLngZoom', latLng.toJson(), zoom],
    );
  }

  /// 按照指定到像素点[dx]和[dy]移动地图中心点
  ///
  /// [dx]是水平移动的像素数。正值代表可视区域向右移动，负值代表可视区域向左移动
  ///
  /// [dy]是垂直移动的像素数。正值代表可视区域向下移动，负值代表可视区域向上移动
  ///
  /// 返回包含x，y方向上移动像素数的cameraUpdate对象。
  static CameraUpdate scrollBy(double dx, double dy) {
    return CameraUpdate._(
      <dynamic>['scrollBy', dx, dy],
    );
  }

  /// 创建一个在当前地图显示的级别基础上加1的CameraUpdate对象
  ///
  ///主要用于放大地图缩放级别，在当前地图显示的级别基础上加1
  static CameraUpdate zoomIn() {
    return CameraUpdate._(<dynamic>['zoomIn']);
  }

  /// 创建一个在当前地图显示的级别基础上加1的CameraUpdate对象
  ///
  /// 主要用于减少地图缩放级别，在当前地图显示的级别基础上减1
  static CameraUpdate zoomOut() {
    return CameraUpdate._(<dynamic>['zoomOut']);
  }

  /// 创建一个指定缩放级别[zoom]的CameraUpdate对象
  ///
  /// 主要用于设置地图缩放级别
  static CameraUpdate zoomTo(double zoom) {
    return CameraUpdate._(<dynamic>['zoomTo', zoom]);
  }

  final dynamic _json;

  dynamic toJson() => _json;
}
