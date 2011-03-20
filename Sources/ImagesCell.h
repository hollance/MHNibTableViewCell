
#import "MHNibTableViewCell.h"

/*
 * This table view cell uses images to draw its content and its background.
 *
 * Based on Matt Gallagher's EasyCustomTable example:
 * http://cocoawithlove.com/2009/04/easy-custom-uitableview-drawing.html 
 *
 * These cells pretend to be grouped style but in Matt Gallager's example the
 * table uses plain style. That does not look so good in editing mode because 
 * you would expect the background image to resize but it does not do that in
 * a plain style table. Also, the accessory slides out of the view instead of
 * crossfading. Fortunately, this technique also works in grouped style tables,
 * which looks better if the table requires editing mode.
 */
@interface ImagesCell : MHNibTableViewCell
{
}

@property (nonatomic, retain) IBOutlet UILabel* topLabel;
@property (nonatomic, retain) IBOutlet UILabel* bottomLabel;
@property (nonatomic, retain) IBOutlet UIImageView* customImageView;

@end
