//
//  AMapMarker.h
//  amap_map
//
//  Created by lly on 2020/11/3.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AMapInfoWindow;

@interface AMapMarker : NSObject

@property (nonatomic, copy) NSString *id_;

@property (nonatomic, assign) double alpha;

@property (nonatomic, assign) CGPoint anchor;

//原始的图片BitmapDescriptor的json存储结构
@property (nonatomic, copy) NSArray *icon;

//解析后的图片
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, assign) bool clickable;

@property (nonatomic, assign) bool draggable;

@property (nonatomic, assign) bool flat;

@property (nonatomic, assign) bool infoWindowEnable;

@property (nonatomic, strong) AMapInfoWindow *infoWindow;

@property (nonatomic, assign) CLLocationCoordinate2D position;

@property (nonatomic, assign) double rotation;

@property (nonatomic, assign) bool visible;

@property (nonatomic, assign) double zIndex;

//根据以上marker信息生成的对应的iOS端的Annotation
@property (nonatomic, strong, readonly) MAPointAnnotation *annotation;


/// 更新marker的信息
/// @param changedMarker 带修改信息的marker
- (void)updateMarker:(AMapMarker *)changedMarker;

@end

NS_ASSUME_NONNULL_END
