//
//  MAPolygon+Flutter.m
//  amap_map
//
//  Created by lly on 2020/11/12.
//

#import "MAPolygon+Flutter.h"
#import <objc/runtime.h>

@implementation MAPolygon (Flutter)

- (NSString *)polygonId {
    return objc_getAssociatedObject(self, @selector(polygonId));
}

- (void)setPolygonId:(NSString * _Nonnull)polygonId {
    objc_setAssociatedObject(self, @selector(polygonId), polygonId, OBJC_ASSOCIATION_COPY);
}

- (instancetype)initWithPolygonId:(NSString *)polygonId {
    self = [super init];
    if (self) {
        self.polygonId = polygonId;
    }
    return self;
}

@end
