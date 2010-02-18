//
//  DetailNoteViewControler.m
//  PlainNote
//
//  Created by Vincent Koser on 1/28/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "DetailNoteViewControler.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@implementation DetailNoteViewControler 
@synthesize NoteDetail, Notedict, noteArray, mailButton, scrollView /*, upButton, dnButton */;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	keyboardVisible = NO;
	scrollView.contentSize = self.view.frame.size;
	
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)] autorelease];
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)] autorelease];
	
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardDidShow:)
												 name: UIKeyboardDidShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardDidHide:)
												 name: UIKeyboardDidHideNotification object:nil];
	
	if ([MFMailComposeViewController canSendMail])
		mailButton.enabled = YES;
	
	
}



- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	[self dismissModalViewControllerAnimated:YES];
}


-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	if(self.Notedict != nil){
		NoteDetail.text = [Notedict objectForKey:@"Text"];	

	}
	
}

-(void) viewWillDisappear:(BOOL)animated {
	//NSLog (@"Unregsitering for keyboard events");
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(void) keyboardDidShow: (NSNotification *)notif {
	if (keyboardVisible) {
		//NSLog(@"Keyboard is already visible. Ignoring notofication.");
		return;
	}
	
	//The keyboard wasn't visible before
	
	// Get the size of the keyboard.
	NSDictionary* info = [notif userInfo];
	NSValue* aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey]; 
	CGSize keyboardSize = [aValue CGRectValue].size;
	
	//resize the scroll view
	CGRect viewFrame = self.view.frame; 
	viewFrame.size.height -= keyboardSize.height;
	
	scrollView.frame = viewFrame;
	
	//change the button to a done instead of save
	
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save:)] autorelease];	
	keyboardVisible = YES;
}

-(void) keyboardDidHide: (NSNotification *)notif {
	
	
	NSDictionary* info = [notif userInfo];
	NSValue* aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];
	CGSize keyboardSize = [aValue CGRectValue].size;
	CGRect viewFrame = self.view.frame; 
	viewFrame.size.height += keyboardSize.height;
	scrollView.frame = viewFrame;
	
	if (!keyboardVisible) {
		//NSLog(@"Keyboard is already hidden. Ignoring notification.");
		return;
	}
	
	keyboardVisible = NO;
	
}


// to handle in app mail
- (IBAction) mailButtonAction: (id) sender {
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:@"A Note from PlainNote!"];
	
	
	// Set up recipients
//	NSArray *toRecipients = [NSArray arrayWithObject:@"first@example.com"]; 
//	NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil]; 
//	NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"]; 
	
//	[picker setToRecipients:toRecipients];
//	[picker setCcRecipients:ccRecipients];	
//	[picker setBccRecipients:bccRecipients];
	
	// Fill out the email body text
	NSString *emailBody = self.NoteDetail.text;
	[picker setMessageBody:emailBody isHTML:NO];
	
	[self presentModalViewController:picker animated:YES];
    [picker release];
}

/*
- (IBAction) upButtonAction: (id) sender { 
	
	
}

- (IBAction) dnButtonAction: (id) send { 
}
*/

- (IBAction) save: (id) sender { 
	
	if(keyboardVisible){
		self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save:)] autorelease];
		[NoteDetail resignFirstResponder];
		keyboardVisible=NO;
		return;
		
	}
	// Create a new  dictionary for the new values 
	NSMutableDictionary* newNote = [[NSMutableDictionary alloc] init]; 
	
	[newNote setValue:NoteDetail.text forKey:@"Text"]; 	
	[newNote setObject:[NSDate date] forKey:@"CDate"]; 
	
	
	if(self.Notedict != nil){
		// We're working with an exisitng note, so let's remove
		// it from the array to get ready for a new one
		[noteArray removeObject:Notedict];
		self.Notedict = nil; //This will release our reference too
		
	}
	
	// Add it to the master  array and release our reference 
	[noteArray addObject:newNote]; 
	
	[newNote release];	
	
	// Sort the array since we just aded a new drink
	NSSortDescriptor *nameSorter = [[NSSortDescriptor alloc] initWithKey:@"CDate" ascending:NO selector:@selector(compare:)];
	[noteArray sortUsingDescriptors:[NSArray arrayWithObject:nameSorter]];
	[nameSorter release];
	
	
//	NSLog(@"Save pressed!");
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction) cancel: (id) sender { 
//	NSLog(@"Cancel pressed!"); 
	[self dismissModalViewControllerAnimated:YES];
}
	

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
//	[noteArray release];
//	[Notedict release];
	[NoteDetail release];
	[scrollView release];
    [super dealloc];
}


@end
