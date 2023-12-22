#import "AMapCameraPosition.h"
#import "AMapConvertUtil.h"

@implementation AMapCameraPosition

- (NSDictionary *)toDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:4];
    [dict setObject:@(self.bearing) forKey:@"bearing"];
    [dict setObject:@(self.tilt) forKey:@"tilt"];
    [dict setObject:@(self.zoom) forKey:@"zoom"];
    if (CLLocationCoordinate2DIsValid(self.target)) {
        [dict setObject:[AMapConvertUtil jsonArrayFromCoordinate:self.target] forKey:@"target"];
    }
    return [dict copy];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"CameraPosition(bearing:%.6f, target:%@, tilt:%.6f, zoom:%.6f)",self.bearing,[AMapConvertUtil stringFromCoordinate:self.target],self.tilt,self.zoom];
}

@end
