//
//  LoginViewController.m
//  versus
//
//  Created by Mike Mayo on 12/11/13.
//  Copyright (c) 2013 Mike Mayo. All rights reserved.
//

#import "LoginViewController.h"
#import <SVProgressHUD.h>
#import "AuthAPIClient.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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
  self.credStore = [CredentialStore new];
  
  if ([self.credStore isLoggedIn]) {
    [self dismissAndProceed];
  }
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissAndProceed {
  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
  UIViewController *mainView = [storyboard instantiateViewControllerWithIdentifier:@"MasterView"];
  self.navigationController.navigationBarHidden=YES;
  [self.navigationController setViewControllers:@[mainView] animated:YES];
}

- (IBAction)login:(id)sender {
  [SVProgressHUD show];
  
  NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
  NSString *deviceToken = [defs objectForKey:@"deviceToken"];
  NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.emailField.text, @"email", self.passwordField.text, @"password", nil];

  if (deviceToken) {
    [params setObject:deviceToken forKey:@"device_token"];
  }
  
  [[AuthAPIClient sharedClient] POST:@"/api/v1/users/sign_in.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSString *authToken = [responseObject objectForKey:@"auth_token"];
    [self.credStore setAuthToken:authToken];
    
    [SVProgressHUD dismiss];
    
    [self dismissAndProceed];
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    if (operation.response.statusCode == 500) {
      [SVProgressHUD showErrorWithStatus:@"Something went wrong!"];
    } else {
      NSData *jsonData = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
      NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData
                                                           options:0
                                                             error:nil];
      NSLog(@"response: %@", json);
      NSString *errorMessage = [json objectForKey:@"message"];
      [SVProgressHUD showErrorWithStatus:errorMessage];
    }

  }];
}

@end
