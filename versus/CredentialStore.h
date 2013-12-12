//
//  CredentialStore.h
//  versus
//
//  Created by Mike Mayo on 12/11/13.
//  Copyright (c) 2013 Mike Mayo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CredentialStore : NSObject

- (BOOL)isLoggedIn;
- (void)clearSavedCredentials;
- (NSString *)authToken;
- (void)setAuthToken:(NSString *)authToken;

@end
