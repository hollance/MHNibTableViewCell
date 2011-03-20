
#import "MHNibTableViewCell.h"

/*
 * This table view cell uses a background view that does its own drawing.
 *
 * Based on Matt Gallagher's TableDesignRevisited example:
 * http://cocoawithlove.com/2010/12/uitableview-construction-drawing-and.html
 *
 * This is the most flexible approach: the GradientCellBackground view can draw
 * itself properly for tables in plain style or grouped style, in editing mode,
 * and in both portrait and landscape orientation.
 */
@interface DrawingCell : MHNibTableViewCell
{
}

@property (nonatomic, retain) IBOutlet UIView* customAccessoryView;
@property (nonatomic, assign) UITableViewStyle tableStyle;

@end
