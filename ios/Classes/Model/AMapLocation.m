//
//  AMapLocation.m
//  amap_map
//
//  Created by lly on 2020/11/12.
//

#import "AMapLocation.h"

@implementation AMapLocation

- (instancetype)init {
    self = [super init];
    if (self) {
        self.provider = @"iOS";
    }
    return self;
}

- (void)updateWithUserLocation:(CLLocation *)location {
    if (location == nil) {
        return;
    }
    self.latLng = location.coordinate;
    self.accuracy = location.horizontalAccuracy;
    self.altitude = location.altitude;
    self.bearing = location.course;
    self.speed = location.speed;
    self.time = [location.timestamp timeIntervalSince1970]*1000;
}

@end
