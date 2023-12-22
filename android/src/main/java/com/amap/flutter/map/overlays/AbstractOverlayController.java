package com.amap.flutter.map.overlays;

import androidx.annotation.NonNull;

import com.amap.api.maps.AMap;
import com.amap.api.maps.TextureMapView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;

/**
 * @author whm
 * @date 2020/11/10 7:42 PM
 * @mail hongming.whm@alibaba-inc.com
 * @since
 */
public abstract class AbstractOverlayController<T> {
    protected final Map<String, T> controllerMapByDartId;
    protected final Map<String, String> idMapByOverlyId;
    protected final MethodChannel methodChannel;
    protected final AMap amap;
    public AbstractOverlayController(MethodChannel methodChannel, AMap amap){
        this.methodChannel = methodChannel;
        this.amap = amap;
        controllerMapByDartId = new HashMap<String, T>(12);
        idMapByOverlyId = new HashMap<String, String>(12);
    }
}
