//
//  MAPolygonRenderer+Flutter.h
//  amap_map
//
//  Created by lly on 2020/11/12.
//

#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AMapPolygon;

@interface MAPolygonRenderer (Flutter)

- (void)updateRenderWithPolygon:(AMapPolygon *)polygon;

@end

NS_ASSUME_NONNULL_END
