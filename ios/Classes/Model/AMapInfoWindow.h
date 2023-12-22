//
//  AMapInfoWindow.h
//  amap_map
//
//  Created by lly on 2020/11/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AMapInfoWindow : NSObject

@property (nonatomic, copy) NSString* title;

@property (nonatomic, copy) NSString* snippet;

@property (nonatomic, assign) CGPoint anchor;

@end

NS_ASSUME_NONNULL_END
