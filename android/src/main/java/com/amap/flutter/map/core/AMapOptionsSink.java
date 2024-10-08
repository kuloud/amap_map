package com.amap.flutter.map.core;

import androidx.annotation.IntRange;

import com.amap.api.maps.AMapOptions;
import com.amap.api.maps.model.CameraPosition;
import com.amap.api.maps.model.CustomMapStyleOptions;
import com.amap.api.maps.model.LatLngBounds;
import com.amap.api.maps.model.MyLocationStyle;

/**
 * @author kuloud
 * @author whm
 * @date 2020/10/29 9:56 AM
 * @mail hongming.whm@alibaba-inc.com
 * @since
 */
public interface AMapOptionsSink extends UISettingsSink {

    void setCamera(CameraPosition camera);

    void setMapType(int mapType);

    public void setCustomMapStyleOptions(CustomMapStyleOptions customMapStyleOptions);

    public void setMyLocationStyle(MyLocationStyle myLocationStyle);

    public void setScreenAnchor(float x, float y);

    public void setMinZoomLevel(float minZoomLevel);

    public void setMaxZoomLevel(float maxZoomLevel);

    public void setLatLngBounds(LatLngBounds latLngBounds);

    public void setTrafficEnabled(boolean trafficEnabled);

    public void setTouchPoiEnabled(boolean touchPoiEnabled);

    public void setBuildingsEnabled(boolean buildingsEnabled);

    public void setLabelsEnabled(boolean labelsEnabled);

    public void setCompassEnabled(boolean compassEnabled);

    public void setScaleEnabled(boolean scaleEnabled);

    public void setZoomGesturesEnabled(boolean zoomGesturesEnabled);

    public void setScrollGesturesEnabled(boolean scrollGesturesEnabled);

    public void setRotateGesturesEnabled(boolean rotateGesturesEnabled);

    public void setTiltGesturesEnabled(boolean tiltGesturesEnabled);

    public void setInitialMarkers(Object initialMarkers);

    public void setInitialPolylines(Object initialPolylines);

    public void setInitialPolygons(Object initialPolygons);

    /**
     * 设置地图语言
     *
     * @param mapLanguage {@link com.amap.api.maps.AMap#CHINESE }, {@link com.amap.api.maps.AMap#ENGLISH }
     */
    void setMapLanguage(String mapLanguage);
}
