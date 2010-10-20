//
//  TwitLongerAPIAppDelegate.h
//  TwitLongerAPI
//
//  Created by Francis Chong on 10年10月20日.
//  Copyright 2010 Ignition Soft Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TwitLongerAPIViewController;

@interface TwitLongerAPIAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TwitLongerAPIViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TwitLongerAPIViewController *viewController;

@end

