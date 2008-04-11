#import <UIKit/UIKit.h>

#define COLUMN_WIDTH 300
#define LEFT_OFFSET  10
#define TOP_OFFSET   10

@interface TripDescriptionTableCell : UITableViewCell {
	UILabel *descriptionLabel;
}

+ (CGFloat)heightForDescription:(NSString *)aDescription;
- (void)setDescription:(NSString *)aDescription;

@end
