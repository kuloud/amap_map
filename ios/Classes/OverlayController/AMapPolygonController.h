//
//  AMapPolygonController.h
//  amap_map
//
//  Created by lly on 2020/11/12.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AMapPolyline;
@class AMapPolygon;

@interface AMapPolygonController : NSObject

- (instancetype)init:(FlutterMethodChannel*)methodChannel
             mapView:(MAMapView*)mapView
           registrar:(NSObject<FlutterPluginRegistrar>*)registrar;

- (nullable AMapPolygon *)polygonForId:(NSString *)polygonId;

- (void)addPolygons:(NSArray*)polygonsToAdd;

- (void)changePolygons:(NSArray*)polygonsToChange;

- (void)removePolygonIds:(NSArray*)polygonIdsToRemove;

@end

NS_ASSUME_NONNULL_END
