package com.amap.flutter.map;

import android.content.Context;
import android.os.Bundle;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.lifecycle.DefaultLifecycleObserver;
import androidx.lifecycle.LifecycleOwner;

import com.amap.api.maps.AMap;
import com.amap.api.maps.AMapOptions;
import com.amap.api.maps.TextureMapView;
import com.amap.flutter.map.core.MapController;
import com.amap.flutter.map.core.MapsInitializerController;
import com.amap.flutter.map.overlays.marker.MarkersController;
import com.amap.flutter.map.overlays.polygon.PolygonsController;
import com.amap.flutter.map.overlays.polyline.PolylinesController;
import com.amap.flutter.map.utils.LogUtil;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.platform.PlatformView;


/**
 * @author whm
 * @date 2020/10/27 5:49 PM
 * @mail hongming.whm@alibaba-inc.com
 * @since
 */
public class AMapPlatformView
        implements
        DefaultLifecycleObserver,
        ActivityPluginBinding.OnSaveInstanceStateListener,
        MethodChannel.MethodCallHandler,
        PlatformView {
    private static final String CLASS_NAME = "AMapPlatformView";
    private final MethodChannel methodChannel;
    private final Map<String, MyMethodCallHandler> myMethodCallHandlerMap;

    private MapsInitializerController mapsInitializerController;
    private MapController mapController;
    private MarkersController markersController;
    private PolylinesController polylinesController;
    private PolygonsController polygonsController;
    private TextureMapView mapView;
    private boolean disposed = false;

    AMapPlatformView(int id,
                     Context context,
                     BinaryMessenger binaryMessenger,
                     LifecycleOwner lifecycleProvider,
                     AMapOptions options) {

        methodChannel = new MethodChannel(binaryMessenger, "amap_map_" + id);
        methodChannel.setMethodCallHandler(this);
        myMethodCallHandlerMap = new HashMap<>(8);

        try {
            mapView = new TextureMapView(context, options);
            AMap amap = mapView.getMap();
            mapsInitializerController = new MapsInitializerController(methodChannel);
            mapController = new MapController(methodChannel, mapView);
            markersController = new MarkersController(methodChannel, amap);
            polylinesController = new PolylinesController(methodChannel, amap);
            polygonsController = new PolygonsController(methodChannel, amap);
            initMyMethodCallHandlerMap();
            lifecycleProvider.getLifecycle().addObserver(this);
        } catch (Throwable e) {
            LogUtil.e(CLASS_NAME, "<init>", e);
        }
    }

    private void initMyMethodCallHandlerMap() {
        String[] methodIdArray = mapController.getRegisterMethodIdArray();
        if (null != methodIdArray) {
            for (String methodId : methodIdArray) {
                myMethodCallHandlerMap.put(methodId, mapController);
            }
        }

        methodIdArray = mapsInitializerController.getRegisterMethodIdArray();
        if (null != methodIdArray) {
            for (String methodId : methodIdArray) {
                myMethodCallHandlerMap.put(methodId, mapsInitializerController);
            }
        }

        methodIdArray = markersController.getRegisterMethodIdArray();
        if (null != methodIdArray) {
            for (String methodId : methodIdArray) {
                myMethodCallHandlerMap.put(methodId, markersController);
            }
        }

        methodIdArray = polylinesController.getRegisterMethodIdArray();
        if (null != methodIdArray) {
            for (String methodId : methodIdArray) {
                myMethodCallHandlerMap.put(methodId, polylinesController);
            }
        }

        methodIdArray = polygonsController.getRegisterMethodIdArray();
        if (null != methodIdArray) {
            for (String methodId : methodIdArray) {
                myMethodCallHandlerMap.put(methodId, polygonsController);
            }
        }
    }


    public MapController getMapController() {
        return mapController;
    }

    public MarkersController getMarkersController() {
        return markersController;
    }

    public PolylinesController getPolylinesController() {
        return polylinesController;
    }

    public PolygonsController getPolygonsController() {
        return polygonsController;
    }


    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        LogUtil.i(CLASS_NAME, "onMethodCall==>" + call.method + ", arguments==> " + call.arguments);
        String methodId = call.method;
        if (myMethodCallHandlerMap.containsKey(methodId)) {
            Objects.requireNonNull(myMethodCallHandlerMap.get(methodId)).doMethodCall(call, result);
        } else {
            LogUtil.w(CLASS_NAME, "onMethodCall, the methodId: " + call.method + ", not implemented");
            result.notImplemented();
        }
    }


    @Override
    public void onCreate(@NonNull LifecycleOwner owner) {
        LogUtil.i(CLASS_NAME, "onCreate==>");
        try {
            if (disposed) {
                return;
            }
            if (null != mapView) {
                mapView.onCreate(null);
            }
        } catch (Throwable e) {
            LogUtil.e(CLASS_NAME, "onCreate", e);
        }
    }

    @Override
    public void onStart(@NonNull LifecycleOwner owner) {
        LogUtil.i(CLASS_NAME, "onStart==>");
    }

    @Override
    public void onResume(@NonNull LifecycleOwner owner) {
        LogUtil.i(CLASS_NAME, "onResume==>");
        try {
            if (disposed) {
                return;
            }
            if (null != mapView) {
                mapView.onResume();
            }
        } catch (Throwable e) {
            LogUtil.e(CLASS_NAME, "onResume", e);
        }
    }

    @Override
    public void onPause(@NonNull LifecycleOwner owner) {
        LogUtil.i(CLASS_NAME, "onPause==>");
        try {
            if (disposed) {
                return;
            }
            mapView.onPause();
        } catch (Throwable e) {
            LogUtil.e(CLASS_NAME, "onPause", e);
        }
    }

    @Override
    public void onStop(@NonNull LifecycleOwner owner) {
        LogUtil.i(CLASS_NAME, "onStop==>");
    }

    @Override
    public void onDestroy(@NonNull LifecycleOwner owner) {
        LogUtil.i(CLASS_NAME, "onDestroy==>");
        try {
            if (disposed) {
                return;
            }
            destroyMapViewIfNecessary();
        } catch (Throwable e) {
            LogUtil.e(CLASS_NAME, "onDestroy", e);
        }
    }

    @Override
    public void onSaveInstanceState(@NonNull Bundle bundle) {
        LogUtil.i(CLASS_NAME, "onDestroy==>");
        try {
            if (disposed) {
                return;
            }
            mapView.onSaveInstanceState(bundle);
        } catch (Throwable e) {
            LogUtil.e(CLASS_NAME, "onSaveInstanceState", e);
        }
    }

    @Override
    public void onRestoreInstanceState(@Nullable Bundle bundle) {
        LogUtil.i(CLASS_NAME, "onDestroy==>");
        try {
            if (disposed) {
                return;
            }
            mapView.onCreate(bundle);
        } catch (Throwable e) {
            LogUtil.e(CLASS_NAME, "onRestoreInstanceState", e);
        }
    }


    @Override
    public View getView() {
        LogUtil.i(CLASS_NAME, "getView==>");
        return mapView;
    }

    @Override
    public void dispose() {
        LogUtil.i(CLASS_NAME, "dispose==>");
        try {
            if (disposed) {
                return;
            }
            methodChannel.setMethodCallHandler(null);
            destroyMapViewIfNecessary();
            disposed = true;
        } catch (Throwable e) {
            LogUtil.e(CLASS_NAME, "dispose", e);
        }
    }

    private void destroyMapViewIfNecessary() {
        if (mapView == null) {
            return;
        }
        mapView.onDestroy();
    }


}
