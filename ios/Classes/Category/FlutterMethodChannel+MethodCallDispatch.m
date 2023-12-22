//
//  FlutterMethodChannel+MethodCallDispatch.m
//  amap_map
//
//  Created by lly on 2020/11/16.
//

#import "FlutterMethodChannel+MethodCallDispatch.h"
#import <objc/runtime.h>

@implementation FlutterMethodChannel (MethodCallDispatch)

- (AMapMethodCallDispatcher *)methodCallDispatcher {
    return objc_getAssociatedObject(self, @selector(methodCallDispatcher));
}

- (void)setMethodCallDispatcher:(AMapMethodCallDispatcher *)dispatcher {
    objc_setAssociatedObject(self, @selector(methodCallDispatcher), dispatcher, OBJC_ASSOCIATION_RETAIN);
}

- (void)addMethodName:(NSString *)methodName withHandler:(FlutterMethodCallHandler)handler {
    if (self.methodCallDispatcher == nil) {
        self.methodCallDispatcher = [[AMapMethodCallDispatcher alloc] init];
        __weak typeof(self) weakSelf = self;
        [self setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
            if (weakSelf.methodCallDispatcher) {
                [weakSelf.methodCallDispatcher onMethodCall:call result:result];
            }
        }];
    }
    [self.methodCallDispatcher addMethodName:methodName withHandler:handler];
}

- (void)removeHandlerWithMethodName:(NSString *)methodName {
    [self.methodCallDispatcher removeHandlerWithMethodName:methodName];
}

- (void)clearAllHandler {
    [self.methodCallDispatcher clearAllHandler];
}

@end
