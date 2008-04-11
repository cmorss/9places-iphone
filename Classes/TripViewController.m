#import "TripViewController.h"
#import "TripDescriptionTableCell.h"
#import "Trip.h"
#import "Landmark.h"

@interface TripViewController (Private)
- (UITableViewCell *)cellForDescription:(UITableViewCell *)availableCell;
- (UITableViewCell *)cellForTitle:(UITableViewCell *)availableCell;
- (UITableViewCell *)cellForLandmarkAtIndexPath:(NSIndexPath *)indexPath 
												withAvailableCell:(UISimpleTableViewCell *)availableCell;
@end

@implementation TripViewController

- (id)init
{
	if (self = [super init]) {
		// Initialize your view controller.
		self.title = @"Trip";
	}
	return self;
}


- (void)loadView
{
  // Create the main table.
  tableView = [[[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStyleGrouped] autorelease];
	tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
  tableView.delegate = self;
  tableView.dataSource = self;    
  self.view = tableView;
}

- (void)setTrip:(Trip *)aTrip {
  if (aTrip != trip) {
		[trip release];
		trip = aTrip;
		[aTrip retain];
	}
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
	[super dealloc];
}

#pragma mark UITableViewDelegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // one for each property
    return 2;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    switch (section) {
      case 0: return 2; // Title and description
      case 1: return [trip.landmarks count]; // Should be the number of landmarks in the trip
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
        withAvailableCell:(UITableViewCell *)availableCell {

  NSLog(@"%s indexPath row = %d, length = %d, section = %d", _cmd, [indexPath row], [indexPath length], [indexPath section]);

    switch (indexPath.section) {
    	case 0:
				switch ([indexPath row]) {
					case 0: return [self cellForTitle:availableCell];
					case 1: return [self cellForDescription:availableCell];
				}
    	default: return [self cellForLandmarkAtIndexPath:indexPath withAvailableCell:availableCell];
    }
		
		return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
    	case 0:
				switch ([indexPath row]) {
					case 0: return 40.0;
					case 1: return [TripDescriptionTableCell heightForDescription:trip.description];
				}
    	case 1: return 40.0;
    }
		
		return 50;
}

- (UITableViewCell *)cellForTitle:(UITableViewCell *)availableCell {

  	UISimpleTableViewCell *cell = nil;
  	if (availableCell != nil) {
  		// Use the existing cell if it's there
  		cell = (UISimpleTableViewCell *)availableCell;
  	} else {
  		// Since the cell will be sized automatically, we can pass the zero rect for the frame
  		cell = [[[UISimpleTableViewCell alloc] initWithFrame:CGRectZero] autorelease];
  	}
		
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.text = trip.title;
  	return cell;
}

- (UITableViewCell *)cellForDescription:(UITableViewCell *)availableCell {

  	TripDescriptionTableCell *cell = nil;
		
  	if ([availableCell isKindOfClass:[TripDescriptionTableCell class]]) {
  		// Use the existing cell if it's there
  		cell = (TripDescriptionTableCell *)availableCell;
  	} else {
  		// Since the cell will be sized automatically, we can pass the zero rect for the frame
  		cell = [[[TripDescriptionTableCell alloc] initWithFrame:CGRectZero] autorelease];
  	}
		[cell setDescription:trip.description];
  	return cell;
}

- (UITableViewCell *)cellForLandmarkAtIndexPath:(NSIndexPath *)indexPath 
												withAvailableCell:(UISimpleTableViewCell *)availableCell {

  	UISimpleTableViewCell *cell = nil;
  	if (availableCell != nil) {
  		// Use the existing cell if it's there
  		cell = (UISimpleTableViewCell *)availableCell;
  	} else {
  		// Since the cell will be sized automatically, we can pass the zero rect for the frame
  		cell = [[[UISimpleTableViewCell alloc] initWithFrame:CGRectZero] autorelease];
  	}
	  cell.font = [UIFont systemFontOfSize:12];
		
    NSLog(@"%s landmarks count = %d", _cmd, trip.landmarks.count);
    NSLog(@"%s row = %d", _cmd, indexPath.row);
		 
		cell.text = [[trip.landmarks objectAtIndex:1] summaryText];
  	return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // Return the displayed title for the specified section.
    switch (section) {
    	case 0: return @"";
    	case 1: return @"Landmarks";
    }
    return nil;
}

#pragma mark EditableTableViewCellDelegate Methods

@end
