//
//  MemberDetailViewController.m
//  versus
//
//  Created by Mike Mayo on 12/12/13.
//  Copyright (c) 2013 Mike Mayo. All rights reserved.
//

#import "MemberDetailViewController.h"
#import <UIImageView+KHGravatar.h>
#import "AuthAPIClient.h"

@interface MemberDetailViewController ()

@end

@implementation MemberDetailViewController

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
  NSLog(@"member: %@", self.member);
  self.nameLabel.text = [self.member valueForKey:@"email"];
  [self.imageView setImageWithGravatarEmailAddress:[self.member valueForKey:@"email"]];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)play:(id)sender {
  [[AuthAPIClient sharedClient] POST:[NSString stringWithFormat:@"/api/v1/members/%@/play.json",[self.member objectForKey:@"id"]] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    [[[UIAlertView alloc] initWithTitle:@"Player notification success" message:[NSString stringWithFormat:@"%@ has been notified that you are ready to play.", [self.member valueForKey:@"email"]] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil] show];
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    [[[UIAlertView alloc] initWithTitle:@"Player notification error" message:[NSString stringWithFormat:@"%@ could not be notified at this time.", [self.member valueForKey:@"email"]] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil] show];
  }];
}

@end
