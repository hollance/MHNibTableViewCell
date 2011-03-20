
#import "DrawingCell.h"
#import "GradientCellBackground.h"

@implementation DrawingCell

@synthesize customAccessoryView, tableStyle;

- (void)awakeFromNib
{
	[super awakeFromNib];
	((GradientCellBackground*)self.selectedBackgroundView).selected = YES;
}

- (void)dealloc
{
	[customAccessoryView release];
	[super dealloc];
}

- (void)groupPositionDidChange
{
	((GradientCellBackground*)self.backgroundView).groupPosition = self.groupPosition;
	((GradientCellBackground*)self.selectedBackgroundView).groupPosition = self.groupPosition;
}

- (void)setTableStyle:(UITableViewStyle)newTableStyle
{
	if (tableStyle != newTableStyle)
	{
		tableStyle = newTableStyle;
		((GradientCellBackground*)self.backgroundView).tableStyle = newTableStyle;
		((GradientCellBackground*)self.selectedBackgroundView).tableStyle = newTableStyle;
	}
}

@end
