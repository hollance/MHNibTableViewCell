
#import "MHNibTableViewCell.h"

/*
 * This table view cell just has a solid color background. It works well with
 * plain and grouped table styles.
 *
 * Setting a background color in the nib has no effect. Instead, you should 
 * override -layoutSubviews and set the color manually. You could also add a
 * colored UIView to the contentView or set a backgroundView on the cell, but
 * that only works well with the plain table style. Doing so in grouped style
 * will overlap the rounded corners.
 *
 * You can set the color and style of the border on the table view.
 *
 * When you design the nib, be sure to set the views to autosize because the
 * content view will be resized when the table is set to editing mode or when
 * an accessory is added.
 */
@interface SolidColorCell : MHNibTableViewCell
{
}

@property (nonatomic, retain) IBOutlet UIView* customAccessoryView;
@property (nonatomic, retain) IBOutlet UIImageView* customBackgroundView;
@property (nonatomic, retain) IBOutlet UIImageView* customSelectedBackgroundView;

@end
