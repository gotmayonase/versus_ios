//
//  MemberDetailViewController.m
//  versus
//
//  Created by Mike Mayo on 12/12/13.
//  Copyright (c) 2013 Mike Mayo. All rights reserved.
//

#import "MemberDetailViewController.h"
#import <UIImageView+KHGravatar.h>

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
  [[[UIAlertView alloc] initWithTitle:@"No" message:@"You are not prepared!" delegate:nil cancelButtonTitle:@"Run away crying" otherButtonTitles: nil] show];
}

@end
