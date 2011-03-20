/*!
 * \file MHNibTableViewCell.h
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

#import <UIKit/UIKit.h>

/*!
 * Possible values for MHNibTableViewCell's groupPosition property.
 */
typedef enum
{
	CellGroupPositionUnknown = 0,
	CellGroupPositionTop,
	CellGroupPositionBottom,
	CellGroupPositionMiddle,
	CellGroupPositionTopAndBottom,
}
CellGroupPosition;

/*!
 * MHNibTableViewCell is a UITableViewCell subclass that makes it easy to load
 * table view cells from nib files.
 *
 * To use this class:
 *
 * 1) Create a subclass of MHNibTableViewCell. Add IBOutlets for any subviews
 *    that you want to reference from the code. Also add any IBActions that you
 *    want the cell itself to handle.
 *
 * 2) Create an empty NIB and add a single Table View Cell. You do not have to
 *    set its cell identifier; the name of your subclass will be used for this. 
 *    You do have to set the cell's class to the name of your subclass.
 *
 * 3) Design the user interface and connect any outlets. If you wish to set a
 *    custom background view or accessory view on the cell, then add these as
 *    separate UIView objects to the root of the nib and connect them to the
 *    cell's outlets. Do not add these items as subviews of the cell!
 *
 * 4) If you want your view controller to handle any IBActions, then set it as
 *    the File's Owner and connect the actions.
 *
 * 5) In your data source, instantiate the cell using +cellForTable:withOwner:.
 *    If you set File's Owner in the nib, then don't forget to pass the view
 *    controller along in the "owner" parameter.
 */
@interface MHNibTableViewCell : UITableViewCell
{
}

/*!
 * Determines whether the cell is at the top, bottom or middle of the section 
 * that it belongs to. You can either set groupPosition directly or use the
 * -setGroupPositionForIndexPath:inTableView: helper method for this.
 */
@property (nonatomic, assign) CellGroupPosition groupPosition;

/*!
 * By default, we load the nib with the same name as the class. Subclasses can
 * override this to return the name of an alternate nib file.
 */
+ (NSString*)nibName;

/*!
 * Returns a new table view cell by loading it from a nib file.
 *
 * \note The main reason to use this method is to load a temporary cell to 
 * determine the row height for the table. In most other cases, you will want
 * to use +cellForTable:withOwner:.
 *
 * @param ownerOrNil The File's Owner that is set in the nib file, or nil.
 */
+ (id)cellWithOwner:(id)ownerOrNil;

/*!
 * Returns a new table view cell, reusing a queued cell if possible.
 *
 * @param tableView The UITableView this cell will be added to.
 * @param ownerOrNil The File's Owner that is set in the nib file, or nil.
 */
+ (id)cellForTable:(UITableView*)tableView withOwner:(id)ownerOrNil;

/*!
 * Releases any cached UINib objects.
 *
 * On OS 4.0 or later, this class uses UINib to cache the nib files in memory. 
 * You should call +flushNibCache when you receive a memory warning, although
 * the cached UINib objects already free up memory under low-memory conditions
 * so it isn't strictly necessary.
 */
+ (void)flushNibCache;

/*!
 * Sets the cell's group position based on an index-path in a table.
 */
- (void)setGroupPositionForIndexPath:(NSIndexPath*)indexPath inTableView:(UITableView*)tableView;

/*!
 * Invoked when the cell's group position changed. Subclasses can use this to
 * change the cell's background image, for example. The default implementation
 * does nothing.
 */
- (void)groupPositionDidChange;

@end
