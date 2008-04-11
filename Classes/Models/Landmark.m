#import "Landmark.h"

@implementation Landmark

@synthesize title, description, street, city, state, locationCoordinates, locationAccuracy;

- (id)initWithLocation:(CLLocation *)aLocation {
  if (self = [super init]) {
    self.locationCoordinates = aLocation.coordinate;
		self.locationAccuracy = aLocation.horizontalAccuracy;
  }
  return self;
}

- (id)initWithAddress:(NSString *)aStreet city:(NSString *)aCity state:(NSString *)aState {
  if (self = [super init]) {
    self.street = aStreet;
		self.city = aCity;
		self.state = aState;
  }
  return self;
}

- (NSString *)summaryText {
	return self.street;
}

@end
