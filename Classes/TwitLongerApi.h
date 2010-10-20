//
//  TwitLongerApi.h
//  TwitLongerAPI
//
//  Created by Francis Chong on 10年10月20日.
//  Copyright 2010 Ignition Soft Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

#define kTwitLongerAppName	@"AppName"
#define kTwitLongerApiKey	@"ApiKey"

@protocol TwitLongerApiDelegate

-(void) twitLongerPosted:(NSString*)postId link:(NSString*)link shortLink:(NSString*)shortLink content:(NSString*)string;
-(void) twitLongerFailed:(NSError*)error withMessage:(NSString*)message;

@end


@interface TwitLongerApi : NSObject <ASIHTTPRequestDelegate> {
	id<TwitLongerApiDelegate> twitLongerDelegate;
}

@property (nonatomic, assign) id<TwitLongerApiDelegate> twitLongerDelegate;

-(void) postMessage:(NSString*)message withUsername:(NSString*)username;
-(void) postMessage:(NSString*)message withUsername:(NSString*)username inReplyStatusId:(NSString*)inReplyStatusId inReplyUsername:(NSString*)inReplyUsername;

@end
