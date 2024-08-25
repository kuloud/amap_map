// Copyright 2023-2024 kuloud
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

part of '../amap_map.dart';

class AMapInitializer {
  static AMapApiKey? _apiKey;
  static AMapPrivacyStatement? _privacyStatement;

  AMapInitializer._();

  /// 初始化地图组件
  ///
  /// @param context 用于图片资源适配屏幕密度，需在[AMapWidget]使用前调用[init]方法
  /// @param apiKey 申请的 AMapSDK Key，如果熟悉原生侧集成配置，可以参考高德文档集成，可选
  ///
  static void init(BuildContext context, {AMapApiKey? apiKey}) {
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
  static void updatePrivacyAgree(AMapPrivacyStatement privacyStatement) {
    _privacyStatement = privacyStatement;
  }
}
