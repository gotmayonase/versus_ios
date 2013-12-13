//
//  AppDelegate.h
//  versus
//
//  Created by Mike Mayo on 12/11/13.
//  Copyright (c) 2013 Mike Mayo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UrbanAirship-iOS-SDK/UAirship.h>
#import <UrbanAirship-iOS-SDK/UAConfig.h>
#import <UrbanAirship-iOS-SDK/UAPush.h>
#import "AuthAPIClient.h"
#import "CredentialStore.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UARegistrationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
