
/*
 * Demo for the ImagesCell table view cells.
 *
 * This is a regular view controller, not a UITableViewController, because we
 * want to show an image view behind the table view. On OS 3.2 or up, you can
 * use tableView.backgroundView instead.
 */
@interface ImagesController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
}

@property (nonatomic, retain) IBOutlet UITableView* tableView;

@end
