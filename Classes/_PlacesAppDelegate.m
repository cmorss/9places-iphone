#import "_PlacesAppDelegate.h"
#import "TripsViewController.h"
#import "Database.h"

@implementation _PlacesAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(UIApplication *)application {	

	[Database remigrate];
	
	// Create window
	self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
  
  tripsViewController = [[TripsViewController alloc] init];
  
  // Create a navigation controller using the new controller
  navigationController = [[UINavigationController alloc] initWithRootViewController:tripsViewController];

  // Add the navigation controller's view to the window
  [window addSubview:[navigationController view]];

	// Show window
  [window makeKeyAndVisible];
}

- (void)dealloc {
	[tripsViewController release];
	[navigationController release];
	[window release];
	[super dealloc];
}

@end
