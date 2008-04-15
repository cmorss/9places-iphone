#import "TripsViewController.h"
#import "TripViewController.h"
#import "Trip.h"

// Private interface for AppDelegate - internal only methods.
@interface TripsViewController (Private)
- (void)inspectTrip:(Trip *)aTrip;
@end

@implementation TripsViewController

- (id)init {
	if (self = [super init]) {
		// Initialize your view controller.
		self.title = @"Your Trips";
	}
	return self;
}

- (void)loadView {
  // Create an add button to display in the top right corner.
  addButton = [[UIButton buttonWithType:UIButtonTypeNavigation] retain];
  [addButton setImage:[UIImage imageNamed:@"plus.png"] forStates:(UIControlStateNormal & UIControlStateHighlighted)];
  [addButton addTarget:self action:@selector(addTrip) forControlEvents:UIControlEventTouchUpInside];
  self.navigationItem.customRightView = addButton;

  // Create the main table.
  tableView = [[[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain] autorelease];
  tableView.delegate = self;
  tableView.dataSource = self;    
  self.view = tableView;
}

// Update the table before the view displays.
- (void)viewWillAppear:(BOOL)animated {
    [tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview.
	// Release anything that's not essential, such as cached data.
}

- (void)dealloc
{
	// Release allocated resources.
  tableView.dataSource = nil;
  tableView.delegate = nil;
  [tripViewController release];
	[super dealloc];
}

- (void)addTrip {
}

- (void)inspectTrip:(Trip *)aTrip {
	// Create the detail view lazily
	if (tripViewController == nil) {
			tripViewController = [[TripViewController alloc] init];
	}
	
	// Set the detail controller's inspected item to the currently-selected book.
	[tripViewController setTrip:aTrip];
	
	// "Push" the detail view on to the navigation controller's stack.
	[self.navigationController pushViewController:tripViewController animated:YES];  
}

#pragma mark UITableViewDataSource Methods

// This table will always only have one section.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tv {
    return 1;
}

// One row per book, the number of books is the number of rows.
- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
	return [[Trip getTrips] count];
}

// The accessory type is the image displayed on the far right of each table cell. In order for the delegate method
// tableView:accessoryButtonClickedForRowWithIndexPath: to be called, you must return the "Detail Disclosure Button" type.
- (UITableViewCellAccessoryType)tableView:(UITableView *)tv accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellAccessoryDisclosureIndicator;
}

// the user selected a row in the table.
- (void)tableView:(UITableView *)tv selectionDidChangeToIndexPath:(NSIndexPath *)newIndexPath
	fromIndexPath:(NSIndexPath *)oldIndexPath {
	
	[tableView deselectRowAtIndexPath:oldIndexPath animated:YES];

	NSArray *trips = [Trip getTrips];
	//NSLog(@"%s indexPath.row = %d, section = %d", _cmd, indexPath.row, indexPath.section);
  Trip *trip = [trips objectAtIndex:newIndexPath.row];
  [self inspectTrip:trip];
//  return indexPath;
}

#pragma mark UISimpleTableViewCell Method

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
	if (cell == nil) {
			// Create a new cell. CGRectZero allows the cell to determine the appropriate size.
			cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"MyIdentifier"] autorelease];
	}

	Trip *aTrip = [[Trip getTrips] objectAtIndex:indexPath.row];
  //NSLog(@"%s indexPath row = %d, length = %d, section = %d", _cmd, [indexPath row], [indexPath length], [indexPath section]);
  cell.text = aTrip.title;
  return cell;
}

@end
