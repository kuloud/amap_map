//
//  AMapLocation.h
//  amap_map
//
//  Created by lly on 2020/11/12.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@class MAUserLocation;

@interface AMapLocation : NSObject

///定位提供者
///
///iOS平台只会返回'iOS'
@property (nonatomic, copy) NSString *provider;

///经纬度
@property (nonatomic, assign) CLLocationCoordinate2D latLng;

///水平精确度
@property (nonatomic, assign) double accuracy;

///海拔
@property (nonatomic, assign) double altitude;

///角度
@property (nonatomic, assign) double bearing;

///速度
@property (nonatomic, assign) double speed;

///定位时间，单位：毫秒
@property (nonatomic, assign) double time;

- (void)updateWithUserLocation:(CLLocation *)location;

@end

NS_ASSUME_NONNULL_END
