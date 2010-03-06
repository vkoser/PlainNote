//
//  syncPlainNote.h
//  PlainNote
//
//  Created by Vincent Koser on 2/26/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface syncPlainNote : NSObject {

}

- (NSDictionary *) loginWithUsername:(NSString*)username andPassword:(NSString*)password andUUID:(NSString*)UUID;
- (NSString *)GetUUID;



@end
