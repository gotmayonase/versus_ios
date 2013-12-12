//
//  MembersListViewController.m
//  versus
//
//  Created by Mike Mayo on 12/11/13.
//  Copyright (c) 2013 Mike Mayo. All rights reserved.
//

#import "MembersListViewController.h"
#import "AuthAPIClient.h"
#import <KHGravatar/UIImageView+KHGravatar.h>
@interface MembersListViewController ()

@end

@implementation MembersListViewController {
  NSArray *members;
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
  members = @[];

}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [[AuthAPIClient sharedClient] GET:@"/api/v1/members.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    members = responseObject;
    [self.tableView reloadData];
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"Failure loading members!: %@", error);
  }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MemberCell"];
  NSDictionary *member = [members objectAtIndex:indexPath.row];
  UILabel *email = (UILabel *)[cell viewWithTag:1];
  UIImageView *img = (UIImageView *)[cell viewWithTag:2];
  [img setImageWithGravatarEmailAddress:[member valueForKey:@"email"]];
  [email setText:[member valueForKey:@"email"]];
  return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return members.count;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  NSDictionary *member = [members objectAtIndex:[self.tableView indexPathForCell:sender].row];
  [segue.destinationViewController setValue:member forKey:@"member"];
}

@end
