//
//  DetailNoteViewControler.h
//  PlainNote
//
//  Created by Vincent Koser on 1/28/10.
//  Copyright kosertech 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>


@interface DetailNoteViewControler : UIViewController <MFMailComposeViewControllerDelegate,UIAlertViewDelegate,UITextViewDelegate> {
	NSDictionary *Notedict;
	IBOutlet UITextView *NoteDetail;
	NSMutableArray *noteArray;
	IBOutlet UIBarButtonItem *mailButton;
	//future for up and down through notes
//	IBOutlet UIBarButtonItem *upButton;
//	IBOutlet UIBarButtonItem *dnButton;
	BOOL keyboardVisible;
	BOOL didEdit;
	IBOutlet UIScrollView *scrollView;

	
}


@property (nonatomic, retain) NSMutableArray* noteArray;
@property (nonatomic, retain) UITextView *NoteDetail;
@property (nonatomic, retain) NSDictionary *Notedict;
@property (nonatomic, retain) UIBarButtonItem *mailButton;
@property (nonatomic, retain) UIScrollView *scrollView;

//@property (nonatomic, retain) UIBarButtonItem *upButton;
//@property (nonatomic, retain) UIBarButtonItem *dnButton;


-(void)keyboardDidShow:(NSNotification *)notif;
-(void)keyboardDidHide:(NSNotification *)notif;
-(void)textViewDidChange:(UITextView *)NoteDetail;
-(void)savePlist;
- (IBAction) save: (id) sender;
- (IBAction) cancel: (id) sender;
- (IBAction) mailButtonAction: (id) sender;
//future for up and down through notes
//- (IBAction) upButtonAction: (id) sender;
//- (IBAction) dnButtonAction: (id) sender;



@end
