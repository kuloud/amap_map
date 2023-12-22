import 'package:x_amap_base/x_amap_base.dart';

class ConstConfig {
  static const AMapApiKey amapApiKeys = AMapApiKey(
      androidKey: '900f72eeee0f21e435cebb0ef155582a',
      iosKey: '4dfdec97b7bf0b8c13e94777103015a9');
  static const AMapPrivacyStatement amapPrivacyStatement =
      AMapPrivacyStatement(hasContains: true, hasShow: true, hasAgree: true);
}
