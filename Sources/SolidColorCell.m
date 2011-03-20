
#import "SolidColorCell.h"

@implementation SolidColorCell

@synthesize customAccessoryView, customBackgroundView, customSelectedBackgroundView;

- (void)dealloc
{
	[customAccessoryView release];
	[customBackgroundView release];
	[customSelectedBackgroundView release];
	[super dealloc];
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	self.backgroundColor = [UIColor colorWithRed:1.0f green:250/255.0f blue:200/255.0f alpha:1.0f];
}

@end
