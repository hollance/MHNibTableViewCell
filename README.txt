MHNibTableViewCell

This is a UITableViewCell subclass that makes it easy to load table view cells
from nib files. It works best on OS 4.0 or later because there it just loads
the nib once; on earlier OS versions the nib is loaded for each table view cell.

The demo project shows several examples of using MHNibTableViewCell to make
custom table view cells.

The ImagesCell and ImagesController classes from the "Background Images" demo
are based on Matt Gallagher's EasyCustomTable example but have been completely
rewritten to use nibs. See his original blog post at:
http://cocoawithlove.com/2009/04/easy-custom-uitableview-drawing.html

The DrawingCell, GradientBackgroundTable, GradientCellBackground and RoundRect 
classes from the "Background Drawing" demo are derived from Matt Gallagher's 
TableDesignRevisited example. See his blog post at:
http://cocoawithlove.com/2010/12/uitableview-construction-drawing-and.html

LICENSE

The MHNibTableViewCell source code is copyright 2011 Matthijs Hollemans and is
licensed under the terms of the MIT license.

Portions of this source code are copyright 2009 Matt Gallagher. See the license
headers in the source files for details.

The images in the folder "EasyCustomTable Images" are also copyright 2009 Matt
Gallagher.

Any source files without a license header are considered to be public domain.
