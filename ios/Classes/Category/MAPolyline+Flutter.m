//
//  MAPolyline+Flutter.m
//  amap_map
//
//  Created by lly on 2020/11/9.
//

#import "MAPolyline+Flutter.h"
#import <objc/runtime.h>

@implementation MAPolyline (Flutter)

- (NSString *)polylineId {
    return objc_getAssociatedObject(self, @selector(polylineId));
}

- (void)setPolylineId:(NSString * _Nonnull)polylineId {
    objc_setAssociatedObject(self, @selector(polylineId), polylineId, OBJC_ASSOCIATION_COPY);
}

- (instancetype)initWithPolylineId:(NSString *)polylineId {
    self = [super init];
    if (self) {
        self.polylineId = polylineId;
    }
    return self;
}

@end
