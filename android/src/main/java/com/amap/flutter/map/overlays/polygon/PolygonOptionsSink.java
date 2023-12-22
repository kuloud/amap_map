package com.amap.flutter.map.overlays.polygon;

import com.amap.api.maps.model.AMapPara;
import com.amap.api.maps.model.LatLng;

import java.util.List;

/**
 * @author whm
 * @date 2020/11/12 9:52 AM
 * @mail hongming.whm@alibaba-inc.com
 * @since
 */
interface PolygonOptionsSink {
    //多边形坐标点列表
    void setPoints(List<LatLng> points);

    //边框宽度
    void setStrokeWidth(float strokeWidth);

    //边框颜色
    void setStrokeColor(int color);

    //填充颜色
    void setFillColor(int color);

    //是否显示
    void setVisible(boolean visible);

    //边框连接类型
    void setLineJoinType(AMapPara.LineJoinType joinType);
}
