//
//  WebViewController.h
//  PlainNote
//
//  Created by Vincent Koser on 2/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WebViewController : UIViewController {
	IBOutlet UIWebView *myWebView;

}
@property (nonatomic, retain) UIWebView* myWebView;

@end
