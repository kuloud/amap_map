//
//  AMapMethodCallDispatcher.m
//  amap_map
//
//  Created by lly on 2020/11/16.
//

#import "AMapMethodCallDispatcher.h"

@interface AMapMethodCallDispatcher ()

@property (nonatomic, strong) NSRecursiveLock *dictLock;

@property (nonatomic, strong) NSMutableDictionary *callDict;

@end

@implementation AMapMethodCallDispatcher

- (instancetype)init {
    self = [super init];
    if (self) {
        self.dictLock = [[NSRecursiveLock alloc] init];
        self.callDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)onMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    [self.dictLock lock];
    FlutterMethodCallHandler handle = [self.callDict objectForKey:call.method];
    [self.dictLock unlock];
    if (handle) {
        handle(call,result);
    } else {
        NSLog(@"call method:%@ handler is null",call.method);
        result(nil);
    }
}

- (void)addMethodName:(NSString *)methodName withHandler:(FlutterMethodCallHandler)handler {
    NSAssert((methodName.length > 0 && handler != nil), @"添加methodCall回调处理参数异常");
    [self.dictLock lock];
    [self.callDict setObject:handler forKey:methodName];
    [self.dictLock unlock];
}

- (void)removeHandlerWithMethodName:(NSString *)methodName {
    NSAssert(methodName.length > 0, @"移除methodCall时，参数异常");
    [self.dictLock lock];
    [self.callDict removeObjectForKey:methodName];
    [self.dictLock unlock];
}

- (void)clearAllHandler {
    [self.dictLock lock];
    [self.callDict removeAllObjects];
    [self.dictLock unlock];
}

@end
