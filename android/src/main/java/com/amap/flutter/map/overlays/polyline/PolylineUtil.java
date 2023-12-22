package com.amap.flutter.map.overlays.polyline;

import android.text.TextUtils;
import android.util.Log;

import com.amap.api.maps.model.PolylineOptions;
import com.amap.flutter.map.utils.ConvertUtil;

import java.util.List;
import java.util.Map;

/**
 * @author whm
 * @date 2020/11/10 4:34 PM
 * @mail hongming.whm@alibaba-inc.com
 * @since
 */
class PolylineUtil {

    private static final String CLASS_NAME = "PolylineUtil";
    //虚线类型
    private static final int[] DASH_LINE_TYPE = {-1,0,1};

    static String interpretOptions(Object o, PolylineOptionsSink sink) {
        final Map<?, ?> data = ConvertUtil.toMap(o);

        final Object points = data.get("points");
        if (points != null) {
            sink.setPoints(ConvertUtil.toPoints(points));
        }

        final Object width = data.get("width");
        if (width != null) {
            sink.setWidth(ConvertUtil.toFloatPixels(width));
        }

        final Object visible = data.get("visible");
        if (visible != null) {
            sink.setVisible(ConvertUtil.toBoolean(visible));
        }

        final Object geodesic = data.get("geodesic");
        if (geodesic != null) {
            sink.setGeodesic(ConvertUtil.toBoolean(geodesic));
        }

        final Object gradient = data.get("gradient");
        if (gradient != null) {
            sink.setGradient(ConvertUtil.toBoolean(gradient));
        }

        final Object alpha = data.get("alpha");
        if (alpha != null) {
            sink.setAlpha(ConvertUtil.toFloat(alpha));
        }

        final Object dashLineType = data.get("dashLineType");
        if (dashLineType != null) {
            int rawType = ConvertUtil.toInt(dashLineType);
            if (rawType > DASH_LINE_TYPE.length) {
                rawType = 0;
            }
            if(DASH_LINE_TYPE[rawType] == -1) {
                sink.setDashLine(false);
            } else {
                sink.setDashLine(true);
                sink.setDashLineType(DASH_LINE_TYPE[rawType]);
            }
        }

        final Object capType = data.get("capType");
        if (capType != null) {
            sink.setLineCapType(PolylineOptions.LineCapType.valueOf(ConvertUtil.toInt(capType)));
        }

        final Object joinType = data.get("joinType");
        if (joinType != null) {
            sink.setLineJoinType(PolylineOptions.LineJoinType.valueOf(ConvertUtil.toInt(joinType)));
        }


        final Object customTexture = data.get("customTexture");
        if (customTexture != null) {
            sink.setCustomTexture(ConvertUtil.toBitmapDescriptor(customTexture));
        }

        final Object customTextureList = data.get("customTextureList");
        if (customTextureList != null) {
            sink.setCustomTextureList(ConvertUtil.toBitmapDescriptorList(customTextureList));
        }

        final Object color = data.get("color");
        if (color != null) {
            sink.setColor(ConvertUtil.toInt(color));
        }

        final Object colorList = data.get("colorList");
        if (colorList != null) {
            sink.setColorList((List<Integer>) ConvertUtil.toList(colorList));
        }

        final String dartId = (String) data.get("id");
        if(TextUtils.isEmpty(dartId)) {
            Log.w(CLASS_NAME, "没有传入正确的dart层ID, 请确认对应的key值是否正确！！！");
        }
        return dartId;
    }
}
