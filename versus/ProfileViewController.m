//
//  ProfileViewController.m
//  versus
//
//  Created by Mike Mayo on 12/13/13.
//  Copyright (c) 2013 Mike Mayo. All rights reserved.
//

#import "ProfileViewController.h"
#import "CredentialStore.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logout:(id)sender {
  CredentialStore *store = [CredentialStore new];
  
  [store clearSavedCredentials];
  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
  UIViewController *loginView = [storyboard instantiateViewControllerWithIdentifier:@"LoginView"];
  self.navigationController.navigationBarHidden=YES;
  [self.navigationController setViewControllers:@[loginView] animated:YES];
}
@end
