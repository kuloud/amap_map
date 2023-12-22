//
//  MAPolylineRenderer+Flutter.h
//  amap_map
//
//  Created by lly on 2020/11/7.
//

#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AMapPolyline;

@interface MAPolylineRenderer (Flutter)

- (void)updateRenderWithPolyline:(AMapPolyline *)polyline;

@end

NS_ASSUME_NONNULL_END
