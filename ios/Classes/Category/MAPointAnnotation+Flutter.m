//
//  MAPointAnnotation+Flutter.m
//  amap_map
//
//  Created by lly on 2020/11/9.
//

#import "MAPointAnnotation+Flutter.h"
#import <objc/runtime.h>

NSString *const AMapFlutterAnnotationViewIdentifier = @"AMapFlutterAnnotationViewIdentifier";

@implementation MAPointAnnotation (Flutter)

- (NSString *)markerId {
    return objc_getAssociatedObject(self, @selector(markerId));
}

- (void)setMarkerId:(NSString * _Nonnull)markerId {
    objc_setAssociatedObject(self, @selector(markerId), markerId, OBJC_ASSOCIATION_COPY);
}

- (instancetype)initWithMarkerId:(NSString *)markerId {
    self = [super init];
    if (self) {
        self.markerId = markerId;
    }
    return self;
}

@end
