//
//  AuthAPIClient.h
//  versus
//
//  Created by Mike Mayo on 12/11/13.
//  Copyright (c) 2013 Mike Mayo. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface AuthAPIClient : AFHTTPRequestOperationManager

+ (id)sharedClient;

@end
