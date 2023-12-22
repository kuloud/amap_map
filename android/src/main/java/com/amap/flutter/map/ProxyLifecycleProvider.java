package com.amap.flutter.map;

import android.app.Activity;
import android.app.Application;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.lifecycle.Lifecycle;
import androidx.lifecycle.LifecycleOwner;
import androidx.lifecycle.LifecycleRegistry;

import com.amap.flutter.map.utils.LogUtil;

/**
 * This class provides a {@link LifecycleOwner} for the activity driven by {@link
 * Application.ActivityLifecycleCallbacks}.
 *
 * <p>This is used in the case where a direct Lifecycle/Owner is not available.
 */
public class ProxyLifecycleProvider
        implements
        Application.ActivityLifecycleCallbacks,
        LifecycleOwner,
        LifecycleProvider {
    private static final String CLASS_NAME = "ProxyLifecycleProvider";
    private final LifecycleRegistry lifecycle = new LifecycleRegistry(this);
    private final int registrarActivityHashCode;

    public ProxyLifecycleProvider(Activity activity) {
        this.registrarActivityHashCode = activity.hashCode();
        activity.getApplication().registerActivityLifecycleCallbacks(this);
        LogUtil.i(CLASS_NAME, "<init>");
    }

    @Override
    public void onActivityCreated(Activity activity, Bundle savedInstanceState) {
        if (activity.hashCode() != registrarActivityHashCode) {
            return;
        }
        lifecycle.handleLifecycleEvent(Lifecycle.Event.ON_CREATE);
        LogUtil.i(CLASS_NAME, "onActivityCreated==>");
    }

    @Override
    public void onActivityStarted(Activity activity) {
        if (activity.hashCode() != registrarActivityHashCode) {
            return;
        }
        lifecycle.handleLifecycleEvent(Lifecycle.Event.ON_START);
        LogUtil.i(CLASS_NAME, "onActivityStarted==>");
    }

    @Override
    public void onActivityResumed(Activity activity) {
        if (activity.hashCode() != registrarActivityHashCode) {
            return;
        }
        lifecycle.handleLifecycleEvent(Lifecycle.Event.ON_RESUME);
        LogUtil.i(CLASS_NAME, "onActivityResumed==>");
    }

    @Override
    public void onActivityPaused(Activity activity) {
        if (activity.hashCode() != registrarActivityHashCode) {
            return;
        }
        lifecycle.handleLifecycleEvent(Lifecycle.Event.ON_PAUSE);
        LogUtil.i(CLASS_NAME, "onActivityPaused==>");
    }

    @Override
    public void onActivityStopped(Activity activity) {
        if (activity.hashCode() != registrarActivityHashCode) {
            return;
        }
        lifecycle.handleLifecycleEvent(Lifecycle.Event.ON_STOP);
        LogUtil.i(CLASS_NAME, "onActivityStopped==>");
    }

    @Override
    public void onActivitySaveInstanceState(Activity activity, Bundle outState) {
    }

    @Override
    public void onActivityDestroyed(Activity activity) {
        if (activity.hashCode() != registrarActivityHashCode) {
            return;
        }
        activity.getApplication().unregisterActivityLifecycleCallbacks(this);
        lifecycle.handleLifecycleEvent(Lifecycle.Event.ON_DESTROY);
        LogUtil.i(CLASS_NAME, "onActivityDestroyed==>");
    }

    @NonNull
    @Override
    public Lifecycle getLifecycle() {
        return lifecycle;
    }
}