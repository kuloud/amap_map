package com.amap.flutter.map.overlays.polyline;

import android.text.TextUtils;

import androidx.annotation.NonNull;

import com.amap.api.maps.AMap;
import com.amap.api.maps.TextureMapView;
import com.amap.api.maps.model.Polyline;
import com.amap.api.maps.model.PolylineOptions;
import com.amap.flutter.map.MyMethodCallHandler;
import com.amap.flutter.map.overlays.AbstractOverlayController;
import com.amap.flutter.map.utils.Const;
import com.amap.flutter.map.utils.ConvertUtil;
import com.amap.flutter.map.utils.LogUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * @author whm
 * @date 2020/11/10 2:58 PM
 * @mail hongming.whm@alibaba-inc.com
 * @since
 */
public class PolylinesController
        extends AbstractOverlayController<PolylineController>
        implements MyMethodCallHandler,
        AMap.OnPolylineClickListener {

    private static final String CLASS_NAME = "PolylinesController";

    public PolylinesController(MethodChannel methodChannel, AMap amap) {
        super(methodChannel, amap);
        amap.addOnPolylineClickListener(this);
    }

    @Override
    public String[] getRegisterMethodIdArray() {
        return Const.METHOD_ID_LIST_FOR_POLYLINE;
    }

    @Override
    public void doMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        LogUtil.i(CLASS_NAME, "doMethodCall===>" + call.method);
        String methodStr = call.method;
        switch (methodStr) {
            case Const.METHOD_POLYLINE_UPDATE:
                invokePolylineOptions(call, result);
                break;
        }
    }

    @Override
    public void onPolylineClick(Polyline polyline) {
        String dartId = idMapByOverlyId.get(polyline.getId());
        if (null == dartId) {
            return;
        }
        final Map<String, Object> data = new HashMap<>(1);
        data.put("polylineId", dartId);
        methodChannel.invokeMethod("polyline#onTap", data);
        LogUtil.i(CLASS_NAME, "onPolylineClick==>" + data);
    }

    /**
     *
     * @param methodCall
     * @param result
     */
    private void invokePolylineOptions(MethodCall methodCall, MethodChannel.Result result) {
        if (null == methodCall) {
            return;
        }
        Object listToAdd = methodCall.argument("polylinesToAdd");
        addByList((List<Object>) listToAdd);
        Object listToChange = methodCall.argument("polylinesToChange");
        updateByList((List<Object>) listToChange);
        Object polylineIdsToRemove = methodCall.argument("polylineIdsToRemove");
        removeByIdList((List<Object>) polylineIdsToRemove);
        result.success(null);
    }

    public void addByList(List<Object> polylinesToAdd) {
        if (polylinesToAdd != null) {
            for (Object markerToAdd : polylinesToAdd) {
                addPolyline(markerToAdd);
            }
        }
    }

    private void addPolyline(Object polylineObj) {
        if (null != amap) {
            PolylineOptionsBuilder builder = new PolylineOptionsBuilder();
            String dartId = PolylineUtil.interpretOptions(polylineObj, builder);
            if (!TextUtils.isEmpty(dartId)) {
                PolylineOptions polylineOptions = builder.build();
                final Polyline polyline = amap.addPolyline(polylineOptions);
                PolylineController polylineController = new PolylineController(polyline);
                controllerMapByDartId.put(dartId, polylineController);
                idMapByOverlyId.put(polyline.getId(), dartId);
            }
        }

    }

    private void updateByList(List<Object> polylineToChange) {
        if (polylineToChange != null) {
            for (Object markerToChange : polylineToChange) {
                update(markerToChange);
            }
        }
    }

    private void update(Object polylineToChange) {
        Object polylineId = ConvertUtil.getKeyValueFromMapObject(polylineToChange, "id");
        if (null != polylineId) {
            PolylineController polylineController = controllerMapByDartId.get(polylineId);
            if (null != polylineController) {
                PolylineUtil.interpretOptions(polylineToChange, polylineController);
            }
        }
    }


    private void removeByIdList(List<Object> polylineIdsToRemove) {
        if (polylineIdsToRemove == null) {
            return;
        }
        for (Object rawPolylineId : polylineIdsToRemove) {
            if (rawPolylineId == null) {
                continue;
            }
            String markerId = (String) rawPolylineId;
            final PolylineController polylineController = controllerMapByDartId.remove(markerId);
            if (polylineController != null) {
                idMapByOverlyId.remove(polylineController.getPolylineId());
                polylineController.remove();
            }
        }
    }



}
