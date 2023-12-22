package com.amap.flutter.map.overlays.marker;

import com.amap.api.maps.model.BitmapDescriptor;
import com.amap.api.maps.model.LatLng;
import com.amap.api.maps.model.Marker;

/**
 * @author whm
 * @date 2020/11/6 6:18 PM
 * @mail hongming.whm@alibaba-inc.com
 * @since
 */
class MarkerController implements MarkerOptionsSink {
    private final Marker marker;
    private final String markerId;

    MarkerController(Marker marker) {
        this.marker = marker;
        markerId = marker.getId();
    }

    public String getMarkerId() {
        return markerId;
    }

    public void remove() {
        if (null != marker) {
            marker.remove();
        }
    }

    public LatLng getPosition() {
        if(null != marker) {
            return marker.getPosition();
        }
        return null;
    }

    @Override
    public void setAlpha(float alpha) {
        marker.setAlpha(alpha);
    }

    @Override
    public void setAnchor(float u, float v) {
        marker.setAnchor(u, v);
    }

    @Override
    public void setDraggable(boolean draggable) {
        marker.setDraggable(draggable);
    }

    @Override
    public void setFlat(boolean flat) {
        marker.setFlat(flat);
    }

    @Override
    public void setIcon(BitmapDescriptor bitmapDescriptor) {
        marker.setIcon(bitmapDescriptor);
    }

    @Override
    public void setTitle(String title) {
        marker.setTitle(title);
    }

    @Override
    public void setSnippet(String snippet) {
        marker.setSnippet(snippet);
    }

    @Override
    public void setPosition(LatLng position) {
        marker.setPosition(position);
    }

    @Override
    public void setRotation(float rotation) {
        marker.setRotateAngle(rotation);
    }

    @Override
    public void setVisible(boolean visible) {
        marker.setVisible(visible);
    }

    @Override
    public void setZIndex(float zIndex) {
        marker.setZIndex(zIndex);
    }

    @Override
    public void setInfoWindowEnable(boolean enable) {
        marker.setInfoWindowEnable(enable);
    }

    @Override
    public void setClickable(boolean clickable) {
        marker.setClickable(clickable);
    }

    public void showInfoWindow() {
        marker.showInfoWindow();
    }

    public void hideInfoWindow() {
        marker.hideInfoWindow();
    }
}
