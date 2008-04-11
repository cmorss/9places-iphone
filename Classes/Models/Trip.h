#import <UIKit/UIKit.h>
#import "Landmark.h"
#import "/usr/include/sqlite3.h"

@interface Trip : NSObject {
  NSInteger primaryKey;
  NSString *title;
	NSString *description;
	NSMutableArray *landmarks;
	BOOL dirty;
}

+ (NSMutableArray *)getTrips;

- (id)initWithTitle:(NSString *)aTitle description:(NSString *)aDescription;
- (id)initWithPrimaryKey:(NSInteger)pk title:(NSString *)aTitle description:(NSString *) aDescription;

- (void)addLandmark:(Landmark *)aLandmark;
- (void)saveOrUpdate:(sqlite3 *)database;

@property (copy, nonatomic) NSString *title, *description;
@property (readonly) NSMutableArray *landmarks;
@end
