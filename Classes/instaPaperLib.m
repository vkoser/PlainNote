//
//  instaPaperLib.m
//  PlainNote
//
//  Created by Vincent Koser on 2/20/10.
//  Copyright 2010 kosertech. All rights reserved.
//

#import "instaPaperLib.h"


@implementation instaPaperLib


// returns YES if everythign went ok returns NO if a bad status or connection error
-(BOOL) postToInstapaperWithUserName:(NSString*)username andPassword:(NSString*)password 
							 andBody:(NSString*)PostText andURL:(NSString*)url andTitle:(NSString*)title{
	
	BOOL responseCode = NO;
	
	/// post in the form of
	// www.instapaper.com/api/add?username=username&password=password&selection=this%20is%20some%20sample%20text&url=www.urlhere.com
	
	
	NSString *post = [NSString stringWithFormat:@"username=%@&password=%@&selection=%@&url=%@&title=%@",
					  username, password, PostText, url, title];
	//NSLog(post);
	
	NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
	
	NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
	
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
	[request setURL:[NSURL URLWithString:@"https://www.instapaper.com/api/add"]];
	[request setHTTPMethod:@"POST"];
	[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
	[request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

	//post it
	[request setHTTPBody:postData];
	
	//get response
	NSHTTPURLResponse* urlResponse = nil;
	NSError *error = [[NSError alloc] init];
	NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
	NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	NSLog(@"Response Code: %d", [urlResponse statusCode]);
	if ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300) {
		NSLog(@"Response: %@", result);
		//here you get the response
		responseCode = YES;
	}
	
	return responseCode;
}

@end
