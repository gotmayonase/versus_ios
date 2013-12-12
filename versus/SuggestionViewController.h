//
//  SuggestionViewController.h
//  versus
//
//  Created by Mike Mayo on 12/11/13.
//  Copyright (c) 2013 Mike Mayo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuggestionViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

- (IBAction)play:(id)sender;


@end
