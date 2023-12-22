//
//  AMapPolygonController.m
//  amap_map
//
//  Created by lly on 2020/11/12.
//

#import "AMapPolygonController.h"
#import "AMapPolygon.h"
#import "AMapJsonUtils.h"
#import "MAPolygon+Flutter.h"
#import "MAPolygonRenderer+Flutter.h"
#import "FlutterMethodChannel+MethodCallDispatch.h"

@interface AMapPolygonController ()

@property (nonatomic,strong) NSMutableDictionary<NSString*,AMapPolygon*> *polygonDict;
@property (nonatomic,strong) FlutterMethodChannel *methodChannel;
@property (nonatomic,strong) NSObject<FlutterPluginRegistrar> *registrar;
@property (nonatomic,strong) MAMapView *mapView;

@end


@implementation AMapPolygonController

- (instancetype)init:(FlutterMethodChannel*)methodChannel
             mapView:(MAMapView*)mapView
           registrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    self = [super init];
    if (self) {
        _methodChannel = methodChannel;
        _mapView = mapView;
        _polygonDict = [NSMutableDictionary dictionaryWithCapacity:1];
        _registrar = registrar;
        
        __weak typeof(self) weakSelf = self;
        [_methodChannel addMethodName:@"polygons#update" withHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
            id polygonsToAdd = call.arguments[@"polygonsToAdd"];
            if ([polygonsToAdd isKindOfClass:[NSArray class]]) {
                [weakSelf addPolygons:polygonsToAdd];
            }
            id polygonsToChange = call.arguments[@"polygonsToChange"];
            if ([polygonsToChange isKindOfClass:[NSArray class]]) {
                [weakSelf changePolygons:polygonsToChange];
            }
            id polygonIdsToRemove = call.arguments[@"polygonIdsToRemove"];
            if ([polygonIdsToRemove isKindOfClass:[NSArray class]]) {
                [weakSelf removePolygonIds:polygonIdsToRemove];
            }
            result(nil);
        }];
    }
    return self;
}

- (nullable AMapPolygon *)polygonForId:(NSString *)polygonId {
    return _polygonDict[polygonId];
}

- (void)addPolygons:(NSArray*)polygonsToAdd {
    for (NSDictionary* polygonDict in polygonsToAdd) {
        AMapPolygon *polygon = [AMapJsonUtils modelFromDict:polygonDict modelClass:[AMapPolygon class]];
        // 先加入到字段中，避免后续的地图回到里，取不到对应的overlay数据
        if (polygon.id_) {
            _polygonDict[polygon.id_] = polygon;
        }
        [self.mapView addOverlay:polygon.polygon];
    }
}

- (void)changePolygons:(NSArray*)polygonsToChange {
    for (NSDictionary* polygonDict in polygonsToChange) {
        AMapPolygon *polygon = [AMapJsonUtils modelFromDict:polygonDict modelClass:[AMapPolygon class]];
        AMapPolygon *currentPolygon = _polygonDict[polygon.id_];
        NSAssert(currentPolygon != nil, @"需要修改的Polygon不存在");
        [currentPolygon updatePolygon:polygon];
        MAOverlayRenderer *render = [self.mapView rendererForOverlay:currentPolygon.polygon];
        if (render && [render isKindOfClass:[MAPolygonRenderer class]]) { // render没有复用，只要添加过，就一定可以获取到
            [(MAPolygonRenderer *)render updateRenderWithPolygon:currentPolygon];
        }
    }
}

- (void)removePolygonIds:(NSArray*)polygonIdsToRemove {
    for (NSString* polygonId in polygonIdsToRemove) {
        if (!polygonId) {
            continue;
        }
        AMapPolygon* polygon = _polygonDict[polygonId];
        if (!polygon) {
            continue;
        }
        [self.mapView removeOverlay:polygon.polygon];
        [_polygonDict removeObjectForKey:polygonId];
    }
}

@end
