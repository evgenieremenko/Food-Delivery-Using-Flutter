#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "GoogleMaps/GoogleMaps.h"


    @implementation AppDelegate

    - (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
[GMSServices provideAPIKey:@"AIzaSyC0uvdLGD4rGMkrMec_LSXUeWCbbGAvnBw"];
[GeneratedPluginRegistrant registerWithRegistry:self];
return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
@end