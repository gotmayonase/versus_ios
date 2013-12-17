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
#import <UrbanAirship-iOS-SDK/UAConfig.h>
#import <TestFlight.h>
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
  CALayer *imageLayer = self.imageView.layer;
  [imageLayer setCornerRadius:75];
  [imageLayer setBorderWidth:1];
  [imageLayer setBorderColor:[UIColor whiteColor].CGColor];
  [imageLayer setMasksToBounds:YES];
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

- (IBAction)postWin:(id)sender {
  [[AuthAPIClient sharedClient] POST:@"/api/v1/games.json" parameters:@{ @"game": @{ @"loser_id": [self.member valueForKey:@"id"]} }success:^(AFHTTPRequestOperation *operation, id responseObject) {
    [[[UIAlertView alloc] initWithTitle:@"Win posted" message:[NSString stringWithFormat:@"Your defeat of %@ has been registered. Let the public shaming begin!", [self.member valueForKey:@"email"]] delegate:nil cancelButtonTitle:@"Aww yiss!" otherButtonTitles: nil] show];
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    if (operation.response.statusCode == 403) {
//      Just posted a win
      [[[UIAlertView alloc] initWithTitle:@"WTF?" message:[NSString stringWithFormat:@"You just posted a win against %@. Chill!", [self.member valueForKey:@"email"]] delegate:nil cancelButtonTitle:@"Alright, sorry" otherButtonTitles: nil] show];
    } else {
      [[[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"We had trouble posting your win against %@.", [self.member valueForKey:@"email"]] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles: nil] show];
      TFLog(@"Error posting a win: %@", error);
    }
    
  }];

}

@end
