//
//  FlutterMethodChannel+MethodCallDispatch.h
//  amap_map
//
//  Created by lly on 2020/11/16.
//

#import <Flutter/Flutter.h>
#import "AMapMethodCallDispatcher.h"

NS_ASSUME_NONNULL_BEGIN

@interface FlutterMethodChannel (MethodCallDispatch)

@property (nonatomic,strong,readonly) AMapMethodCallDispatcher* methodCallDispatcher;


/// 添加methodCall的回调（注意：使用该方法之后，就不能再调用setMethodCallHandler: 方法了）
/// @param methodName methodName对应call的唯一方法名
/// @param handler 回调处理
- (void)addMethodName:(NSString *)methodName withHandler:(FlutterMethodCallHandler)handler;

/// 移除methodCall对应的回调
/// @param methodName 唯一的方法名
- (void)removeHandlerWithMethodName:(NSString *)methodName;

/// 清空所有的handler
- (void)clearAllHandler;

@end

NS_ASSUME_NONNULL_END
