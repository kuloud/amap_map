package com.amap.flutter.map.overlays.marker;

import android.text.TextUtils;

import com.amap.flutter.map.overlays.marker.MarkerOptionsSink;
import com.amap.flutter.map.utils.ConvertUtil;

import java.util.List;
import java.util.Map;

/**
 * @author whm
 * @date 2020/11/6 8:06 PM
 * @mail hongming.whm@alibaba-inc.com
 * @since
 */
public class MarkerUtil {
    public static String interpretMarkerOptions(Object o, MarkerOptionsSink sink) {
        if (null == o) {
            return null;
        }
        final Map<?, ?> data = ConvertUtil.toMap(o);
        final Object alpha = data.get("alpha");
        if (alpha != null) {
            sink.setAlpha(ConvertUtil.toFloat(alpha));
        }
        final Object anchor = data.get("anchor");
        if (anchor != null) {
            final List<?> anchorData = ConvertUtil.toList(anchor);
            sink.setAnchor(ConvertUtil.toFloat(anchorData.get(0)), ConvertUtil.toFloat(anchorData.get(1)));
        }
        final Object consumeTapEvents = data.get("consumeTapEvents");
        final Object draggable = data.get("draggable");
        if (draggable != null) {
            sink.setDraggable(ConvertUtil.toBoolean(draggable));
        }
        final Object flat = data.get("flat");
        if (flat != null) {
            sink.setFlat(ConvertUtil.toBoolean(flat));
        }
        final Object icon = data.get("icon");
        if (icon != null) {
            sink.setIcon(ConvertUtil.toBitmapDescriptor(icon));
        }

        final Object infoWindow = data.get("infoWindow");
        if (infoWindow != null) {
            interpretInfoWindowOptions(sink, (Map<String, Object>) infoWindow);
        }
        final Object position = data.get("position");
        if (position != null) {
            sink.setPosition(ConvertUtil.toLatLng(position));
        }
        final Object rotation = data.get("rotation");
        if (rotation != null) {
            sink.setRotation(Math.abs(360- ConvertUtil.toFloat(rotation)));
        }
        final Object visible = data.get("visible");
        if (visible != null) {
            sink.setVisible(ConvertUtil.toBoolean(visible));
        }
        final Object zIndex = data.get("zIndex");
        if (zIndex != null) {
            sink.setZIndex(ConvertUtil.toFloat(zIndex));
        }

        final Object infoWindowEnable = data.get("infoWindowEnable");

        if(infoWindowEnable != null) {
            sink.setInfoWindowEnable(ConvertUtil.toBoolean(infoWindowEnable));
        }

        final Object clickable = data.get("clickable");
        if (null != clickable) {
            sink.setClickable(ConvertUtil.toBoolean(clickable));
        }

        final String markerId = (String) data.get("id");
        if (markerId == null) {
            throw new IllegalArgumentException("markerId was null");
        } else {
            return markerId;
        }
    }

    private static void interpretInfoWindowOptions(
            MarkerOptionsSink sink, Map<String, Object> infoWindow) {
        String title = (String) infoWindow.get("title");
        String snippet = (String) infoWindow.get("snippet");
        // snippet is nullable.
        if (!TextUtils.isEmpty(title)) {
            sink.setTitle(title);
        }
        if (!TextUtils.isEmpty(snippet)) {
            sink.setSnippet(snippet);
        }
    }
}
