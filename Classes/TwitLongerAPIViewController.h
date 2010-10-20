//
//  TwitLongerAPIViewController.h
//  TwitLongerAPI
//
//  Created by Francis Chong on 10年10月20日.
//  Copyright 2010 Ignition Soft Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitLongerApi.h"

@interface TwitLongerAPIViewController : UIViewController <TwitLongerApiDelegate, UITextViewDelegate> {
	IBOutlet UIButton* twitLongerButton;
	IBOutlet UITextView* twitLongerText;
	
	TwitLongerApi* api;
}

@property (nonatomic, retain) TwitLongerApi* api;
@property (nonatomic, retain) IBOutlet UIButton* twitLongerButton;
@property (nonatomic, retain) IBOutlet UITextView* twitLongerText;

-(IBAction) buttonClicked;

@end

