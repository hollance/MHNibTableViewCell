
#import "DrawingController.h"
#import "DrawingCell.h"

@implementation DrawingController

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = @"Drawing";
	self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView*)theTableView numberOfRowsInSection:(NSInteger)section
{
	return 4;
}

- (UITableViewCell*)tableView:(UITableView*)theTableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
	DrawingCell* cell = [DrawingCell cellForTable:theTableView withOwner:self];
	cell.tableStyle = self.tableView.style;
	[cell setGroupPositionForIndexPath:indexPath inTableView:theTableView];

	if (indexPath.row == 0)
		cell.accessoryType = UITableViewCellAccessoryNone;
	else if (indexPath.row == 1)
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	else if (indexPath.row == 2)
		cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
	else if (indexPath.row == 3)
		cell.accessoryView = cell.customAccessoryView;

	return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
