package com.amap.flutter.map.overlays.polyline;

import com.amap.api.maps.model.BitmapDescriptor;
import com.amap.api.maps.model.LatLng;
import com.amap.api.maps.model.Polyline;
import com.amap.api.maps.model.PolylineOptions;

import java.util.List;

/**
 * @author whm
 * @date 2020/11/10 2:58 PM
 * @mail hongming.whm@alibaba-inc.com
 * @since
 */
class PolylineController implements PolylineOptionsSink {
    final Polyline polyline;
    final String polylineId;
    PolylineController(Polyline polyline) {
        this.polyline = polyline;
        this.polylineId = polyline.getId();
    }

    public String getPolylineId() {
        return polylineId;
    }

    public void remove() {
        if(null != polyline) {
            polyline.remove();
        }
    }
    @Override
    public void setPoints(List<LatLng> points) {
        polyline.setPoints(points);
    }

    @Override
    public void setWidth(float width) {
        polyline.setWidth(width);
    }

    @Override
    public void setColor(int color) {
        polyline.setColor(color);
    }

    @Override
    public void setVisible(boolean visible) {
        polyline.setVisible(visible);
    }

    @Override
    public void setCustomTexture(BitmapDescriptor customTexture) {
        polyline.setCustomTexture(customTexture);
    }

    @Override
    public void setCustomTextureList(List<BitmapDescriptor> customTextureList) {
        polyline.setCustomTextureList(customTextureList);
    }

    @Override
    public void setColorList(List<Integer> colorList) {
        PolylineOptions options = polyline.getOptions();
        options.colorValues(colorList);
        polyline.setOptions(options);

    }

    @Override
    public void setCustomIndexList(List<Integer> customIndexList) {
        PolylineOptions options = polyline.getOptions();
        options.setCustomTextureIndex(customIndexList);
        polyline.setOptions(options);
    }

    @Override
    public void setGeodesic(boolean geodesic) {
        polyline.setGeodesic(geodesic);
    }

    @Override
    public void setGradient(boolean gradient) {
        polyline.setGeodesic(gradient);
    }

    @Override
    public void setAlpha(float alpha) {
        polyline.setTransparency(alpha);
    }

    @Override
    public void setDashLineType(int type) {
        PolylineOptions options = polyline.getOptions();
        options.setDottedLineType(type);
        polyline.setOptions(options);
    }

    @Override
    public void setDashLine(boolean dashLine) {
        polyline.setDottedLine(dashLine);

    }

    @Override
    public void setLineCapType(PolylineOptions.LineCapType lineCapType) {
        PolylineOptions options = polyline.getOptions();
        options.lineCapType(lineCapType);
        polyline.setOptions(options);
    }


    @Override
    public void setLineJoinType(PolylineOptions.LineJoinType joinType) {
        PolylineOptions options = polyline.getOptions();
        options.lineJoinType(joinType);
        polyline.setOptions(options);
    }
}
