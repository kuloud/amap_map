//
//  MAPolygon+Flutter.h
//  amap_map
//
//  Created by lly on 2020/11/12.
//

#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 该拓展类型主要用于对地图原MAPolygon添加一个唯一id,
/// 便于在地图回调代理中，通过id快速找到对应的AMapPolyline对象，
/// 以此来构建对应的polygonRender

@interface MAPolygon (Flutter)

@property (nonatomic,copy,readonly) NSString *polygonId;

/// 使用polygonId初始化对应的MAPolygon
/// @param polygonId polylgon的唯一标识
- (instancetype)initWithPolygonId:(NSString *)polygonId;

@end

NS_ASSUME_NONNULL_END
