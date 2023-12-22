package com.amap.flutter.map.overlays.marker;

import com.amap.api.maps.model.BitmapDescriptor;
import com.amap.api.maps.model.LatLng;

/**
 * @author whm
 * @date 2020/11/6 6:12 PM
 * @mail hongming.whm@alibaba-inc.com
 * @since
 */
public interface MarkerOptionsSink {
    void setAlpha(float alpha);

    void setAnchor(float u, float v);

    void setDraggable(boolean draggable);

    void setFlat(boolean flat);

    void setIcon(BitmapDescriptor bitmapDescriptor);

    void setTitle(String title);

    void setSnippet(String snippet);

    void setPosition(LatLng position);

    void setRotation(float rotation);

    void setVisible(boolean visible);

    void setZIndex(float zIndex);

    void setInfoWindowEnable(boolean enable);

    void setClickable(boolean clickable);

}
