//
//  AppDelegate.m
//  versus
//
//  Created by Mike Mayo on 12/11/13.
//  Copyright (c) 2013 Mike Mayo. All rights reserved.
//

#import "AppDelegate.h"
#import <TestFlight.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
  // Populate AirshipConfig.plist with your app's info from https://go.urbanairship.com
  // or set runtime properties here.
  [TestFlight takeOff:@"9cbbfdcd2667006c96e18835081d7a57_MzEyOTY4MjAxMy0xMi0xMiAyMTo0Nzo0Ni44MTE1OTc"];
  UAConfig *config = [UAConfig defaultConfig];
  
  // You can also programmatically override the plist values:
  // config.developmentAppKey = @"YourKey";
  // etc.
  
  // Call takeOff (which creates the UAirship singleton)
  [UAirship takeOff:config];
  
  [[UAPush shared] setRegistrationDelegate:self];
  [[UAPush shared] resetBadge];
  
  [UAPush shared].notificationTypes = (UIRemoteNotificationTypeBadge |
                                       UIRemoteNotificationTypeSound |
                                       UIRemoteNotificationTypeAlert);
  return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - UAPush Registration Delegate

- (void)registerDeviceTokenFailed:(UAHTTPRequest *)request {
  
}

- (void)registerDeviceTokenSucceeded {
  NSString *deviceToken = [UAPush shared].deviceToken;
  NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
  [defs setObject:deviceToken forKey:@"deviceToken"];
  [defs synchronize];
  CredentialStore *store = [[CredentialStore alloc] init];
  if ([store isLoggedIn]) {
    [[AuthAPIClient sharedClient] POST:@"/api/v1/users/register_device_token.json" parameters:@{ @"device_token": deviceToken } success:^(AFHTTPRequestOperation *operation, id responseObject) {
      NSLog(@"device token registered with API!");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
      NSLog(@"Failed to register device token with API: %@", error);
    }];
  }
}

@end
