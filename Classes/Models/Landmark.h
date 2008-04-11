#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface Landmark : NSObject {
	NSString *title;
	NSString *description;
	
	CLLocationCoordinate2D locationCoordinates;
	CLLocationAccuracy locationAccuracy;
	NSDate *timestamp;
	
	NSString *street;
	NSString *city;
	NSString *state;
}

- (id)initWithLocation:(CLLocation *)aLocation;
- (id)initWithAddress:(NSString *)aStreet city:(NSString *)aCity state:(NSString *)aState;

- (NSString *)summaryText;

@property (copy, nonatomic) NSString *title, *description, *street, *city, *state;
@property CLLocationCoordinate2D locationCoordinates;
@property CLLocationAccuracy locationAccuracy;

@end
