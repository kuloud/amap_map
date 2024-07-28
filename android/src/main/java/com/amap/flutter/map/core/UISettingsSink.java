package com.amap.flutter.map.core;

import androidx.annotation.IntRange;

import com.amap.api.maps.AMapOptions;

/**
 * @author kuloud
 */
public interface UISettingsSink {

    /**
     * 设置“高德地图”Logo的位置。
     *
     * @param logoPosition
     */
    void setLogoPosition(@IntRange(from = AMapOptions.LOGO_POSITION_BOTTOM_LEFT, to = AMapOptions.LOGO_POSITION_BOTTOM_RIGHT) int logoPosition);

    /**
     * 获取“高德地图”Logo的位置。
     *
     * @return
     */
    int getLogoPosition();

    /**
     * 设置Logo下边界距离屏幕底部的边距
     * Note: SDK 内有setLogoMarginRate接口按比例设置Logo位置，但是高德官方文档没有相关参数描述
     *
     * @param pixels
     */
    void setLogoBottomMargin(int pixels);

    /**
     * 设置Logo左边界距离屏幕左侧的边距
     * Note: SDK 内有setLogoMarginRate接口按比例设置Logo位置，但是高德官方文档没有相关参数描述
     *
     * @param pixels
     */
    void setLogoLeftMargin(int pixels);
}
