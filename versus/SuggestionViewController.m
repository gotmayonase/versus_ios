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
  NSDictionary *member;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  CALayer *imageLayer = self.imageView.layer;
  [imageLayer setCornerRadius:75];
  [imageLayer setBorderWidth:1];
  [imageLayer setBorderColor:[UIColor whiteColor].CGColor];
  [imageLayer setMasksToBounds:YES];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [SVProgressHUD showWithStatus:@"Finding a worthy opponent"];
  [[AuthAPIClient sharedClient] GET:@"/api/v1/members/suggest.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    member = responseObject;
    self.nameLabel.text = [member valueForKey:@"email"];
    [self.imageView setImageWithGravatarEmailAddress:[member valueForKey:@"email"]];
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

- (IBAction)play:(id)sender {
  [[AuthAPIClient sharedClient] POST:[NSString stringWithFormat:@"/api/v1/members/%@/play.json",[member objectForKey:@"id"]] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    [[[UIAlertView alloc] initWithTitle:@"Player notification success" message:[NSString stringWithFormat:@"%@ has been notified that you are ready to play.", [member valueForKey:@"email"]] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil] show];
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    [[[UIAlertView alloc] initWithTitle:@"Player notification error" message:[NSString stringWithFormat:@"%@ could not be notified at this time.", [member valueForKey:@"email"]] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil] show];
  }];
}
@end
