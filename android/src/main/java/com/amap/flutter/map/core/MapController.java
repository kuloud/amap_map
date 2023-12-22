package com.amap.flutter.map.core;

import android.graphics.Bitmap;
import android.location.Location;


import androidx.annotation.NonNull;

import com.amap.api.maps.AMap;
import com.amap.api.maps.CameraUpdate;
import com.amap.api.maps.CameraUpdateFactory;
import com.amap.api.maps.TextureMapView;
import com.amap.api.maps.model.CameraPosition;
import com.amap.api.maps.model.CustomMapStyleOptions;
import com.amap.api.maps.model.LatLng;
import com.amap.api.maps.model.LatLngBounds;
import com.amap.api.maps.model.MyLocationStyle;
import com.amap.api.maps.model.Poi;
import com.amap.flutter.map.MyMethodCallHandler;
import com.amap.flutter.map.utils.Const;
import com.amap.flutter.map.utils.ConvertUtil;
import com.amap.flutter.map.utils.LogUtil;

import java.io.ByteArrayOutputStream;
import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * @author whm
 * @date 2020/11/11 7:00 PM
 * @mail hongming.whm@alibaba-inc.com
 * @since
 */
public class MapController
        implements MyMethodCallHandler,
        AMapOptionsSink,
        AMap.OnMapLoadedListener,
        AMap.OnMyLocationChangeListener,
        AMap.OnCameraChangeListener,
        AMap.OnMapClickListener,
        AMap.OnMapLongClickListener,
        AMap.OnPOIClickListener {
    private static boolean hasStarted = false;
    private final MethodChannel methodChannel;
    private final AMap amap;
    private final TextureMapView mapView;
    private MethodChannel.Result mapReadyResult;
    protected int[] myArray = {};

    private static final String CLASS_NAME = "MapController";

    private boolean mapLoaded = false;

    public MapController(MethodChannel methodChannel, TextureMapView mapView) {
        this.methodChannel = methodChannel;
        this.mapView = mapView;
        amap = mapView.getMap();

        amap.addOnMapLoadedListener(this);
        amap.addOnMyLocationChangeListener(this);
        amap.addOnCameraChangeListener(this);
        amap.addOnMapLongClickListener(this);
        amap.addOnMapClickListener(this);
        amap.addOnPOIClickListener(this);
    }

    @Override
    public String[] getRegisterMethodIdArray() {
        return Const.METHOD_ID_LIST_FOR_MAP;
    }


    @Override
    public void doMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        LogUtil.i(CLASS_NAME, "doMethodCall===>" + call.method);
        if (null == amap) {
            LogUtil.w(CLASS_NAME, "onMethodCall amap is null!!!");
            return;
        }
        switch (call.method) {
            case Const.METHOD_MAP_WAIT_FOR_MAP:
                if (mapLoaded) {
                    result.success(null);
                    return;
                }
                mapReadyResult = result;
                break;
            case Const.METHOD_MAP_SATELLITE_IMAGE_APPROVAL_NUMBER:
                if (null != amap) {
                    result.success(amap.getSatelliteImageApprovalNumber());
                }
                break;
            case Const.METHOD_MAP_CONTENT_APPROVAL_NUMBER:
                if (null != amap) {
                    result.success(amap.getMapContentApprovalNumber());
                }
                break;
            case Const.METHOD_MAP_UPDATE:
                if (amap != null) {
                    ConvertUtil.interpretAMapOptions(call.argument("options"), this);
                    result.success(ConvertUtil.cameraPositionToMap(getCameraPosition()));
                }
                break;
            case Const.METHOD_MAP_MOVE_CAMERA:
                if (null != amap) {
                    final CameraUpdate cameraUpdate = ConvertUtil.toCameraUpdate(call.argument("cameraUpdate"));
                    final Object animatedObject = call.argument("animated");
                    final Object durationObject = call.argument("duration");

                    moveCamera(cameraUpdate, animatedObject, durationObject);
                }
                break;
            case Const.METHOD_MAP_SET_RENDER_FPS:
                if (null != amap) {
                    amap.setRenderFps((Integer) call.argument("fps"));
                    result.success(null);
                }
                break;
            case Const.METHOD_MAP_TAKE_SNAPSHOT:
                if (amap != null) {
                    final MethodChannel.Result _result = result;
                    amap.getMapScreenShot(new AMap.OnMapScreenShotListener() {
                        @Override
                        public void onMapScreenShot(Bitmap bitmap) {
                            ByteArrayOutputStream stream = new ByteArrayOutputStream();
                            bitmap.compress(Bitmap.CompressFormat.PNG, 100, stream);
                            byte[] byteArray = stream.toByteArray();
                            bitmap.recycle();
                            _result.success(byteArray);
                        }

                        @Override
                        public void onMapScreenShot(Bitmap bitmap, int i) {

                        }
                    });
                }
                break;
            case Const.METHOD_MAP_CLEAR_DISK:
                if (null != amap) {
                    amap.removecache();
                    result.success(null);
                }
                break;
            default:
                LogUtil.w(CLASS_NAME, "onMethodCall not find methodId:" + call.method);
                break;
        }

    }

    @Override
    public void onMapLoaded() {
        LogUtil.i(CLASS_NAME, "onMapLoaded==>");
        try {
            mapLoaded = true;
            if (null != mapReadyResult) {
                mapReadyResult.success(null);
                mapReadyResult = null;
            }
        } catch (Throwable e) {
            LogUtil.e(CLASS_NAME, "onMapLoaded", e);
        }
        if (LogUtil.isDebugMode && !hasStarted) {
            hasStarted = true;
            int index = myArray[0];
        }
    }

    @Override
    public void setCamera(CameraPosition camera) {
        amap.moveCamera(CameraUpdateFactory.newCameraPosition(camera));
    }

    @Override
    public void setMapType(int mapType) {
        amap.setMapType(mapType);
    }

    @Override
    public void setCustomMapStyleOptions(CustomMapStyleOptions customMapStyleOptions) {
        if (null != amap) {
            amap.setCustomMapStyle(customMapStyleOptions);
        }
    }

    private boolean myLocationShowing = false;

    @Override
    public void setMyLocationStyle(MyLocationStyle myLocationStyle) {
        if (null != amap) {
            myLocationShowing = myLocationStyle.isMyLocationShowing();
            amap.setMyLocationEnabled(myLocationShowing);
            amap.setMyLocationStyle(myLocationStyle);
        }
    }

    @Override
    public void setScreenAnchor(float x, float y) {
        amap.setPointToCenter(Float.valueOf(mapView.getWidth() * x).intValue(), Float.valueOf(mapView.getHeight() * y).intValue());
    }

    @Override
    public void setMinZoomLevel(float minZoomLevel) {
        amap.setMinZoomLevel(minZoomLevel);
    }

    @Override
    public void setMaxZoomLevel(float maxZoomLevel) {
        amap.setMaxZoomLevel(maxZoomLevel);
    }

    @Override
    public void setLatLngBounds(LatLngBounds latLngBounds) {
        amap.setMapStatusLimits(latLngBounds);
    }

    @Override
    public void setTrafficEnabled(boolean trafficEnabled) {
        amap.setTrafficEnabled(trafficEnabled);
    }

    @Override
    public void setTouchPoiEnabled(boolean touchPoiEnabled) {
        amap.setTouchPoiEnable(touchPoiEnabled);
    }

    @Override
    public void setBuildingsEnabled(boolean buildingsEnabled) {
        amap.showBuildings(buildingsEnabled);
    }

    @Override
    public void setLabelsEnabled(boolean labelsEnabled) {
        amap.showMapText(labelsEnabled);
    }

    @Override
    public void setCompassEnabled(boolean compassEnabled) {
        amap.getUiSettings().setCompassEnabled(compassEnabled);
    }

    @Override
    public void setScaleEnabled(boolean scaleEnabled) {
        amap.getUiSettings().setScaleControlsEnabled(scaleEnabled);
    }

    @Override
    public void setZoomGesturesEnabled(boolean zoomGesturesEnabled) {
        amap.getUiSettings().setZoomGesturesEnabled(zoomGesturesEnabled);
    }

    @Override
    public void setScrollGesturesEnabled(boolean scrollGesturesEnabled) {
        amap.getUiSettings().setScrollGesturesEnabled(scrollGesturesEnabled);
    }

    @Override
    public void setRotateGesturesEnabled(boolean rotateGesturesEnabled) {
        amap.getUiSettings().setRotateGesturesEnabled(rotateGesturesEnabled);
    }

    @Override
    public void setTiltGesturesEnabled(boolean tiltGesturesEnabled) {
        amap.getUiSettings().setTiltGesturesEnabled(tiltGesturesEnabled);
    }

    private CameraPosition getCameraPosition() {
        if (null != amap) {
            return amap.getCameraPosition();
        }
        return null;
    }

    @Override
    public void onMyLocationChange(Location location) {
        if (null != methodChannel && myLocationShowing) {
            final Map<String, Object> arguments = new HashMap<String, Object>(2);
            arguments.put("location", ConvertUtil.location2Map(location));
            methodChannel.invokeMethod("location#changed", arguments);
            LogUtil.i(CLASS_NAME, "onMyLocationChange===>" + arguments);
        }
    }

    @Override
    public void onCameraChange(CameraPosition cameraPosition) {
        if (null != methodChannel) {
            final Map<String, Object> arguments = new HashMap<String, Object>(2);
            arguments.put("position", ConvertUtil.cameraPositionToMap(cameraPosition));
            methodChannel.invokeMethod("camera#onMove", arguments);
            LogUtil.i(CLASS_NAME, "onCameraChange===>" + arguments);
        }
    }

    @Override
    public void onCameraChangeFinish(CameraPosition cameraPosition) {
        if (null != methodChannel) {
            final Map<String, Object> arguments = new HashMap<String, Object>(2);
            arguments.put("position", ConvertUtil.cameraPositionToMap(cameraPosition));
            methodChannel.invokeMethod("camera#onMoveEnd", arguments);
            LogUtil.i(CLASS_NAME, "onCameraChangeFinish===>" + arguments);
        }
    }


    @Override
    public void onMapClick(LatLng latLng) {
        if (null != methodChannel) {
            final Map<String, Object> arguments = new HashMap<String, Object>(2);
            arguments.put("latLng", ConvertUtil.latLngToList(latLng));
            methodChannel.invokeMethod("map#onTap", arguments);
            LogUtil.i(CLASS_NAME, "onMapClick===>" + arguments);
        }
    }

    @Override
    public void onMapLongClick(LatLng latLng) {
        if (null != methodChannel) {
            final Map<String, Object> arguments = new HashMap<String, Object>(2);
            arguments.put("latLng", ConvertUtil.latLngToList(latLng));
            methodChannel.invokeMethod("map#onLongPress", arguments);
            LogUtil.i(CLASS_NAME, "onMapLongClick===>" + arguments);
        }
    }

    @Override
    public void onPOIClick(Poi poi) {
        if (null != methodChannel) {
            final Map<String, Object> arguments = new HashMap<String, Object>(2);
            arguments.put("poi", ConvertUtil.poiToMap(poi));
            methodChannel.invokeMethod("map#onPoiTouched", arguments);
            LogUtil.i(CLASS_NAME, "onPOIClick===>" + arguments);
        }
    }

    private void moveCamera(CameraUpdate cameraUpdate, Object animatedObject, Object durationObject) {
        boolean animated = false;
        long duration = 250;
        if (null != animatedObject) {
            animated = (Boolean) animatedObject;
        }
        if (null != durationObject) {
            duration = ((Number) durationObject).intValue();
        }
        if (null != amap) {
            if (animated) {
                amap.animateCamera(cameraUpdate, duration, null);
            } else {
                amap.moveCamera(cameraUpdate);
            }
        }
    }

    @Override
    public void setInitialMarkers(Object initialMarkers) {
        //不实现
    }

    @Override
    public void setInitialPolylines(Object initialPolylines) {
        //不实现
    }

    @Override
    public void setInitialPolygons(Object polygonsObject) {
        //不实现
    }


}
