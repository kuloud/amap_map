//
//  MAPolygonRenderer+Flutter.m
//  amap_map
//
//  Created by lly on 2020/11/12.
//

#import "MAPolygonRenderer+Flutter.h"
#import "AMapPolygon.h"

@implementation MAPolygonRenderer (Flutter)

- (void)updateRenderWithPolygon:(AMapPolygon *)polygon {
    self.lineWidth = polygon.strokeWidth;
    self.strokeColor  = polygon.strokeColor;
    self.fillColor = polygon.fillColor;
    self.lineJoinType = polygon.joinType;
    if (polygon.visible) {
        self.alpha = 1.0;
    } else {
        self.alpha = 0;
    }
}


@end
