//
//  AMapPolyline.h
//  amap_map
//
//  Created by lly on 2020/11/6.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AMapPolyline : NSObject {
    /// 覆盖物的坐标点数组，key为@"points"
    CLLocationCoordinate2D *_coords;//坐标的数组指针
    NSUInteger _coordCount;//坐标的个数
}

@property (nonatomic, copy) NSString *id_;

/// 线宽
@property (nonatomic, assign) CGFloat width;

/// 覆盖物颜色，默认值为(0xCCC4E0F0).
@property (nonatomic, strong) UIColor *color;

/// 是否可见
@property (nonatomic, assign) bool visible;

/// 透明度
@property (nonatomic, assign) CGFloat alpha;

/// 自定义纹理图片
@property (nonatomic, copy) NSArray *customTexture;

/// 由customTexture解析生成的图片
@property (nonatomic, strong) UIImage *strokeImage;

/// 是否为大地曲线
@property (nonatomic, assign) BOOL geodesic;

/// 虚线类型
@property (nonatomic, assign) MALineDashType dashLineType;

/// 连接点类型
@property (nonatomic, assign) MALineJoinType joinType;

/// 线头类型
@property (nonatomic, assign) MALineCapType capType;

/// 由以上数据生成的polyline对象
@property (nonatomic, strong, readonly) MAPolyline *polyline;

//更新polyline
- (void)updatePolyline:(AMapPolyline *)polyline;

@end

NS_ASSUME_NONNULL_END
