//
//  TwitLongerApi.m
//  TwitLongerAPI
//
//  Created by Francis Chong on 10年10月20日.
//  Copyright 2010 Ignition Soft Limited. All rights reserved.
//

#import "TwitLongerApi.h"
#import "CXMLDocument.h"

#define kApiPostLocation @"http://www.twitlonger.com/api_post"

@implementation TwitLongerApi

@synthesize twitLongerDelegate;

-(void) postMessage:(NSString*)message withUsername:(NSString*)username inReplyStatusId:(NSString*)inReplyStatusId inReplyUsername:(NSString*)inReplyUsername{
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kApiPostLocation]];
	[request setPostValue:kTwitLongerAppName forKey:@"application"];
	[request setPostValue:kTwitLongerApiKey forKey:@"api_key"];
	[request setPostValue:username forKey:@"username"];
	[request setPostValue:message forKey:@"message"];

	if (inReplyStatusId) {
		[request setPostValue:inReplyStatusId forKey:@"in_reply"];		
	}

	if (inReplyUsername) {
		[request setPostValue:inReplyUsername forKey:@"in_reply_user"];		
	}

	[request setDelegate:self];
	[request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
	// Use when fetching text data
	NSString *responseString = [request responseString];
	
	NSError* error;
	CXMLDocument* doc = [[CXMLDocument alloc] initWithXMLString:responseString options:0 error:&error];
	if (error) {
		[self.twitLongerDelegate twitLongerFailed:error 
									  withMessage:[error localizedDescription]];
		return;
	}

	// check if there are error
	NSArray* errNodes = [doc nodesForXPath:@"/twitlonger/error" error:&error];
	if (error) {
		[self.twitLongerDelegate twitLongerFailed:error 
									  withMessage:[error localizedDescription]];
		return;	
	}
	if ([errNodes count] > 0) {
		CXMLElement* errorElem = [errNodes objectAtIndex:0];
		[self.twitLongerDelegate twitLongerFailed:[NSError errorWithDomain:@"" code:1 userInfo:nil]
									  withMessage:[errorElem stringValue]];
		return;
	}
	
	// parse post
	NSArray* postNode = [doc nodesForXPath:@"/twitlonger/post" error:&error];
	if (error) {
		[self.twitLongerDelegate twitLongerFailed:error 
									  withMessage:[error localizedDescription]];
		return;	
	}

	if ([postNode count] > 0) {
		CXMLElement* postElem = [postNode objectAtIndex:0];

		NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
		int counter;
		for(counter = 0; counter < [postElem childCount]; counter++) {
			[item setObject:[[postElem childAtIndex:counter] stringValue] forKey:[[postElem childAtIndex:counter] name]];
		}
		[self.twitLongerDelegate twitLongerPosted:[item objectForKey:@"id"]
											 link:[item objectForKey:@"link"] 
										shortLink:[item objectForKey:@"short"] 
										  content:[item objectForKey:@"content"]];
		[item release];

	} else {
		[self.twitLongerDelegate twitLongerFailed:[NSError errorWithDomain:@"TwitLongerError" code:2 userInfo:[NSDictionary dictionary]]
									  withMessage:@"No post found, unexpected XML"];
		
	}

}

- (void)requestFailed:(ASIHTTPRequest *)request
{
	NSError *error = [request error];
	[self.twitLongerDelegate twitLongerFailed:error 
								  withMessage:[error localizedDescription]];
}

-(void) postMessage:(NSString*)message withUsername:(NSString*)username {
	[self postMessage:message withUsername:username inReplyStatusId:nil inReplyUsername:nil];
}

@end
