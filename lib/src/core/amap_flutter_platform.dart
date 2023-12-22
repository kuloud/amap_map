import 'package:amap_map/src/core/method_channel_amap_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// “amap_map”平台特定实现必须扩展的接口
abstract class AMapFlutterPlatform extends PlatformInterface {
  static final Object _token = Object();
  AMapFlutterPlatform() : super(token: _token);
  static AMapFlutterPlatform _instance = MethodChannelAMapFlutterMap();

  /// The default instance of [AMapFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelAMapFlutterMap].
  static AMapFlutterPlatform get instance => _instance;

  static set instance(AMapFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// /// Initializes the platform interface with [id].
  ///
  /// This method is called when the plugin is first initialized.
  Future<void> init(int id) {
    throw UnimplementedError('init() has not been implemented.');
  }

  void dispose({required int id}) {
    throw UnimplementedError('dispose() has not been implemented.');
  }

  Widget buildView(
      Map<String, dynamic> creationParams,
      Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers,
      PlatformViewCreatedCallback onPlatformViewCreated) {
    throw UnimplementedError('buildView() has not been implemented.');
  }
}
