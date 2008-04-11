#import <UIKit/UIKit.h>

@class Trip, TableViewTextView;

@interface TripViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
  Trip *trip;
  UITableView *tableView;
}

- (void)setTrip:(Trip *)aTrip;
@end
