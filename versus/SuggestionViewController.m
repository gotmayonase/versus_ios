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

@interface SuggestionViewController ()

@end

@implementation SuggestionViewController

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
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [[AuthAPIClient sharedClient] GET:@"/api/v1/members/suggest.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    self.nameLabel.text = [responseObject valueForKey:@"email"];
    [self.imageView setImageWithGravatarEmailAddress:[responseObject valueForKey:@"email"]];
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"Failure loading suggestion: %@", error);
  }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)play:(id)sender {
  [[[UIAlertView alloc] initWithTitle:@"No" message:@"You are not prepared!" delegate:nil cancelButtonTitle:@"Run away crying" otherButtonTitles: nil] show];
}
@end
