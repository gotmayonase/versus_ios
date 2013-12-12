//
//  MemberDetailViewController.h
//  versus
//
//  Created by Mike Mayo on 12/12/13.
//  Copyright (c) 2013 Mike Mayo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberDetailViewController : UIViewController

@property (nonatomic, strong) NSDictionary *member;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

- (IBAction)play:(id)sender;

@end
