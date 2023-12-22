//
//  AMapMarkerController.h
//  amap_map
//
//  Created by lly on 2020/11/3.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AMapMarker;

@interface AMapMarkerController : NSObject

- (instancetype)init:(FlutterMethodChannel*)methodChannel
             mapView:(MAMapView*)mapView
           registrar:(NSObject<FlutterPluginRegistrar>*)registrar;

- (nullable AMapMarker *)markerForId:(NSString *)markerId;

- (void)addMarkers:(NSArray*)markersToAdd;

- (void)changeMarkers:(NSArray*)markersToChange;

- (void)removeMarkerIds:(NSArray*)markerIdsToRemove;

//MARK: Marker的回调

- (BOOL)onMarkerTap:(NSString*)markerId;

- (BOOL)onMarker:(NSString *)markerId endPostion:(CLLocationCoordinate2D)position;

//- (BOOL)onInfoWindowTap:(NSString *)markerId;

@end

NS_ASSUME_NONNULL_END
