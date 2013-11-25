//
//  StringDrawingView.h
//  NSStringDrawer
//
//  Created by Kyle Sluder on 1/25/13.
//  Copyright (c) 2013 Kyle Sluder. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface StringDrawingView : NSView

@property (copy) NSString *stringToDraw;
- (void)setFlipped:(BOOL)flipped;

@property BOOL usesDeviceMetrics;

@property CGFloat headIndent;
@property CGFloat firstLineHeadIndent;
@property CGFloat tailIndent;

@end
