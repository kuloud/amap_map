//
//  AMapPolylineController.h
//  amap_map
//
//  Created by lly on 2020/11/6.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AMapPolyline;

@interface AMapPolylineController : NSObject

- (instancetype)init:(FlutterMethodChannel*)methodChannel
             mapView:(MAMapView*)mapView
           registrar:(NSObject<FlutterPluginRegistrar>*)registrar;

- (nullable AMapPolyline *)polylineForId:(NSString *)polylineId;

- (void)addPolylines:(NSArray*)polylinesToAdd;

- (void)changePolylines:(NSArray*)polylinesToChange;

- (void)removePolylineIds:(NSArray*)polylineIdsToRemove;

- (BOOL)onPolylineTap:(NSString*)polylineId;

@end

NS_ASSUME_NONNULL_END
