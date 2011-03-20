
#import "ImagesController.h"
#import "ImagesCell.h"

@implementation ImagesController

@synthesize tableView;

- (void)dealloc
{
	[tableView release];
	[super dealloc];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = @"Images";
	self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
	[super setEditing:editing animated:animated];
	[self.tableView setEditing:editing animated:animated];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView*)theTableView numberOfRowsInSection:(NSInteger)section
{
	return 30;
}

- (UITableViewCell*)tableView:(UITableView*)theTableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
	ImagesCell* cell = [ImagesCell cellForTable:theTableView withOwner:nil];
	[cell setGroupPositionForIndexPath:indexPath inTableView:theTableView];

	cell.topLabel.text = [NSString stringWithFormat:@"Cell at row %ld.", indexPath.row];
	cell.bottomLabel.text = [NSString stringWithFormat:@"Some other information.", indexPath.row];

	if (indexPath.row % 3 == 0)
		cell.customImageView.image = [UIImage imageNamed:@"imageA.png"];
	else if (indexPath.row % 3 == 1)
		cell.customImageView.image = [UIImage imageNamed:@"imageB.png"];
	else
		cell.customImageView.image = [UIImage imageNamed:@"imageC.png"];

	return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView*)theTableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
	[theTableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
