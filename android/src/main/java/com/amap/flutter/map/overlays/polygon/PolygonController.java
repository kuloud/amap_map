package com.amap.flutter.map.overlays.polygon;

import com.amap.api.maps.model.AMapPara;
import com.amap.api.maps.model.LatLng;
import com.amap.api.maps.model.Polygon;
import com.amap.api.maps.model.PolygonOptions;

import java.util.List;

/**
 * @author whm
 * @date 2020/11/12 9:52 AM
 * @mail hongming.whm@alibaba-inc.com
 * @since
 */
class PolygonController implements PolygonOptionsSink{

    private final Polygon polygon;
    private final String id;
    PolygonController(Polygon polygon){
        this.polygon = polygon;
        this.id = polygon.getId();
    }

    public String getId() {
        return id;
    }

    public void remove() {
        polygon.remove();
    }

    @Override
    public void setPoints(List<LatLng> points) {
        polygon.setPoints(points);
    }

    @Override
    public void setStrokeWidth(float strokeWidth) {
        polygon.setStrokeWidth(strokeWidth);
    }

    @Override
    public void setStrokeColor(int color) {
        polygon.setStrokeColor(color);
    }

    @Override
    public void setFillColor(int color) {
        polygon.setFillColor(color);
    }

    @Override
    public void setVisible(boolean visible) {
        polygon.setVisible(visible);
    }

    @Override
    public void setLineJoinType(AMapPara.LineJoinType joinType) {
        //不支持动态修改
    }
}
