//
//  AMapMethodCallDispatcher.h
//  amap_map
//
//  Created by lly on 2020/11/16.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

/// methodCall的分发器，该对象以Category的形式设置给FlutterMethodChannel，作为FlutterMethodCallHandler，
/// 再根据call.method来分发处理对应的处理block
@interface AMapMethodCallDispatcher : NSObject

- (void)onMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result;

- (void)addMethodName:(NSString *)methodName withHandler:(FlutterMethodCallHandler)handler;

- (void)removeHandlerWithMethodName:(NSString *)methodName;

- (void)clearAllHandler;

@end

NS_ASSUME_NONNULL_END
