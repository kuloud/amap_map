package com.amap.flutter.map.overlays.marker;

import com.amap.api.maps.model.BitmapDescriptor;
import com.amap.api.maps.model.LatLng;
import com.amap.api.maps.model.MarkerOptions;

/**
 * @author whm
 * @date 2020/11/6 6:17 PM
 * @mail hongming.whm@alibaba-inc.com
 * @since
 */
class MarkerOptionsBuilder implements MarkerOptionsSink {
    final MarkerOptions markerOptions;

    MarkerOptionsBuilder() {
        this.markerOptions = new MarkerOptions();
    }

    public MarkerOptions build() {
        return markerOptions;
    }

    @Override
    public void setAlpha(float alpha) {
        markerOptions.alpha(alpha);
    }

    @Override
    public void setAnchor(float u, float v) {
        markerOptions.anchor(u, v);
    }


    @Override
    public void setDraggable(boolean draggable) {
        markerOptions.draggable(draggable);
    }

    @Override
    public void setFlat(boolean flat) {
        markerOptions.setFlat(flat);
    }

    @Override
    public void setIcon(BitmapDescriptor bitmapDescriptor) {
        markerOptions.icon(bitmapDescriptor);
    }

    @Override
    public void setTitle(String title) {
        markerOptions.title(title);
    }


    @Override
    public void setSnippet(String snippet) {
        markerOptions.snippet(snippet);
    }

    @Override
    public void setPosition(LatLng position) {
        markerOptions.position(position);
    }

    @Override
    public void setRotation(float rotation) {
        markerOptions.rotateAngle(rotation);
    }

    @Override
    public void setVisible(boolean visible) {
        markerOptions.visible(visible);
    }

    @Override
    public void setZIndex(float zIndex) {
        markerOptions.zIndex(zIndex);
    }

    @Override
    public void setInfoWindowEnable(boolean enable) {
        markerOptions.infoWindowEnable(enable);
    }

    @Override
    public void setClickable(boolean clickable) {
    }
}
