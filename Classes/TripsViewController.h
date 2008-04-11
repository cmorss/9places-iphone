#import <UIKit/UIKit.h>

@class TripViewController;

@interface TripsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
  TripViewController *tripViewController;
  UIButton *addButton;
  UITableView *tableView;
}

@end
