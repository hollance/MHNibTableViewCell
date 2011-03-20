
#import "MenuViewController.h"
#import "DrawingController.h"
#import "ImagesController.h"
#import "SolidColorController.h"

@implementation MenuViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView*)theTableView numberOfRowsInSection:(NSInteger)section
{
	return 6;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
	static NSString* CellIdentifier = @"CellIdentifier";

	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];

	if (indexPath.row == 0)
		cell.textLabel.text = @"Solid Background Color (Plain)";
	else if (indexPath.row == 1)
		cell.textLabel.text = @"Solid Background Color (Grouped)";
	else if (indexPath.row == 2)
		cell.textLabel.text = @"Background Images (Plain)";
	else if (indexPath.row == 3)
		cell.textLabel.text = @"Background Images (Grouped)";
	else if (indexPath.row == 4)
		cell.textLabel.text = @"Background Drawing (Plain)";
	else
		cell.textLabel.text = @"Background Drawing (Grouped)";

	cell.textLabel.font = [UIFont systemFontOfSize:17.0f];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
	UITableViewController* controller = nil;

	if (indexPath.row <= 1)
	{
		UITableViewStyle style = (indexPath.row == 0) ? UITableViewStylePlain : UITableViewStyleGrouped;
		controller = [[SolidColorController alloc] initWithStyle:style];
	}
	else if (indexPath.row <= 3)
	{
		NSString* nibName = (indexPath.row == 2) ? @"ImagesControllerPlain" : @"ImagesControllerGrouped";
		controller = [[ImagesController alloc] initWithNibName:nibName bundle:nil];
	}
	else
	{
		NSString* nibName = (indexPath.row == 4) ? @"DrawingControllerPlain" : @"DrawingControllerGrouped";
		controller = [[DrawingController alloc] initWithNibName:nibName bundle:nil];
	}

	[self.navigationController pushViewController:controller animated:YES];
	[controller release];
}

@end
