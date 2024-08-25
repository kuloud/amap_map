/// 地图覆盖物基类
class BaseOverlay {
  /// overlay id
  late String _id;

  String get id => _id;

  BaseOverlay() {
    _id = hashCode.toString();
  }

  void setIdForCopy(String copyId) => _id = copyId;

  BaseOverlay clone() {
    throw UnimplementedError(
        'BaseOverlay subClass should implement this methed.');
  }

  Map<String, dynamic> toMap() {
    throw UnimplementedError(
        'BaseOverlay subClass should implement this methed.');
  }
}

List<Map<String, dynamic>>? serializeOverlaySet(Set<BaseOverlay> overlays) {
  return overlays
      .map<Map<String, dynamic>>((BaseOverlay overlay) => overlay.toMap())
      .toList();
}
