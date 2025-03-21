import 'dart:typed_data';
import 'dart:ui' show Color;
import 'package:amap_map/src/compatibility/color_extensions.dart';
import 'package:x_amap_base/x_amap_base.dart';
import 'package:amap_map/amap_map.dart';

/// 地图类型
enum MapType {
  /// 普通地图
  normal,

  /// 卫星地图
  satellite,

  /// 夜间视图
  night,

  /// 导航视图
  navi,

  /// 公交视图
  bus,
}

/// 地图底图语言，目前支持中文底图和英文底图
enum MapLanguage {
  chinese('zh_cn'),
  english('en');

  final String value;
  const MapLanguage(this.value);
}

// 设置摄像机的边界.
class CameraTargetBounds {
  /// 使用指定的边界框或空值创建摄影机目标边界
  ///
  /// 设置为null时代表不指定边界
  const CameraTargetBounds(this.bounds);

  /// 摄像机的边界.
  ///
  /// null代表不指定边界
  final LatLngBounds? bounds;

  /// 取消指定边界
  static const CameraTargetBounds unbounded = CameraTargetBounds(null);

  /// 转换成json对象
  dynamic toJson() => <dynamic>[bounds?.toJson()];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CameraTargetBounds && bounds == other.bounds;
  }

  @override
  int get hashCode => bounds.hashCode;

  @override
  String toString() {
    return 'CameraTargetBounds(bounds: $bounds)';
  }
}

/// 地图最大最小缩放级别的封装对象
class MinMaxZoomPreference {
  /// 为地图创建一个不可变的最大最小缩放范围
  ///
  /// 缩放级别范围为[3, 20]，超出范围取边界值
  ///
  const MinMaxZoomPreference(double minZoom, double maxZoom)
      : minZoom = ((minZoom < 3 ? 3 : minZoom) > (maxZoom > 20 ? 20 : maxZoom)
            ? maxZoom
            : minZoom),
        maxZoom = ((minZoom < 3 ? 3 : minZoom) > (maxZoom > 20 ? 20 : maxZoom)
            ? minZoom
            : maxZoom);

  /// 最小zoomLevel
  final double? minZoom;

  /// 最大zoomLevel
  final double? maxZoom;

  /// 高德地图默认zoomLevel的范围.
  static const MinMaxZoomPreference defaultPreference =
      MinMaxZoomPreference(3, 20);

  /// JSON序列化.
  dynamic toJson() => <dynamic>[minZoom, maxZoom];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    final MinMaxZoomPreference typedOther = other as MinMaxZoomPreference;
    return minZoom == typedOther.minZoom && maxZoom == typedOther.maxZoom;
  }

  @override
  int get hashCode => Object.hashAll(<Object?>[minZoom, maxZoom]);

  @override
  String toString() {
    return 'MinMaxZoomPreference(minZoom: $minZoom, maxZoom: $maxZoom)';
  }
}

///定位小蓝点配置项
class MyLocationStyleOptions {
  ///是否显示定位小蓝点
  bool enabled;

  ///精度圈填充色
  Color? circleFillColor;

  ///精度圈边框色
  Color? circleStrokeColor;

  ///精度圈边框宽度
  double? circleStrokeWidth;

  ///小蓝点图标
  BitmapDescriptor? icon;

  MyLocationStyleOptions(
    this.enabled, {
    this.circleFillColor,
    this.circleStrokeColor,
    this.circleStrokeWidth,
    this.icon,
  });

  MyLocationStyleOptions clone() {
    return MyLocationStyleOptions(
      enabled,
      circleFillColor: circleFillColor,
      circleStrokeColor: circleStrokeColor,
      circleStrokeWidth: circleStrokeWidth,
      icon: icon,
    );
  }

  static MyLocationStyleOptions? fromMap(dynamic json) {
    if (null == json) {
      return null;
    }
    return MyLocationStyleOptions(
      json['enabled'] ?? false,
      circleFillColor: json['circleFillColor'],
      circleStrokeColor: json['circleStrokeColor'],
      circleStrokeWidth: json['circleStrokeWidth'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> json = <String, dynamic>{};

    void addIfPresent(String fieldName, dynamic value) {
      if (value != null) {
        json[fieldName] = value;
      }
    }

    addIfPresent('enabled', enabled);
    addIfPresent('circleFillColor', circleFillColor?.argbValue);
    addIfPresent('circleStrokeColor', circleStrokeColor?.argbValue);
    addIfPresent('circleStrokeWidth', circleStrokeWidth);
    addIfPresent('icon', icon?.toMap());
    return json;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    if (other is! MyLocationStyleOptions) return false;
    final MyLocationStyleOptions typedOther = other;
    return enabled == typedOther.enabled &&
        circleFillColor == typedOther.circleFillColor &&
        circleStrokeColor == typedOther.circleStrokeColor &&
        icon == typedOther.icon;
  }

  @override
  String toString() {
    return 'MyLocationOptionsStyle{'
        'enabled: $enabled,'
        'circleFillColor: $circleFillColor,'
        'circleStrokeColor: $circleStrokeColor,'
        'icon: $icon, }';
  }

  @override
  int get hashCode => Object.hashAll(
      <Object?>[enabled, circleFillColor, circleStrokeColor, icon]);
}

///地图自定义样式
class CustomStyleOptions {
  ///开关项，是否开启自定义地图
  bool enabled;

  ///自定义样式的二进制数据，对应下载的自定义地图文件中的style.data中的二进制数据
  Uint8List? styleData;

  ///自定义扩展样式的二进制数据,对应下载的自定义地图文件中的style_extra.data中的二进制数据
  Uint8List? styleExtraData;

  CustomStyleOptions(
    this.enabled, {
    this.styleData,
    this.styleExtraData,
  });

  static CustomStyleOptions? fromMap(dynamic json) {
    if (json == null) {
      return null;
    }
    return CustomStyleOptions(
      json['enabled'] ?? false,
      styleData: json['styleData'],
      styleExtraData: json['styleExtraData'],
    );
  }

  dynamic toMap() {
    final Map<String, dynamic> json = <String, dynamic>{};
    void addIfPresent(String fieldName, dynamic value) {
      if (value != null) {
        json[fieldName] = value;
      }
    }

    addIfPresent('enabled', enabled);
    addIfPresent('styleData', styleData);
    addIfPresent('styleExtraData', styleExtraData);
    return json;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (runtimeType != other.runtimeType) return false;
    if (other is! CustomStyleOptions) return false;
    final CustomStyleOptions typedOther = other;
    return enabled == typedOther.enabled &&
        styleData == typedOther.styleData &&
        styleExtraData == typedOther.styleExtraData;
  }

  @override
  int get hashCode =>
      Object.hashAll(<Object?>[enabled, styleData, styleExtraData]);

  CustomStyleOptions clone() {
    return CustomStyleOptions(enabled,
        styleData: styleData, styleExtraData: styleExtraData);
  }
}
