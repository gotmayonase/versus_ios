//
//  AuthAPIClient.m
//  versus
//
//  Created by Mike Mayo on 12/11/13.
//  Copyright (c) 2013 Mike Mayo. All rights reserved.
//

#import "AuthAPIClient.h"

#import "CredentialStore.h"

//#define BASE_URL @"http://192.168.1.77:3000/"
#define BASE_URL @"http://pongboard.herokuapp.com/"

@implementation AuthAPIClient

+ (id)sharedClient {
  static AuthAPIClient *__instance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    NSURL *baseUrl = [NSURL URLWithString:BASE_URL];
    __instance = [[AuthAPIClient alloc] initWithBaseURL:baseUrl];
  });
  return __instance;
}

- (id)initWithBaseURL:(NSURL *)url {
  self = [super initWithBaseURL:url];
  if (self) {
    [self setAuthTokenHeader];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tokenChanged:)
                                                 name:@"token-changed"
                                               object:nil];
  }
  return self;
}

- (void)setAuthTokenHeader {
  CredentialStore *store = [[CredentialStore alloc] init];
  NSString *authToken = [store authToken];
  [[self requestSerializer] setValue:authToken forHTTPHeaderField:@"token"];
}

- (void)tokenChanged:(NSNotification *)notification {
  [self setAuthTokenHeader];
}


@end
