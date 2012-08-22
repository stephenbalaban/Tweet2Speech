//
//  VLLMainViewController.h
//  Tweet2Speech
//
//  Created by Jon Rodriguez on 8/21/12.
//  Copyright (c) 2012 Stanford University. All rights reserved.
//

#import "VLLFlipsideViewController.h"

@interface VLLMainViewController : UIViewController <VLLFlipsideViewControllerDelegate, UIPopoverControllerDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

@end
