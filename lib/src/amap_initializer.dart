part of amap_map;

class AMapInitializer {
  static AMapApiKey? _apiKey;
  static AMapPrivacyStatement? _privacyStatement;

  AMapInitializer._();

  static Future<void> init(BuildContext context, AMapApiKey apiKey) async {
    AMapUtil.init(context);
    _apiKey = apiKey;
  }

  /// 在app首次启动时必须传入高德合规声明配置[privacyStatement],后续如果没有变化不需要重复设置
  /// <li>[privacyStatement.hasContains] 隐私权政策是否包含高德开平隐私权政策</li>
  /// <li>[privacyStatement.hasShow] 是否已经弹窗展示给用户</li>
  /// <li>[privacyStatement.hasAgree] 隐私权政策是否已经取得用户同意</li>
  /// 以上三个值，任何一个为false都会造成地图插件不工作（白屏情况）
  ///
  /// 高德SDK合规使用方案请参考：https://lbs.amap.com/news/sdkhgsy
  ///
  static updatePrivacyAgree(AMapPrivacyStatement privacyStatement) {
    _privacyStatement = privacyStatement;
  }
}
