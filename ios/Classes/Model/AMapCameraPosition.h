#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class AMapCameraPosition;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface AMapCameraPosition : NSObject

/// 可视区域指向的方向，以角度为单位，从正北向逆时针方向计算，从0 度到360 度。
@property (nonatomic, assign) CGFloat bearing;

/// 目标位置的屏幕中心点经纬度坐标。
@property (nonatomic, assign) CLLocationCoordinate2D target;

/// 目标可视区域的倾斜度，以角度为单位。
@property (nonatomic, assign) CGFloat tilt;

/// 目标可视区域的缩放级别
@property (nonatomic, assign) CGFloat zoom;

- (NSDictionary *)toDictionary;

@end

NS_ASSUME_NONNULL_END
