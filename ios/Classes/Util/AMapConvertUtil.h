//
//  AMapConvertUtil.h
//  amap_map
//
//  Created by lly on 2020/10/30.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <Flutter/Flutter.h>
#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MATouchPoi;

@interface AMapConvertUtil : NSObject

/// 经纬度坐标转字符串
/// @param coordinate 经纬度坐标
+ (NSString *)stringFromCoordinate:(CLLocationCoordinate2D)coordinate;

/// 颜色的色值解析（色值必须为json中的number类型）
/// @param numberColor 色值
+ (UIColor*)colorFromNumber:(NSNumber*)numberColor;

/// 从数据中解析经纬度
/// @param array 经纬度数组对（默认第一个当做维度，第二个当做经度）
+ (CLLocationCoordinate2D)coordinateFromArray:(NSArray *)array;

/// 经纬度转json数组
/// @param coord 经纬度
+ (NSArray *)jsonFromCoordinate:(CLLocationCoordinate2D )coord;

/// 经纬度转json数组
/// @param coordinate 经纬度
+ (NSArray<NSNumber *> *)jsonArrayFromCoordinate:(CLLocationCoordinate2D)coordinate;

+ (UIImage*)imageFromRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar iconData:(NSArray*)iconData;


/// 检测图标相关的描述，是否修改过
/// @param previousIcon 之前的图标
/// @param currentIcon 当前新的图标
/// @return 修改了，则返回yes，否则返回NO
+ (BOOL)checkIconDescriptionChangedFrom:(NSArray *)previousIcon to:(NSArray *)currentIcon;


/// 经纬度坐标比较
/// @param coord1 坐标1
/// @param coord2 坐标2
+ (BOOL)isEqualWith:(CLLocationCoordinate2D)coord1 to:(CLLocationCoordinate2D)coord2;

/// TouchPOI转字典
/// @param poi 点击POI
+ (NSDictionary *)dictFromTouchPOI:(MATouchPoi *)poi;

/// 解析得到mapRect结构
/// @param array json数组[southwest,northeast]，分别为西南、东北的坐标
+ (MAMapRect)mapRectFromArray:(NSArray *)array;

+ (CGPoint)pointFromDictionary:(NSDictionary *)dictionary;
+ (CGPoint)pointFromArray:(NSArray *)array;
+ (NSDictionary<NSString *, NSNumber *> *)dictionaryFromPoint:(CGPoint)point;
+ (NSArray *)arrayFromLocation:(CLLocationCoordinate2D)location;




@end

NS_ASSUME_NONNULL_END
