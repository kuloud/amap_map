package com.amap.flutter.map;

import androidx.annotation.NonNull;

import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * @author whm
 * @date 2020/11/10 9:47 PM
 * @mail hongming.whm@alibaba-inc.com
 * @since
 */
public interface MyMethodCallHandler {

    public void doMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result);
    /**
     * 获取注册的{@link io.flutter.plugin.common.MethodCall#method}
     * @return
     */
    public abstract String[] getRegisterMethodIdArray();
}
