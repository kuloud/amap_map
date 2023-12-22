//
//  MAAnnotationView+Flutter.h
//  amap_map
//
//  Created by lly on 2020/11/5.
//

#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AMapMarker;

@interface MAAnnotationView (Flutter)

- (void)updateViewWithMarker:(AMapMarker *)marker;

@end

NS_ASSUME_NONNULL_END
