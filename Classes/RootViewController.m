//
//  RootViewController.m
//  PlainNote
//
//  Created by Vincent Koser on 1/27/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import "RootViewController.h"
#import "DetailNoteViewControler.h"

@implementation RootViewController
@synthesize Notes, addButtonItem, listTableView;


- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navigationItem.rightBarButtonItem = self.addButtonItem;
	[self createEditableCopyOfDatabaseIfNeeded];	
	
	//theme info
//	listTableView.backgroundColor = [UIColor blackColor];
	
	// Register for application exiting information so we can save data
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate:) name:UIApplicationWillTerminateNotification object:nil];

	NSString *documentDirectory = [self applicationDocumentsDirectory];
	NSString *path = [documentDirectory stringByAppendingPathComponent:@"NotesList.plist"];
	
	//NSString *path = [[NSBundle mainBundle] pathForResource:@"NotesList" ofType:@"plist"];
	NSMutableArray *tmpArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
	self.Notes = tmpArray;
	[tmpArray release];

	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (IBAction) addButtonPressed: (id) sender { 
//	NSLog(@"Add button pressed!");
	
	DetailNoteViewControler *noteDetailViewControler = [[DetailNoteViewControler alloc] initWithNibName:@"DetailNoteViewControler" bundle:nil];
	
	// this adds a navication bar to the noteDetailViewController
	UINavigationController *addNavCon = [[UINavigationController alloc] initWithRootViewController:noteDetailViewControler];
	noteDetailViewControler.noteArray = self.Notes;

	[self presentModalViewController:addNavCon animated:YES];
	
	[addNavCon release];
	[noteDetailViewControler release];
	
	
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	// important to reload data when view is redrawn
	[self.tableView reloadData];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.Notes count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
	


	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
       // cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
	//theme info
	//cell.contentView.clipsToBounds = YES;
//	[cell.contentView setBackgroundColor:[UIColor darkGrayColor]];
//	[self.tableView reloadData];		
	// Configure the cell.
	//cell.textLabel.backgroundColor = [UIColor darkGrayColor];
	cell.textLabel.text = [[self.Notes objectAtIndex:indexPath.row ]objectForKey:@"Text"];

	
	
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat: @"yyyy-MM-dd HH:mm:ss zzz"];
	
	NSDate *dateTmp;
	dateTmp = [[self.Notes objectAtIndex:indexPath.row ]objectForKey:@"CDate"];
	cell.detailTextLabel.text = [dateFormat stringFromDate: dateTmp];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

	
	[dateFormat release];
//	[dateTmp release];

	
	
	//cell.text.label = cell.text.label + [[self.Notes objectAtIndex:indexPath.row]objectForKey:@"CreationDate"];
		
    return cell;
}




// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    // Navigation logic may go here -- for example, create and push another view controller.
	
	DetailNoteViewControler *noteDetailViewControler = [[DetailNoteViewControler alloc] initWithNibName:@"DetailNoteViewControler" bundle:nil];
	//[self.navigationController pushViewController:noteDetailViewControler animated:YES];
	
	// this adds a navication bar to the noteDetailViewController
	UINavigationController *addNavCon = [[UINavigationController alloc] initWithRootViewController:noteDetailViewControler];	
	noteDetailViewControler.Notedict = [self.Notes objectAtIndex:indexPath.row];
	noteDetailViewControler.noteArray = self.Notes;
	
	[self presentModalViewController:addNavCon animated:YES];
	
	[addNavCon release];
	[noteDetailViewControler release];
	
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
		// Delete the row from the data source.
		[self.Notes removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
		
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}



/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)createEditableCopyOfDatabaseIfNeeded {
	// First, test for existence - we don't want to wipe out a user's DB
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *documentDirectory = [self applicationDocumentsDirectory];
	NSString *writableDBPath = [documentDirectory stringByAppendingPathComponent:@"NotesList.plist"];
	
	BOOL dbexits = [fileManager fileExistsAtPath:writableDBPath];
	if (!dbexits) {
		// The writable database does not exist, so copy the default to the appropriate location.
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"NotesList.plist"];
		
		NSError *error;
		BOOL success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
		if (!success) {
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
		}
	}
}

- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

-(void) applicationWillTerminate: (NSNotification *)notification {
	NSString *documentDirectory = [self applicationDocumentsDirectory];
	NSString *path = [documentDirectory stringByAppendingPathComponent:@"NotesList.plist"];
	
	[self.Notes writeToFile:path atomically:YES];
}

- (void)dealloc {
	[Notes release];
	[addButtonItem release];
    [super dealloc];
}


@end

