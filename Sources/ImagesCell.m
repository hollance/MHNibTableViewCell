
#import "ImagesCell.h"

@implementation ImagesCell

@synthesize topLabel, bottomLabel, customImageView;

- (void)dealloc
{
	[topLabel release];
	[bottomLabel release];
	[customImageView release];
	[super dealloc];
}

- (void)groupPositionDidChange
{
	UIImage* backgroundImage = nil;
	UIImage* selectedBackgroundImage = nil;

	switch (self.groupPosition)
	{
		case CellGroupPositionUnknown:
			break;
		case CellGroupPositionTop:
			backgroundImage = [UIImage imageNamed:@"topRow.png"];
			selectedBackgroundImage = [UIImage imageNamed:@"topRowSelected.png"];
			break;
		case CellGroupPositionBottom:
			backgroundImage = [UIImage imageNamed:@"bottomRow.png"];
			selectedBackgroundImage = [UIImage imageNamed:@"bottomRowSelected.png"];
			break;
		case CellGroupPositionMiddle:
			backgroundImage = [UIImage imageNamed:@"middleRow.png"];
			selectedBackgroundImage = [UIImage imageNamed:@"middleRowSelected.png"];
			break;
		case CellGroupPositionTopAndBottom:
			backgroundImage = [UIImage imageNamed:@"topAndBottomRow.png"];
			selectedBackgroundImage = [UIImage imageNamed:@"topAndBottomRowSelected.png"];
			break;
	}

	((UIImageView*)self.backgroundView).image = backgroundImage;
	((UIImageView*)self.selectedBackgroundView).image = selectedBackgroundImage;
}

@end
