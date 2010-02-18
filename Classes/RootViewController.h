//
//  RootViewController.h
//  PlainNote
//
//  Created by Vincent Koser on 1/27/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController {
	NSMutableArray* Notes;
	IBOutlet UIBarButtonItem *addButtonItem;
	IBOutlet UITableView *listTableView;
}
@property (nonatomic, retain) NSMutableArray* Notes;
@property (nonatomic, retain) UIBarButtonItem* addButtonItem;
@property (nonatomic, retain) UITableView* listTableView;


- (IBAction) addButtonPressed: (id) sender;

- (NSString *)applicationDocumentsDirectory;
- (void)createEditableCopyOfDatabaseIfNeeded;
- (void) applicationWillTerminate: (NSNotification *)notification;
@end
