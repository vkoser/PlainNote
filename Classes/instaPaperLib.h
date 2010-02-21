//
//  instaPaperLib.h
//  PlainNote
//
//  Created by Vincent Koser on 2/20/10.
//  Copyright 2010 kosertech. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface instaPaperLib : NSObject {

}

-(BOOL) postToInstapaperWithUserName:(NSString*)username andPassword:(NSString*)password andBody:(NSString*)PostText 
							  andURL:(NSString*)url andTitle:(NSString*)title;

@end
