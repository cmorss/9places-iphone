//
//  _PlacesAppDelegate.h
//  9Places
//
//  Created by Charlie Morss on 3/25/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TripsViewController;

@interface _PlacesAppDelegate : NSObject {
    UIWindow *window;
    TripsViewController *tripsViewController;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) UIWindow *window;

@end
