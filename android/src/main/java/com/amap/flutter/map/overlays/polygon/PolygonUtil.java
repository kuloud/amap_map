package com.amap.flutter.map.overlays.polygon;

import com.amap.api.maps.model.AMapPara;
import com.amap.flutter.map.overlays.polyline.PolylineOptionsSink;
import com.amap.flutter.map.utils.ConvertUtil;

import java.util.Map;

/**
 * @author whm
 * @date 2020/11/12 10:11 AM
 * @mail hongming.whm@alibaba-inc.com
 * @since
 */
class PolygonUtil {

    static String interpretOptions(Object o, PolygonOptionsSink sink) {
        final Map<?, ?> data = ConvertUtil.toMap(o);
        final Object points = data.get("points");
        if (points != null) {
            sink.setPoints(ConvertUtil.toPoints(points));
        }

        final Object width = data.get("strokeWidth");
        if (width != null) {
            sink.setStrokeWidth(ConvertUtil.toFloatPixels(width));
        }

        final Object strokeColor = data.get("strokeColor");
        if (strokeColor != null) {
            sink.setStrokeColor(ConvertUtil.toInt(strokeColor));
        }

        final Object fillColor = data.get("fillColor");
        if (fillColor != null) {
            sink.setFillColor(ConvertUtil.toInt(fillColor));
        }

        final Object visible = data.get("visible");
        if (visible != null) {
            sink.setVisible(ConvertUtil.toBoolean(visible));
        }

        final Object joinType = data.get("joinType");
        if (joinType != null) {
            sink.setLineJoinType(AMapPara.LineJoinType.valueOf(ConvertUtil.toInt(joinType)));
        }

        final String polylineId = (String) data.get("id");
        if (polylineId == null) {
            throw new IllegalArgumentException("polylineId was null");
        } else {
            return polylineId;
        }
    }


}
