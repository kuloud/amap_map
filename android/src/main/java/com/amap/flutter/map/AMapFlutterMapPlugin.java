package com.amap.flutter.map;

import android.app.Activity;

import androidx.annotation.NonNull;
import androidx.lifecycle.Lifecycle;
import androidx.lifecycle.LifecycleOwner;

import com.amap.flutter.map.utils.LogUtil;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.embedding.engine.plugins.lifecycle.FlutterLifecycleAdapter;
import io.flutter.plugin.common.PluginRegistry;

/**
 * AmapFlutterMapPlugin
 */
public class AMapFlutterMapPlugin implements
        FlutterPlugin,
        ActivityAware {
    private static final String CLASS_NAME = "AMapFlutterMapPlugin";
    private static final String VIEW_TYPE = "com.amap.flutter.map";
    private Lifecycle lifecycle;
    private FlutterPluginBinding pluginBinding;

    public AMapFlutterMapPlugin() {
    }

    // FlutterPlugin

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        LogUtil.i(CLASS_NAME, "onAttachedToEngine==>");
        this.pluginBinding = binding;
        binding
                .getPlatformViewRegistry()
                .registerViewFactory(
                        VIEW_TYPE,
                        new AMapPlatformViewFactory(
                                binding.getBinaryMessenger(),
                                () -> lifecycle));
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        LogUtil.i(CLASS_NAME, "onDetachedFromEngine==>");
    }


    // ActivityAware

    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        LogUtil.i(CLASS_NAME, "onAttachedToActivity==>");
        lifecycle = FlutterLifecycleAdapter.getActivityLifecycle(binding);
        pluginBinding.getPlatformViewRegistry().registerViewFactory(
                VIEW_TYPE,
                new AMapPlatformViewFactory(
                        pluginBinding.getBinaryMessenger(),
                        () -> lifecycle
                )
        );
    }

    @Override
    public void onDetachedFromActivity() {
        LogUtil.i(CLASS_NAME, "onDetachedFromActivity==>");
        lifecycle = null;
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        LogUtil.i(CLASS_NAME, "onReattachedToActivityForConfigChanges==>");
        onAttachedToActivity(binding);
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        LogUtil.i(CLASS_NAME, "onDetachedFromActivityForConfigChanges==>");
        this.onDetachedFromActivity();
    }
}
