#import "TripDescriptionTableCell.h"

@implementation TripDescriptionTableCell


+ (CGFloat)heightForDescription:(NSString *)aDescription {
	UIFont  *font = [UIFont systemFontOfSize:13];
	
	CGSize newSize = CGSizeMake(280.0f, 500.0f);
	
  CGSize size = [aDescription sizeWithFont:font 
		constrainedToSize:newSize lineBreakMode:UILineBreakModeWordWrap];
																	
	return size.height + TOP_OFFSET * 2;
}


- (id)initWithFrame:(CGRect)aRect {
	
	if (self = [super initWithFrame:aRect]) {
		self.selectionStyle = UITableViewCellSelectionStyleNone;

		descriptionLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		descriptionLabel.backgroundColor = [UIColor whiteColor];
		descriptionLabel.opaque = YES;
		descriptionLabel.textColor = [UIColor darkGrayColor];
		descriptionLabel.highlightedTextColor = [UIColor lightGrayColor];
		descriptionLabel.font = [UIFont systemFontOfSize:13];
					
		descriptionLabel.textAlignment = UITextAlignmentLeft; // default
		descriptionLabel.numberOfLines = 10;
		descriptionLabel.lineBreakMode = UILineBreakModeWordWrap;
		[self addSubview:descriptionLabel];
		
		// CHM: why is this being done (the sample does it). We need it 
		//      later in layout subviews and setDescription
		[descriptionLabel release];		
	}
	return self;
}


- (void)layoutSubviews {

    [super layoutSubviews];
    CGRect contentRect = [self contentRectForBounds:self.bounds];
	
	  // In this example we will never be editing, but this illustrates the appropriate pattern
    if (!self.editing) {
			CGFloat boundsX = contentRect.origin.x;
			CGRect frame;

			frame = CGRectMake(boundsX + LEFT_OFFSET, TOP_OFFSET, 
									COLUMN_WIDTH - (2 * LEFT_OFFSET), contentRect.size.height - (TOP_OFFSET * 2));
			descriptionLabel.frame = frame;
   }
}

- (void)setDescription:(NSString *)aDescription {
	descriptionLabel.text = aDescription;
}

@end
