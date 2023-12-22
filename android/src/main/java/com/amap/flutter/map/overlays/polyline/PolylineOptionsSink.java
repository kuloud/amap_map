package com.amap.flutter.map.overlays.polyline;

import com.amap.api.maps.model.BitmapDescriptor;
import com.amap.api.maps.model.LatLng;
import com.amap.api.maps.model.PolylineOptions;

import java.util.List;

/**
 * @author whm
 * @date 2020/11/10 2:58 PM
 * @mail hongming.whm@alibaba-inc.com
 * @since
 */
public interface PolylineOptionsSink {
    //路线点
    void setPoints(List<LatLng> points);

    //宽度
    void setWidth(float width);

    //颜色
    void setColor(int color);

    //是否显示
    void setVisible(boolean visible);

    //纹理
    void setCustomTexture(BitmapDescriptor customTexture);

    //纹理列表
    void setCustomTextureList(List<BitmapDescriptor> customTextureList);

    //颜色列表
    void setColorList(List<Integer> colorList);

    //纹理顺序
    void setCustomIndexList(List<Integer> customIndexList);

    //是否大地曲线
    void setGeodesic(boolean geodesic);

    //是否渐变
    void setGradient(boolean gradient);

    //透明度
    void setAlpha(float alpha);

    //虚线类型
    void setDashLineType(int type);

    //是否虚线
    void setDashLine(boolean dashLine);

    //线冒类型
    void setLineCapType(PolylineOptions.LineCapType lineCapType);

    //线交接类型
    void setLineJoinType(PolylineOptions.LineJoinType joinType);

}
