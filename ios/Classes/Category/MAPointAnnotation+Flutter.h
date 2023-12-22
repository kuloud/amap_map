//
//  MAPointAnnotation+Flutter.h
//  amap_map
//
//  Created by lly on 2020/11/9.
//

#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN

/// AnnotationView的复用标识
extern NSString *const AMapFlutterAnnotationViewIdentifier;

/// 该拓展类型主要用于对地图原PointAnnotation添加一个唯一id,
/// 便于在地图回调代理中，通过id快速找到对应的AMapMarker对象，
/// 以此来构建对应的MAAnnotatioView
@interface MAPointAnnotation (Flutter)

//为Annotation拓展存储的flutter传入的markerId,便于快速查找对应的marker数据
@property (nullable,nonatomic,copy,readonly) NSString *markerId;

/// 使用MarkerId初始化对应的Annotation
/// @param markerId marker的唯一标识
- (instancetype)initWithMarkerId:(NSString *)markerId;

@end

NS_ASSUME_NONNULL_END
