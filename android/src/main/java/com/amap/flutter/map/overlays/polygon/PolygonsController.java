package com.amap.flutter.map.overlays.polygon;

import android.text.TextUtils;

import androidx.annotation.NonNull;

import com.amap.api.maps.AMap;
import com.amap.api.maps.model.Polygon;
import com.amap.api.maps.model.PolygonOptions;
import com.amap.flutter.map.MyMethodCallHandler;
import com.amap.flutter.map.overlays.AbstractOverlayController;
import com.amap.flutter.map.utils.Const;
import com.amap.flutter.map.utils.ConvertUtil;
import com.amap.flutter.map.utils.LogUtil;

import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * @author whm
 * @date 2020/11/12 9:53 AM
 * @mail hongming.whm@alibaba-inc.com
 * @since
 */
public class PolygonsController
        extends AbstractOverlayController<PolygonController>
        implements MyMethodCallHandler {

    private static final String CLASS_NAME = "PolygonsController";

    public PolygonsController(MethodChannel methodChannel, AMap amap) {
        super(methodChannel, amap);
    }

    @Override
    public void doMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        String methodId = call.method;
        LogUtil.i(CLASS_NAME, "doMethodCall===>" +methodId);
        switch (methodId) {
            case Const.METHOD_POLYGON_UPDATE:
                invokePolylineOptions(call, result);
                break;
        }
    }

    @Override
    public String[] getRegisterMethodIdArray() {
        return Const.METHOD_ID_LIST_FOR_POLYGON;
    }

    /**
     *
     * @param methodCall
     * @param result
     */
    public void invokePolylineOptions(MethodCall methodCall, MethodChannel.Result result) {
        if (null == methodCall) {
            return;
        }
        Object listToAdd = methodCall.argument("polygonsToAdd");
        addByList((List<Object>) listToAdd);
        Object listToChange = methodCall.argument("polygonsToChange");
        updateByList((List<Object>) listToChange);
        Object listIdToRemove = methodCall.argument("polygonIdsToRemove");
        removeByIdList((List<Object>) listIdToRemove);
        result.success(null);
    }

    public void addByList(List<Object> polygonsToAdd) {
        if (polygonsToAdd != null) {
            for (Object polygonToAdd : polygonsToAdd) {
                add(polygonToAdd);
            }
        }
    }

    private void add(Object polylineObj) {
        if (null != amap) {
            PolygonOptionsBuilder builder = new PolygonOptionsBuilder();
            String dartId = PolygonUtil.interpretOptions(polylineObj, builder);
            if (!TextUtils.isEmpty(dartId)) {
                PolygonOptions options = builder.build();
                final Polygon polygon = amap.addPolygon(options);
                PolygonController polygonController = new PolygonController(polygon);
                controllerMapByDartId.put(dartId, polygonController);
                idMapByOverlyId.put(polygon.getId(), dartId);
            }
        }

    }

    private void updateByList(List<Object> overlaysToChange) {
        if (overlaysToChange != null) {
            for (Object overlayToChange : overlaysToChange) {
                update(overlayToChange);
            }
        }
    }

    private void update(Object toUpdate) {
        Object dartId = ConvertUtil.getKeyValueFromMapObject(toUpdate, "id");
        if (null != dartId) {
            PolygonController controller = controllerMapByDartId.get(dartId);
            if (null != controller) {
                PolygonUtil.interpretOptions(toUpdate, controller);
            }
        }
    }

    private void removeByIdList(List<Object> toRemoveIdList) {
        if (toRemoveIdList == null) {
            return;
        }
        for (Object toRemoveId : toRemoveIdList) {
            if (toRemoveId == null) {
                continue;
            }
            String dartId = (String) toRemoveId;
            final PolygonController controller = controllerMapByDartId.remove(dartId);
            if (controller != null) {

                idMapByOverlyId.remove(controller.getId());
                controller.remove();
            }
        }
    }
}
