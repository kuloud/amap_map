//
//  MAAnnotationView+Flutter.m
//  amap_map
//
//  Created by lly on 2020/11/5.
//

#import "MAAnnotationView+Flutter.h"
#import "AMapMarker.h"
#import "AMapInfoWindow.h"

@implementation MAAnnotationView (Flutter)

- (void)updateViewWithMarker:(AMapMarker *)marker {
    if (marker == nil) {
        return;
    }
    self.alpha = marker.alpha;
    self.image = marker.image;
    //anchor变换成地图centerOffset
    if (self.image) {
        CGSize imageSize = self.image.size;
        //iOS的annotationView的中心默认位于annotation的坐标位置,对应的锚点为（0.5，0.5）
        CGFloat offsetW = imageSize.width * (0.5 - marker.anchor.x);
        CGFloat offsetH = imageSize.height * (0.5 - marker.anchor.y);
        self.centerOffset = CGPointMake(offsetW, offsetH);
    }
    self.enabled = marker.clickable;
    self.draggable = marker.draggable;
    //    marker.flat;//flat属性，iOS暂时不开
    self.canShowCallout = marker.infoWindowEnable;
//    TODO: 气泡的锚点，由于iOS中的气泡，区分默认气泡和自定义气泡，且无法获得气泡的大小，所以没法将其锚点转换为calloutOffset
    //    self.calloutOffset = marker.infoWindow.anchor;
    //角度旋转
    self.imageView.transform = CGAffineTransformMakeRotation(marker.rotation / 180.f * M_PI);
    self.hidden = (!marker.visible);
    self.zIndex = marker.zIndex;
}

@end
