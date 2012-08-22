//
//  VLLMainViewController.m
//  Tweet2Speech
//
//  Created by Jon Rodriguez on 8/21/12.
//  Copyright (c) 2012 Stanford University. All rights reserved.
//

#import "VLLMainViewController.h"
#import <Twitter/Twitter.h>

@interface VLLMainViewController ()

@end

@implementation VLLMainViewController

@synthesize flipsidePopoverController = _flipsidePopoverController;

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  // done
  
  [self loopGetAndSpeakTweets];
}

- (void)loopGetAndSpeakTweets
{
  // never returns
  
  NSLog(@"hello world");
  
  NSString *s1 = @"http://api.twitter.com/1/statuses/user_timeline.json?screen_name=brain_based_ai";
  NSString *s2 = @"http://search.twitter.com/search.json?q=Vergence%20Labs&rpp=5&with_twitter_user_id=true&result_type=recent";
  NSString *request_query = s1;
  
  // Do a simple search, using the Twitter API
  TWRequest *request = [[TWRequest alloc] initWithURL:[NSURL URLWithString: request_query] 
                                           parameters:nil requestMethod:TWRequestMethodGET];
  
  // Notice this is a block, it is the handler to process the response
  [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error)
  {
    if ([urlResponse statusCode] == 200) 
    {
      // The response from Twitter is in JSON format
      // Move the response into a dictionary and print
      NSError *error;        
      NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
      NSLog(@"Twitter response: %@", dict);                           
    }
    else
      NSLog(@"Twitter error, HTTP response: %i", [urlResponse statusCode]);
  }];
  
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
      return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
  } else {
      return YES;
  }
}

#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(VLLFlipsideViewController *)controller
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissModalViewControllerAnimated:YES];
    } else {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.flipsidePopoverController = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
            self.flipsidePopoverController = popoverController;
            popoverController.delegate = self;
        }
    }
}

- (IBAction)togglePopover:(id)sender
{
    if (self.flipsidePopoverController) {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    } else {
        [self performSegueWithIdentifier:@"showAlternate" sender:sender];
    }
}

@end
