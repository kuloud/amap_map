//
//  AMapConvertUtil.m
//  amap_map
//
//  Created by lly on 2020/10/30.
//

#import "AMapConvertUtil.h"

@implementation AMapConvertUtil


/// 经纬度坐标转字符串
/// @param coordinate 经纬度坐标
+ (NSString *)stringFromCoordinate:(CLLocationCoordinate2D)coordinate {
    return [NSString stringWithFormat:@"{%.6f,%.6f}", coordinate.longitude, coordinate.latitude];
}

+ (UIColor*)colorFromNumber:(NSNumber*)numberColor {
    if (numberColor == nil || [numberColor isKindOfClass:[NSNumber class]] == NO) {
        return nil;
    }
    unsigned long value = [numberColor unsignedLongValue];
    return [UIColor colorWithRed:((float)((value & 0xFF0000) >> 16)) / 255.0
                           green:((float)((value & 0xFF00) >> 8)) / 255.0
                            blue:((float)(value & 0xFF)) / 255.0
                           alpha:((float)((value & 0xFF000000) >> 24)) / 255.0];
}


/// 从数据中解析经纬度
/// @param array 经纬度数组对（默认第一个当做维度，第二个当做经度）
+ (CLLocationCoordinate2D)coordinateFromArray:(NSArray *)array {
    CLLocationCoordinate2D location = kCLLocationCoordinate2DInvalid;
    if (array.count == 2) {
        double latitude = [array[0] doubleValue];
        double longitude = [array[1] doubleValue];
        if ([self checkValidLatitude:latitude longitude:longitude]) {
            location = CLLocationCoordinate2DMake(latitude, longitude);
        } else if ([self checkValidLatitude:longitude longitude:latitude]) {//交换二者
            location = CLLocationCoordinate2DMake(longitude, latitude);
        } else {
            NSLog(@"经纬度参数异常，解析为无效经纬度");
        }
    } else {
        NSLog(@"经纬度参数异常，解析为无效经纬度");
    }
    return location;
}

+ (NSArray *)jsonFromCoordinate:(CLLocationCoordinate2D )coord {
    if (CLLocationCoordinate2DIsValid(coord)) {
        return @[@(coord.latitude),@(coord.longitude)];
    } else {
        NSLog(@"经纬度无效，返回为空");
        return @[];
    }
}

/// 检测经纬度是否有效
/// @param latitude 维度
/// @param longitude 经度
+ (BOOL)checkValidLatitude:(double)latitude longitude:(double)longitude {
    if (latitude > 90 || latitude < -90) {
        return false;
    }
    if (longitude > 180 || longitude < -180) {
        return  false;
    }
    return true;
}

+ (NSArray<NSNumber *> *)jsonArrayFromCoordinate:(CLLocationCoordinate2D)coordinate {
    if (CLLocationCoordinate2DIsValid(coordinate)) {
        return @[ @(coordinate.latitude), @(coordinate.longitude) ];
    } else {
        return @[];
    }
}


+ (UIImage*)scaleImage:(UIImage*)image param:(NSNumber*)scaleParam {
  double scale = 1.0;
  if ([scaleParam isKindOfClass:[NSNumber class]]) {
    scale = scaleParam.doubleValue;
  }
  if (fabs(scale - 1) > 1e-3) {
    return [UIImage imageWithCGImage:[image CGImage]
                               scale:(image.scale * scale)
                         orientation:(image.imageOrientation)];
  }
  return image;
}


+ (UIImage*)imageFromRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar iconData:(NSArray*)iconData {
    UIImage* image;
    if ([iconData.firstObject isEqualToString:@"defaultMarker"]) {
        image = [UIImage imageNamed:[registrar lookupKeyForAsset:@"packages/amap_map/res/marker_default.png"]];//默认的图片资源
        CGFloat screenScale = [[UIScreen mainScreen] scale];
        image = [self scaleImage:image param:[NSNumber numberWithFloat:screenScale]];
        //添加默认图片
    } else if ([iconData.firstObject isEqualToString:@"fromAsset"]) {
        if (iconData.count == 2) {
            image = [UIImage imageNamed:[registrar lookupKeyForAsset:iconData[1]]];
            CGFloat screenScale = [[UIScreen mainScreen] scale];
            image = [self scaleImage:image param:[NSNumber numberWithFloat:screenScale]];
        }
    } else if ([iconData.firstObject isEqualToString:@"fromAssetImage"]) {
        if (iconData.count == 3) {
            image = [UIImage imageNamed:[registrar lookupKeyForAsset:iconData[1]]];
            NSNumber* scaleParam = iconData[2];
            image = [self scaleImage:image param:scaleParam];
        } else {
            NSString* error =
            [NSString stringWithFormat:@"'fromAssetImage' should have exactly 3 arguments. Got: %lu",
             (unsigned long)iconData.count];
            NSException* exception = [NSException exceptionWithName:@"InvalidBitmapDescriptor"
                                                             reason:error
                                                           userInfo:nil];
            @throw exception;
        }
    } else if ([iconData[0] isEqualToString:@"fromBytes"]) {
        if (iconData.count == 2) {
            @try {
                FlutterStandardTypedData* byteData = iconData[1];
                CGFloat screenScale = [[UIScreen mainScreen] scale];
                image = [UIImage imageWithData:[byteData data] scale:screenScale];
            } @catch (NSException* exception) {
                @throw [NSException exceptionWithName:@"InvalidByteDescriptor"
                                               reason:@"Unable to interpret bytes as a valid image."
                                             userInfo:nil];
            }
        } else {
            NSString* error = [NSString
                               stringWithFormat:@"fromBytes should have exactly one argument, the bytes. Got: %lu",
                               (unsigned long)iconData.count];
            NSException* exception = [NSException exceptionWithName:@"InvalidByteDescriptor"
                                                             reason:error
                                                           userInfo:nil];
            @throw exception;
        }
    }
    
    return image;
}

/// 检测图标相关的描述，是否修改过
/// @param previousIcon 之前的图标
/// @param currentIcon 当前新的图标
/// @return 修改了，则返回yes，否则返回NO
+ (BOOL)checkIconDescriptionChangedFrom:(NSArray *)previousIcon to:(NSArray *)currentIcon {
    if (previousIcon.count != currentIcon.count) {
        return YES;
    }
    //两个数组的数量一样
    for (NSUInteger index = 0; index < previousIcon.count; index ++) {
        if ([previousIcon[index] isKindOfClass:[NSString class]]) {
            if ([previousIcon[index] isEqualToString:currentIcon[index]] == NO) {
                return YES;
            }
        } else if ([previousIcon[index] isKindOfClass:[NSNumber class]]) {
            if (fabs([previousIcon[index] doubleValue] - [currentIcon[index] doubleValue]) > 0.000001) {
                return YES;
            }
        } else {//其它数据无法比较，直接默认强制更新
            return NO;
        }
    }
    return NO;
}

+ (BOOL)isEqualWith:(CLLocationCoordinate2D)coord1 to:(CLLocationCoordinate2D)coord2 {
    if (fabs(coord1.latitude - coord2.latitude) > 0.000001 || fabs(coord1.longitude - coord2.longitude) > 0.000001) {
        return NO;
    }
    return YES;
}

+ (NSDictionary *)dictFromTouchPOI:(MATouchPoi *)poi {
    if (poi == nil) {
        return nil;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:3];
    if (poi.name) {
        [dict setObject:poi.name forKey:@"name"];
    }
    if (CLLocationCoordinate2DIsValid(poi.coordinate)) {
        [dict setObject:[AMapConvertUtil jsonArrayFromCoordinate:poi.coordinate] forKey:@"latLng"];
    }
    if (poi.uid) {
        [dict setObject:poi.uid forKey:@"id"];
    }
    return [dict copy];
}

+ (MAMapRect)mapRectFromArray:(NSArray *)array {
    NSAssert((array && [array isKindOfClass:[NSArray class]] && array.count == 2), @"解析mapRect的参数有误");
    CLLocationCoordinate2D southwest = [AMapConvertUtil coordinateFromArray:array[0]];
    CLLocationCoordinate2D northeast = [AMapConvertUtil coordinateFromArray:array[1]];
    MAMapPoint mapNorthEastPoint = MAMapPointForCoordinate(northeast);
    MAMapPoint mapSouthWestPoint = MAMapPointForCoordinate(southwest);
    double width  = fabs(mapNorthEastPoint.x - mapSouthWestPoint.x);
    double height = fabs(mapNorthEastPoint.y - mapSouthWestPoint.y);
    MAMapRect limitRect = MAMapRectMake(mapSouthWestPoint.x, mapNorthEastPoint.y, width, height);
    return limitRect;
}


+ (CGPoint)pointFromDictionary:(NSDictionary *)dictionary {
  double x = [dictionary[@"x"] doubleValue];
  double y = [dictionary[@"y"] doubleValue];
  return CGPointMake(x, y);
}

+ (CGPoint)pointFromArray:(NSArray*)array {
    NSAssert((array != nil && [array isKindOfClass:[NSArray class]] && array.count == 2), @"数组类型转point格式错误");
    return CGPointMake([array[0] doubleValue],
                       [array[1] doubleValue]);
}

+ (NSDictionary<NSString *, NSNumber *> *)dictionaryFromPoint:(CGPoint)point {
  return @{
    @"x" : @(lroundf(point.x)),
    @"y" : @(lroundf(point.y)),
  };
}

+ (NSArray *)arrayFromLocation:(CLLocationCoordinate2D)location {
  return @[ @(location.latitude), @(location.longitude) ];
}


@end
