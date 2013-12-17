//
//  SuggestionViewController.m
//  versus
//
//  Created by Mike Mayo on 12/11/13.
//  Copyright (c) 2013 Mike Mayo. All rights reserved.
//

#import "SuggestionViewController.h"
#import "AuthAPIClient.h"
#import <UIImageView+KHGravatar.h>
#import <QuartzCore/QuartzCore.h>
#import <SVProgressHUD.h>

@interface SuggestionViewController ()

@end

@implementation SuggestionViewController {
}


- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [SVProgressHUD showWithStatus:@"Finding a worthy opponent"];
  [[AuthAPIClient sharedClient] GET:@"/api/v1/members/suggest.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    self.member = responseObject;
    self.nameLabel.text = [self.member valueForKey:@"email"];
    [self.imageView setImageWithGravatarEmailAddress:[self.member valueForKey:@"email"]];
    [SVProgressHUD dismiss];
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    [SVProgressHUD dismiss];
    NSLog(@"Failure loading suggestion: %@", error);
  }];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
