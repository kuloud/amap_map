//
//  MAMapView+Flutter.m
//  amap_map
//
//  Created by lly on 2020/10/30.
//  Updated by kuloud on 2024/07/29.
//

#import "MAMapView+Flutter.h"
#import "AMapCameraPosition.h"
#import "AMapConvertUtil.h"
#import "AMapJsonUtils.h"
#import <Flutter/Flutter.h>

@implementation MAMapView (Flutter)

- (void)setCameraPosition:(AMapCameraPosition *)cameraPosition animated:(BOOL)animated duration:(CFTimeInterval)duration {
    if (cameraPosition == nil) {
        return;
    }
    MAMapStatus *mapStatus = [MAMapStatus statusWithCenterCoordinate:cameraPosition.target
                                                           zoomLevel:cameraPosition.zoom
                                                      rotationDegree:cameraPosition.bearing
                                                        cameraDegree:cameraPosition.tilt
                                                        screenAnchor:self.screenAnchor];
    [self setMapStatus:mapStatus animated:animated duration:duration];
}

- (AMapCameraPosition *)getCurrentCameraPosition {
    AMapCameraPosition *position = [[AMapCameraPosition alloc] init];
    position.target = self.centerCoordinate;
    position.zoom = self.zoomLevel;
    position.bearing = self.rotationDegree;
    position.tilt = self.cameraDegree;
    return position;
}

- (void)setCameraUpdateDict:(NSDictionary *)updateDict {
    if (updateDict == nil || updateDict.count == 0) {
        return;
    }
    BOOL animated;
    if ([updateDict[@"animated"] isKindOfClass:[NSNull class]]) {
        animated = NO;
    } else {
        animated = [updateDict[@"animated"] boolValue];
    }
    double duration;
    if ([updateDict[@"duration"] isKindOfClass:[NSNull class]]) {
        duration = 0;
    } else {
        duration = [updateDict[@"duration"] doubleValue]/1000.0;
    }
    NSArray *cameraUpdate = updateDict[@"cameraUpdate"];
    //后面的操作时数组，第一个是操作符，后面才是真的参数；
    NSAssert(cameraUpdate.count >= 1, @"cameraUpdate 参数错误");
    NSString *operation = cameraUpdate.firstObject;
    if ([operation isEqualToString:@"newCameraPosition"] && cameraUpdate.count == 2) {//按照cameraPositon移动
        AMapCameraPosition *newCameraPosition = [AMapJsonUtils modelFromDict:cameraUpdate[1] modelClass:[AMapCameraPosition class]];
        [self setCameraPosition:newCameraPosition animated:animated duration:duration];
    } else if ([operation isEqualToString:@"newLatLng"] && cameraUpdate.count == 2) {//只移动屏幕中心点
        CLLocationCoordinate2D position = [AMapConvertUtil coordinateFromArray:cameraUpdate[1]];
        MAMapStatus *currentStatus = [self getMapStatus];
        currentStatus.centerCoordinate = position;
        [self setMapStatus:currentStatus animated:animated duration:duration];
    } else if ([operation isEqualToString:@"newLatLngBounds"] && cameraUpdate.count == 3) {//设置视图的显示范围和边界
//        TODO: 这里没有使用参数duration
        MAMapRect boundRect = [AMapConvertUtil mapRectFromArray:cameraUpdate[1]];
        double padding = [cameraUpdate[2] doubleValue];
        UIEdgeInsets inset = UIEdgeInsetsMake(padding, padding, padding, padding);
        [self setVisibleMapRect:boundRect edgePadding:inset animated:animated];
    } else if ([operation isEqualToString:@"newLatLngZoom"] && cameraUpdate.count == 3) {//设置地图中心点和zoomLevel
        CLLocationCoordinate2D position = [AMapConvertUtil coordinateFromArray:cameraUpdate[1]];
        CGFloat zoomLevel = [cameraUpdate[2] floatValue];
        MAMapStatus *currentStatus = [self getMapStatus];
        currentStatus.centerCoordinate = position;
        currentStatus.zoomLevel = zoomLevel;
        [self setMapStatus:currentStatus animated:animated duration:duration];
    } else if ([operation isEqualToString:@"scrollBy"] && cameraUpdate.count == 3) {//按照屏幕像素点移动
        CGPoint pixelPointOffset = CGPointMake([cameraUpdate[1] doubleValue], [cameraUpdate[2] doubleValue]);
        CGPoint updateCenter = CGPointMake(self.center.x + pixelPointOffset.x/[UIScreen mainScreen].scale, self.center.y + pixelPointOffset.y/[UIScreen mainScreen].scale);
        CLLocationCoordinate2D centerCoord = [self convertPoint:updateCenter toCoordinateFromView:self];
        MAMapStatus *currentStatus = [self getMapStatus];
        currentStatus.centerCoordinate = centerCoord;
        [self setMapStatus:currentStatus animated:animated duration:duration];
    } else if ([operation isEqualToString:@"zoomIn"]) {
        MAMapStatus *currentStatus = [self getMapStatus];
        currentStatus.zoomLevel = currentStatus.zoomLevel + 1;
        [self setMapStatus:currentStatus animated:animated duration:duration];
    } else if ([operation isEqualToString:@"zoomOut"]) {
        MAMapStatus *currentStatus = [self getMapStatus];
        currentStatus.zoomLevel = currentStatus.zoomLevel - 1;
        [self setMapStatus:currentStatus animated:animated duration:duration];
    } else if ([operation isEqualToString:@"zoomTo"] && cameraUpdate.count == 2) {
        MAMapStatus *currentStatus = [self getMapStatus];
        currentStatus.zoomLevel = [cameraUpdate[1] doubleValue];
        [self setMapStatus:currentStatus animated:animated duration:duration];
    }
}


- (void)updateMapViewOption:(NSDictionary *)dict withRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    if ([dict isKindOfClass:[NSDictionary class]] == NO || dict == nil || dict.count == 0) {
        return;
    }
    //地图类型
    NSNumber *mapType = dict[@"mapType"];
    if (mapType) {
        self.mapType = mapType.integerValue;
    }
    NSDictionary *customStyleOptions = dict[@"customStyleOptions"];
    if (customStyleOptions) {
        BOOL customMapStyleEnabled = [customStyleOptions[@"enabled"] boolValue];
        self.customMapStyleEnabled = customMapStyleEnabled;
        if (customMapStyleEnabled) {
            MAMapCustomStyleOptions *styleOption = [[MAMapCustomStyleOptions alloc] init];
            styleOption.styleData = ((FlutterStandardTypedData*)customStyleOptions[@"styleData"]).data;
            styleOption.styleExtraData = ((FlutterStandardTypedData*)customStyleOptions[@"styleExtraData"]).data;
            [self setCustomMapStyleOptions:styleOption];
        }
    }
    
    NSDictionary *locationStyleDict = dict[@"myLocationStyle"];
    if (locationStyleDict) {
        BOOL showUserLocation = [locationStyleDict[@"enabled"] boolValue];
        self.showsUserLocation = showUserLocation;
        if (showUserLocation) {
            self.userTrackingMode = MAUserTrackingModeNone;//强制设置为非追随模式，追随模式后续在demo中，使用自定义定位样式实现
            if (locationStyleDict[@"circleFillColor"] != nil
                || locationStyleDict[@"circleStrokeColor"] != nil
                || locationStyleDict[@"circleStrokeWidth"] != nil
                || locationStyleDict[@"icon"] != nil) {//自定义样式有不为空的属性时，才启动自定义的样式设置
                MAUserLocationRepresentation *locationStyle = [[MAUserLocationRepresentation alloc] init];
                if (locationStyleDict[@"circleFillColor"]) {
                    locationStyle.fillColor = [AMapConvertUtil colorFromNumber:locationStyleDict[@"circleFillColor"]];
                }
                if (locationStyleDict[@"circleStrokeColor"]) {
                    locationStyle.strokeColor = [AMapConvertUtil colorFromNumber:locationStyleDict[@"circleStrokeColor"]];
                }
                if (locationStyleDict[@"circleStrokeWidth"]) {
                    locationStyle.lineWidth = [locationStyleDict[@"circleStrokeWidth"] doubleValue];
                }
                if (locationStyleDict[@"icon"]) {
                    locationStyle.image = [AMapConvertUtil imageFromRegistrar:registrar iconData:locationStyleDict[@"icon"]];
                }
                [self updateUserLocationRepresentation:locationStyle];
            }
        }
    }

    ///地图锚点
    NSArray *screenAnchor = dict[@"screenAnchor"];
    if (screenAnchor) {
        CGPoint anchorPoint = [AMapConvertUtil pointFromArray:screenAnchor];
        self.screenAnchor = anchorPoint;
    }

    //缩放级别范围
    NSArray* zoomData = dict[@"minMaxZoomPreference"];
    if (zoomData) {
        CGFloat minZoom = (zoomData[0] == [NSNull null]) ? 3.0 : [zoomData[0] doubleValue];
        self.minZoomLevel = minZoom;
        CGFloat maxZoom = (zoomData[1] == [NSNull null]) ? 20.0 : [zoomData[1] doubleValue];
        self.maxZoomLevel = maxZoom;
    }
    NSArray *limitBounds = dict[@"limitBounds"];
    if (limitBounds) {
        MAMapRect limitRect = [AMapConvertUtil mapRectFromArray:limitBounds];
        self.limitMapRect = limitRect;
    }
    //显示路况开关
    NSNumber *showTraffic = dict[@"trafficEnabled"];
    if (showTraffic) {
        self.showTraffic = [showTraffic boolValue];
    }
    // 地图poi是否允许点击
    NSNumber *touchPOIEnable = dict[@"touchPoiEnabled"];
    if (touchPOIEnable) {
        self.touchPOIEnabled = [touchPOIEnable boolValue];
    }
    //是否显示3D建筑物
    NSNumber *showBuilding = dict[@"buildingsEnabled"];
    if (showBuilding) {
        self.showsBuildings = [showBuilding boolValue];
    }
    //是否显示底图文字标注
    NSNumber *showLable = dict[@"labelsEnabled"];
    if (showLable) {
        self.showsLabels = [showLable boolValue];
    }
    //是否显示指南针
    NSNumber *showCompass = dict[@"compassEnabled"];
    if (showCompass) {
        self.showsCompass = [showCompass boolValue];
    }
    //是否显示比例尺
    NSNumber *showScale = dict[@"scaleEnabled"];
    if (showScale) {
        self.showsScale = [showScale boolValue];
    }
    //是否支持缩放手势
    NSNumber *zoomEnable = dict[@"zoomGesturesEnabled"];
    if (zoomEnable) {
        self.zoomEnabled = [zoomEnable boolValue];
    }
    //是否支持滑动手势
    NSNumber *scrollEnable = dict[@"scrollGesturesEnabled"];
    if (scrollEnable) {
        self.scrollEnabled = [scrollEnable boolValue];
    }
    //是否支持旋转手势
    NSNumber *rotateEnable = dict[@"rotateGesturesEnabled"];
    if (rotateEnable) {
        self.rotateEnabled = [rotateEnable boolValue];
    }
    //是否支持仰角手势
    NSNumber *rotateCameraEnable = dict[@"tiltGesturesEnabled"];
    if (rotateCameraEnable) {
        self.rotateCameraEnabled = [rotateCameraEnable boolValue];
    }
    
    NSNumber *logoPosition = dict[@"logoPosition"];
    NSNumber *logoBottomMargin = dict[@"logoBottomMargin"];
    NSNumber *logoLeftMargin = dict[@"logoLeftMargin"];

    CGSize mapSize = self.bounds.size;
    CGSize logoSize = CGSizeMake(110, 40); // 官方文档只一行代码 _mapView.logoCenter = CGPointMake(CGRectGetWidth(self.view.bounds)-55, 450);，猜测logo的大小是110x40

    CGPoint logoCenter = CGPointZero;

    if (logoBottomMargin || logoLeftMargin) {
        CGFloat bottomMargin = logoBottomMargin ? [logoBottomMargin floatValue] : 0;
        CGFloat leftMargin = logoLeftMargin ? [logoLeftMargin floatValue] : 0;

        logoCenter.x = leftMargin + logoSize.width / 2;
        logoCenter.y = mapSize.height - bottomMargin - logoSize.height / 2;

    } else if (logoPosition) {
        NSInteger position = [logoPosition integerValue];
        switch (position) {
            case 0: // LOGO_POSITION_BOTTOM_LEFT
                logoCenter = CGPointMake(logoSize.width / 2, mapSize.height - logoSize.height / 2);
                break;
            case 1: // LOGO_POSITION_BOTTOM_CENTER
                logoCenter = CGPointMake(mapSize.width / 2, mapSize.height - logoSize.height / 2);
                break;
            case 2: // LOGO_POSITION_BOTTOM_RIGHT
                logoCenter = CGPointMake(mapSize.width - logoSize.width / 2, mapSize.height - logoSize.height / 2);
                break;
            default:
                // 默认为左下角
                logoCenter = CGPointMake(logoSize.width / 2, mapSize.height - logoSize.height / 2);
                break;
        }
    } else {
        logoCenter = CGPointMake(logoSize.width / 2, mapSize.height - logoSize.height / 2);
    }

    // 确保logoCenter在mapView.bounds之内
    logoCenter.x = MAX(logoSize.width / 2, MIN(logoCenter.x, mapSize.width - logoSize.width / 2));
    logoCenter.y = MAX(logoSize.height / 2, MIN(logoCenter.y, mapSize.height - logoSize.height / 2));

    // 设置logo的位置
    self.logoCenter = logoCenter;

    // 设置地图语言
    NSString *mapLanguage = dict[@"mapLanguage"];
    // 中文:@0: 英文:@1. 英文使用注意事项：1、不能和自定义地图样式同时使用；2、英文状态只在MAMapTypeStandard生效
    if ([mapLanguage isEqualToString:@"zh_cn"]) {
        self.mapLanguage = @0;
    } else if ([mapLanguage isEqualToString:@"en"]) {
        self.mapLanguage = @1;
    }
}

@end
