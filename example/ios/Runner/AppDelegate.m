#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import <AMapFoundationKit/AMapServices.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GeneratedPluginRegistrant registerWithRegistry:self];
//    设置AMap的key
    [AMapServices sharedServices].apiKey = @"4dfdec97b7bf0b8c13e94777103015a9";
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
