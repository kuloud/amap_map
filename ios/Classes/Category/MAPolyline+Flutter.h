//
//  MAPolyline+Flutter.h
//  amap_map
//
//  Created by lly on 2020/11/9.
//

#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 该拓展类型主要用于对地图原MAPolyline添加一个唯一id,
/// 便于在地图回调代理中，通过id快速找到对应的AMapPolyline对象，
/// 以此来构建对应的polylineRender

@interface MAPolyline (Flutter)

@property (nonatomic,copy,readonly) NSString *polylineId;

/// 使用polylineId初始化对应的MAPolyline
/// @param polylineId polyline的唯一标识
- (instancetype)initWithPolylineId:(NSString *)polylineId;

@end

NS_ASSUME_NONNULL_END
