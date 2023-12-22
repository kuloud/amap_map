//
//  MAPolylineRenderer+Flutter.m
//  amap_map
//
//  Created by lly on 2020/11/7.
//

#import "MAPolylineRenderer+Flutter.h"
#import "AMapPolyline.h"

@implementation MAPolylineRenderer (Flutter)

- (void)updateRenderWithPolyline:(AMapPolyline *)polyline {
    self.lineWidth = polyline.width;
    self.strokeColor  = polyline.color;
    if (polyline.visible) {//可见时，才设置透明度
        self.alpha = polyline.alpha;
    } else {
        self.alpha = 0;
    }
    if (polyline.strokeImage) {
        self.strokeImage = polyline.strokeImage;
    }
    self.lineDashType = polyline.dashLineType;
    self.lineJoinType = polyline.joinType;
    self.lineCapType = polyline.capType;
    self.userInteractionEnabled = YES;//默认可点击
}

@end
