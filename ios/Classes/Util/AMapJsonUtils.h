//
//  MAJsonUtils.h
//  amap_map
//
//  Created by shaobin on 2019/2/13.
//  Copyright © 2019 Amap.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AMapJsonUtils : NSObject

/**
 model转为可序列化为json的对象。
 
 @param model model对象:支持NSDictionary、NSArray、自定义类，且支持嵌套(Dict、Array内包含自定义类示例，或自定义类内包含Dict、Array) 注意如果自定义类或dict、array中包含非字符串、数字、布尔、null类型的属性，其行为是undefined的
 @return 返回NSArray或者NSDictionary对象，如果失败返回nil。
 */
+ (id)jsonObjectFromModel:(id)model;

/**
 dict转model
 
 @param dict dict
 @param modelClass model对应的Class
 @return 返回modelClass实例
 */
+ (id)modelFromDict:(NSDictionary*)dict modelClass:(Class)modelClass;


@end

NS_ASSUME_NONNULL_END
