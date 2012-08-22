//
//  VLLFlipsideViewController.h
//  Tweet2Speech
//
//  Created by Jon Rodriguez on 8/21/12.
//  Copyright (c) 2012 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VLLFlipsideViewController;

@protocol VLLFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(VLLFlipsideViewController *)controller;
@end

@interface VLLFlipsideViewController : UIViewController

@property (weak, nonatomic) id <VLLFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
