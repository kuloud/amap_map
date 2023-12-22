//
//  AMapPolygon.h
//  amap_map
//
//  Created by lly on 2020/11/12.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AMapPolygon : NSObject{
    /// 覆盖物的坐标点数组，key为@"points"
    CLLocationCoordinate2D *_coords;//坐标的数组指针
    NSUInteger _coordCount;//坐标的个数
}

@property (nonatomic, copy) NSString *id_;

/// 边框宽度
@property (nonatomic, assign) CGFloat strokeWidth;

/// 边框颜色
@property (nonatomic, strong) UIColor *strokeColor;

/// 填充颜色
@property (nonatomic, strong) UIColor *fillColor;

/// 是否可见
@property (nonatomic, assign) bool visible;

/// 连接点类型
@property (nonatomic, assign) MALineJoinType joinType;

/// 由以上数据生成的polyline对象
@property (nonatomic, strong,readonly) MAPolygon *polygon;

- (void)updatePolygon:(AMapPolygon *)polygon;

@end

NS_ASSUME_NONNULL_END
