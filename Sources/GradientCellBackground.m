//
//  Based on Matt Gallagher's TableDesignRevisited project from:
//  http://cocoawithlove.com/2010/12/uitableview-construction-drawing-and.html
//
//  Created by Matt Gallagher on 27/04/09.
//  Copyright 2009 Matt Gallagher. All rights reserved.
//
//  This software is provided 'as-is', without any express or implied
//  warranty. In no event will the authors be held liable for any damages
//  arising from the use of this software. Permission is granted to anyone to
//  use this software for any purpose, including commercial applications, and to
//  alter it and redistribute it freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//     claim that you wrote the original software. If you use this software
//     in a product, an acknowledgment in the product documentation would be
//     appreciated but is not required.
//  2. Altered source versions must be plainly marked as such, and must not be
//     misrepresented as being the original software.
//  3. This notice may not be removed or altered from any source
//     distribution.
//

#import <QuartzCore/QuartzCore.h>
#import "GradientCellBackground.h"
#import "RoundRect.h"

CGGradientRef MakeGradient(UIColor* colorTop, UIColor* colorBottom)
{
	CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();

	CGFloat components[3][4];
	memcpy(components[0], CGColorGetComponents(colorTop.CGColor), sizeof(CGFloat) * 4);
	memcpy(components[1], CGColorGetComponents(colorTop.CGColor), sizeof(CGFloat) * 4);
	memcpy(components[2], CGColorGetComponents(colorBottom.CGColor), sizeof(CGFloat) * 4);

	const CGFloat endpoints[3] = {0.0, 0.35, 1.0};

	CGGradientRef gradient = CGGradientCreateWithColorComponents(
		colorspace, (const CGFloat*)components, endpoints, 3);

	CFRelease(colorspace);

	return gradient;
}

CGGradientRef BackgroundGradient()
{
	static CGGradientRef backgroundGradient = NULL;
	
	if (backgroundGradient == NULL)
	{
		backgroundGradient = MakeGradient(
			[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0],
			[UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1.0]);
	}
	
	return backgroundGradient;
}

CGGradientRef SelectedBackgroundGradient()
{
	static CGGradientRef selectedBackgroundGradient = NULL;
	
	if (selectedBackgroundGradient == NULL)
	{
		selectedBackgroundGradient = MakeGradient(
			[UIColor colorWithRed:0.70 green:0.82 blue:0.0 alpha:1.0],
			[UIColor colorWithRed:0.95 green:0.90 blue:0.0 alpha:1.0]);
	}
	
	return selectedBackgroundGradient;
}

@implementation GradientCellBackground

@synthesize selected, tableStyle, groupPosition, strokeColor;

- (id)initWithCoder:(NSCoder*)aDecoder
{
	if ((self = [super initWithCoder:aDecoder]))
	{
		self.strokeColor = [UIColor lightGrayColor];
		self.backgroundColor = [UIColor clearColor];
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	}
	return self;
}

- (void)dealloc
{
	[strokeColor release];
	[super dealloc];
}

- (void)layoutSubviews
{
	// On rotation/resize/rescale, we need to redraw.
	[super layoutSubviews];
	[self setNeedsDisplay];
}

- (void)setGroupPosition:(CellGroupPosition)newGroupPosition
{
	if (groupPosition != newGroupPosition)
	{
		groupPosition = newGroupPosition;
		[self setNeedsDisplay];
	}
}

- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();

	const CGFloat CellBackgroundRadius = 10.0;
	if (tableStyle == UITableViewStyleGrouped)
	{
		if (groupPosition != CellGroupPositionTop &&
			groupPosition != CellGroupPositionTopAndBottom)
		{
			rect.origin.y -= CellBackgroundRadius;
			rect.size.height += CellBackgroundRadius;
		}

		if (groupPosition != CellGroupPositionBottom &&
		    groupPosition != CellGroupPositionTopAndBottom)
		{
			rect.size.height += CellBackgroundRadius;
		}
	}

	rect = CGRectInset(rect, 0.5, 0.5);

	CGPathRef roundRectPath;
	if (tableStyle == UITableViewStyleGrouped)
	{
		roundRectPath = NewPathWithRoundRect(rect, CellBackgroundRadius);

		CGContextSaveGState(context);
		CGContextAddPath(context, roundRectPath);
		CGContextClip(context);
	}

	CGFloat visibleWidth = rect.size.width;
	CGContextDrawLinearGradient(
		context,
		selected ? SelectedBackgroundGradient() : BackgroundGradient(),
		CGPointMake(0.25 * visibleWidth, -0.25 * visibleWidth),
		CGPointMake(rect.size.width - 0.25 * visibleWidth, rect.size.height + 0.25 * visibleWidth),
		0);

	if (tableStyle == UITableViewStyleGrouped)
	{
		CGContextRestoreGState(context);

		CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
		CGContextAddPath(context, roundRectPath);
		CGContextSetLineWidth(context, 1.0);
		CGContextStrokePath(context);

		CGPathRelease(roundRectPath);

		if (groupPosition != CellGroupPositionTop && 
		    groupPosition != CellGroupPositionTopAndBottom)
		{
			rect.origin.y += CellBackgroundRadius;
			rect.size.height -= CellBackgroundRadius;

			CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
			CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y);
			CGContextStrokePath(context);
		}
	}
	else
	{
		CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);
		CGContextSetLineWidth(context, 1.0);
		CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + rect.size.height);
		CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
		CGContextStrokePath(context);
	}
}

@end
