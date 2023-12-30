import 'package:flutter/services.dart';

import 'types.dart';

abstract class AMapExtension {
  late String _id;

  String get id => _id;

  AMapExtension() {
    this._id = this.hashCode.toString();
  }

  void prepare(AMapContext aMapContext) {}

  void onDispose() {}

  bindMethodChannel(MethodChannel channel) {}
}

Map<String, AMapExtension> keyByExtensionId(
    Iterable<AMapExtension> extensions) {
  // ignore: unnecessary_null_comparison
  if (extensions == null) {
    return <String, AMapExtension>{};
  }
  return Map<String, AMapExtension>.fromEntries(extensions.map(
      (AMapExtension extension) =>
          MapEntry<String, AMapExtension>(extension.id, extension)));
}
