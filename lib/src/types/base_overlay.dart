import 'package:flutter/foundation.dart';

class BaseOverlay {
  /// overlay id
  String _id;

  String get id => _id;

  // 初始化 _id，在创建对象时唯一确定
  BaseOverlay() : _id = _generateUniqueId();

  // 设置复制的 ID，确保拷贝对象时的唯一性或保留性
  void setIdForCopy(String copyId) {
    if (copyId.isNotEmpty) {
      _id = copyId;
    } else {
      throw ArgumentError('Invalid ID for copy');
    }
  }

  // 克隆对象，确保子类正确实现 clone 方法
  BaseOverlay clone() {
    throw UnimplementedError(
        'BaseOverlay subClass should implement this method.');
  }

  // 将对象转换为 map 表示
  Map<String, dynamic> toMap() {
    throw UnimplementedError(
        'BaseOverlay subClass should implement this method.');
  }

  // 生成唯一 ID 的静态方法
  static String _generateUniqueId() {
    return '${DateTime.now().millisecondsSinceEpoch}_${UniqueKey()}';
  }
}

// 序列化覆盖物集合
List<Map<String, dynamic>>? serializeOverlaySet(Set<BaseOverlay> overlays) {
  return overlays
      .map<Map<String, dynamic>>((BaseOverlay overlay) => overlay.toMap())
      .toList();
}
