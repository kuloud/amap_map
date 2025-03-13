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

    void setCustomMapStyleOptions(CustomMapStyleOptions customMapStyleOptions);

    void setMyLocationStyle(MyLocationStyle myLocationStyle);

    void setScreenAnchor(float x, float y);

    void setMinZoomLevel(float minZoomLevel);

    void setMaxZoomLevel(float maxZoomLevel);

    void setLatLngBounds(LatLngBounds latLngBounds);

    void setTrafficEnabled(boolean trafficEnabled);

    void setTouchPoiEnabled(boolean touchPoiEnabled);

    void setBuildingsEnabled(boolean buildingsEnabled);

    void setLabelsEnabled(boolean labelsEnabled);

    void setCompassEnabled(boolean compassEnabled);

    void setScaleEnabled(boolean scaleEnabled);

    void setZoomGesturesEnabled(boolean zoomGesturesEnabled);

    void setScrollGesturesEnabled(boolean scrollGesturesEnabled);

    void setRotateGesturesEnabled(boolean rotateGesturesEnabled);

    void setTiltGesturesEnabled(boolean tiltGesturesEnabled);

    void setInitialMarkers(Object initialMarkers);

    void setInitialPolylines(Object initialPolylines);

    void setInitialPolygons(Object initialPolygons);

    /**
     * 设置地图语言
     *
     * @param mapLanguage {@link com.amap.api.maps.AMap#CHINESE }, {@link com.amap.api.maps.AMap#ENGLISH }
     */
    void setMapLanguage(String mapLanguage);
}
