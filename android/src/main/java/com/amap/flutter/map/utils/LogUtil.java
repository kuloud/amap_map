package com.amap.flutter.map.utils;

import android.util.Log;


/**
 * @author whm
 * @date 2020/11/6 11:04 AM
 * @mail hongming.whm@alibaba-inc.com
 * @since
 */
public class LogUtil {
    public static boolean isDebugMode = false;
    private static final String TAG = "AMapFlutter_";
    public static void i(String className, String message) {
        if(isDebugMode) {
            Log.i(TAG+className, message);
        }
    }
    public static void d(String className, String message) {
        if(isDebugMode) {
            Log.d(TAG+className, message);
        }
    }

    public static void w(String className, String message) {
        if(isDebugMode) {
            Log.w(TAG+className, message);
        }
    }


    public static void e(String className, String methodName, Throwable e) {
        if (isDebugMode) {
            Log.e(TAG+className, methodName + " exception!!", e);
        }
    }

}
