/*!
 * \file MHNibTableViewCell.m
 *
 * Copyright (c) 2011 Matthijs Hollemans
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import "MHNibTableViewCell.h"

static NSMutableDictionary* nibs = nil;

@implementation MHNibTableViewCell

@synthesize groupPosition;

+ (void)initialize
{
	if (self == [MHNibTableViewCell class])
	{
		// If we are on OS 4.0 or later, allocate a dictionary for storing
		// UINib instances. We use the cell identifier as the key.
		Class cls = NSClassFromString(@"UINib");
		if ([cls respondsToSelector:@selector(nibWithNibName:bundle:)])
		{
			nibs = [[NSMutableDictionary dictionaryWithCapacity:10] retain];
		}	
	}
}

+ (void)flushNibCache
{
	[nibs removeAllObjects];
}

+ (NSString*)reuseIdentifier
{
	return NSStringFromClass(self);
}

- (NSString*)reuseIdentifier
{
	return [[self class] reuseIdentifier];
}

+ (NSString*)nibName
{
	return [self reuseIdentifier];
}

+ (id)cellFromNibNamed:(NSString*)nibName withOwner:(id)ownerOrNil identifier:(NSString*)identifier
{
	// Get the UINib instance for this cell identifier from the cache. If not
	// found and we are on OS 4.0 or later, then create a UINib instance and
	// add it to the dictionary.
	UINib* nib = nil;
	if (nibs != nil)
	{
		nib = [nibs objectForKey:identifier];
		if (nib == nil)
		{
			Class cls = NSClassFromString(@"UINib");
			nib = [cls nibWithNibName:nibName bundle:[NSBundle mainBundle]];
			[nibs setObject:nib forKey:identifier];
		}
	}

	// Load the contents of the nib file, either from the in-memory UINib or
	// from the bundle in OS 3.2 and earlier.
	NSArray* contents = nil;
	if (nib != nil)
		contents = [nib instantiateWithOwner:ownerOrNil options:nil];
	else
		contents = [[NSBundle mainBundle] loadNibNamed:nibName owner:ownerOrNil options:nil];

	if (contents != nil)
	{
		// The Table View Programming Guide uses a trick to get a reference to
		// the cell by connecting it to an outlet in the File's Owner. That's a
		// nice trick, but I don't like that it requires you to add a temporary
		// instance variable to the controller, so instead we will simply loop
		// through the nib's contents to find our table view cell.

		for (id item in contents)
		{
			if ([item isKindOfClass:[UITableViewCell class]])
			{
				return [[item retain] autorelease];
			}
		}
	}
	return nil;
}

+ (id)cellWithOwner:(id)ownerOrNil
{
	return [self cellFromNibNamed:[self nibName] withOwner:ownerOrNil identifier:[self reuseIdentifier]];
}

+ (id)cellForTable:(UITableView*)tableView withOwner:(id)ownerOrNil;
{
	NSString* identifier = [self reuseIdentifier];
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if (cell == nil)
		cell = [self cellFromNibNamed:[self nibName] withOwner:ownerOrNil identifier:identifier];
	return cell;
}

- (void)setGroupPosition:(CellGroupPosition)newGroupPosition
{
	if (groupPosition != newGroupPosition)
	{
		groupPosition = newGroupPosition;
		[self groupPositionDidChange];
	}
}

- (void)setGroupPositionForIndexPath:(NSIndexPath*)indexPath inTableView:(UITableView*)tableView
{
	NSInteger sectionRows = [tableView numberOfRowsInSection:indexPath.section];
	NSInteger row = indexPath.row;

	if (row == 0 && sectionRows == 1)
		self.groupPosition = CellGroupPositionTopAndBottom;
	else if (row == 0)
		self.groupPosition = CellGroupPositionTop;
	else if (row == sectionRows - 1)
		self.groupPosition = CellGroupPositionBottom;
	else
		self.groupPosition = CellGroupPositionMiddle;
}

- (void)groupPositionDidChange
{
	// do nothing
}

@end
