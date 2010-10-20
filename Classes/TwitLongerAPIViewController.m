//
//  TwitLongerAPIViewController.m
//  TwitLongerAPI
//
//  Created by Francis Chong on 10年10月20日.
//  Copyright 2010 Ignition Soft Limited. All rights reserved.
//

#import "TwitLongerAPIViewController.h"

@implementation TwitLongerAPIViewController

@synthesize twitLongerButton, twitLongerText, api;

-(void) loadView {
	[super loadView];

	api = [[TwitLongerApi alloc] init];
	api.twitLongerDelegate = self;
	
	self.twitLongerText.delegate = self;
}

- (void)viewDidUnload {

}

- (void)dealloc {
	self.api = nil;
    [super dealloc];
}

-(IBAction) buttonClicked {
	[self.api postMessage:twitLongerText.text withUsername:@"siuying"];
}

#pragma mark UITextViewDelegate

- (void)textViewDidEndEditing:(UITextView *)textView {
	[self buttonClicked];
}

#pragma mark TwitLongerApiDelegate

-(void) twitLongerPosted:(NSString*)postId link:(NSString*)link shortLink:(NSString*)shortLink content:(NSString*)content {
	self.twitLongerText.text = content;
}

-(void) twitLongerFailed:(NSError*)error withMessage:(NSString*)message {
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error contacting TwitLonger" 
													message:message
												   delegate:nil
										  cancelButtonTitle:@"Cancel" 
										  otherButtonTitles:@"OK", nil];
	[alert show];
	[alert release];
}



@end
