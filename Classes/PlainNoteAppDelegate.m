//
//  PlainNoteAppDelegate.m
//  PlainNote
//
//  Created by Vincent Koser on 1/27/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import "PlainNoteAppDelegate.h"
#import "RootViewController.h"


@implementation PlainNoteAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    // Override point for customization after app launch    
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
	return YES;
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

