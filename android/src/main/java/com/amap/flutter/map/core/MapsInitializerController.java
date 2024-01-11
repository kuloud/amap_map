package com.amap.flutter.map.core;

import androidx.annotation.NonNull;

import com.amap.api.maps.MapsInitializer;
import com.amap.flutter.map.MyMethodCallHandler;
import com.amap.flutter.map.utils.Const;
import com.amap.flutter.map.utils.LogUtil;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * AMap 全局控制器
 */
public class MapsInitializerController implements MyMethodCallHandler {
    private static final String CLASS_NAME = MapsInitializerController.class.getSimpleName();
    private final MethodChannel methodChannel;

    public MapsInitializerController(MethodChannel methodChannel) {
        this.methodChannel = methodChannel;
    }

    @Override
    public void doMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case Const.METHOD_SET_TERRAIN_ENABLE:
                MapsInitializer.setTerrainEnable(call.argument(""));
                result.success(null);
                break;
            default:
                LogUtil.w(CLASS_NAME, "onMethodCall not find methodId:" + call.method);
                break;
        }
    }

    @Override
    public String[] getRegisterMethodIdArray() {
        return new String[0];
    }
}
