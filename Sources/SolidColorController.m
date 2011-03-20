
#import "SolidColorController.h"
#import "SolidColorCell.h"

@implementation SolidColorController

- (void)viewDidLoad
{
	[super viewDidLoad];

	self.title = @"Solid Color";
	self.navigationItem.rightBarButtonItem = self.editButtonItem;

	self.tableView.backgroundColor = [UIColor colorWithRed:130/255.0f green:140/255.0f blue:80/255.0f alpha:1.0f];

	// Use this to change the color of the rounded border in grouped style.
	self.tableView.separatorColor = [UIColor colorWithRed:90/255.0f green:95/255.0f blue:70/255.0f alpha:1.0f];
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
	return 2;
}

- (NSInteger)tableView:(UITableView*)theTableView numberOfRowsInSection:(NSInteger)section
{
	return (section == 0) ? 5 : 2;
}

- (UITableViewCell*)tableView:(UITableView*)theTableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
	SolidColorCell* cell = [SolidColorCell cellForTable:theTableView withOwner:self];

	// The content view's subviews in the nib are set up to autosize. That is
	// necessary for adding an accessory view or for when the table goes into
	// edit mode.
	
	if (indexPath.row == 0)
		cell.accessoryType = UITableViewCellAccessoryNone;
	else if (indexPath.row == 1)
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	else if (indexPath.row == 2)
		cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;

	// It is possible to add a custom accessory view that you defined in the
	// nib. To handle taps on this accessory view, you will have to implement
	// your own IBAction (see below). Note that the background of this view is
	// made transparent when the cell is selected, so it looks better to make
	// it transparent always.

	else if (indexPath.row == 3)
		cell.accessoryView = cell.customAccessoryView;

	// Setting an image on the standard imageView does not work so well,
	// because the image view is added to the content view and overlaps
	// whatever is in there. It is better to add your own UIImageView to
	// the content view instead.

	else if (indexPath.row == 4)
		cell.imageView.image = [UIImage imageNamed:@"imageA.png"];

	// Adding a custom background view works well with plain style, but not so
	// well with grouped style. The view overlaps the rounded corners. If you
	// want to add your own background view in grouped style, you have to draw
	// the rounded corners yourself.

	if (indexPath.section == 1)
	{
		cell.backgroundView = cell.customBackgroundView;
		cell.selectedBackgroundView = cell.customSelectedBackgroundView;
	}

	return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView*)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath*)indexPath
{
	NSLog(@"Accessory button tapped for %@", indexPath);
}

// This is an alternative method for setting the background color of table 
// view cells, but I prefer to do it in the UITableViewCell subclass.
- (void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
	//cell.backgroundColor = [UIColor redColor];
}

#pragma mark -
#pragma mark Actions

- (NSIndexPath*)indexPathForControl:(UIControl*)control withEvent:(UIEvent*)event
{
	UITouch* touch = [[event touchesForView:control] anyObject];
	CGPoint point = [touch locationInView:self.tableView];
	return [self.tableView indexPathForRowAtPoint:point];
}

// To handle taps on custom accessory views, you need to hook the control's
// UIControlEventTouchUpInside event up to this IBAction. This requires that
// you pass this view controller as the owner when you instantiate the cell.
- (IBAction)accessoryControlTapped:(UIControl*)control withEvent:(UIEvent*)event
{
	NSIndexPath* indexPath = [self indexPathForControl:control withEvent:event];
	if (indexPath != nil)
		[self.tableView.delegate tableView:self.tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
}

@end
