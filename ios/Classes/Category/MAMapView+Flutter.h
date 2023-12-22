//
//  MAMapView+Flutter.h
//  amap_map
//
//  Created by lly on 2020/10/30.
//

#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AMapCameraPosition;
@class AMapOption;
@protocol FlutterPluginRegistrar;

@interface MAMapView (Flutter)

- (void)setCameraPosition:(AMapCameraPosition *)cameraPosition animated:(BOOL)animated duration:(CFTimeInterval)duration;

/// 获取地图的当前cameraPostion
- (AMapCameraPosition *)getCurrentCameraPosition;

/// 地图camera更新操作
- (void)setCameraUpdateDict:(NSDictionary *)updateDict;

- (void)updateMapViewOption:(NSDictionary *)dict withRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar;

@end

NS_ASSUME_NONNULL_END
