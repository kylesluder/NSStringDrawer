//
//  StringDrawingView.m
//  NSStringDrawer
//
//  Created by Kyle Sluder on 11/16/13.
//  Copyright (c) 2013 Kyle Sluder. All rights reserved.
//

#import "StringDrawingView.h"
#import "StringDrawerCommon.h"

@implementation StringDrawingView

- (id)initWithFrame:(CGRect)frame;
{
    if (!(self = [super initWithFrame:frame]))
        return nil;
    
    _stringToDraw = @"hello,\nworld";
    
    self.contentMode = UIViewContentModeRedraw;
    
    CGRect bounds = self.bounds;
    bounds.origin = CGPointMake(-60, -60);
    self.bounds = bounds;
    
    return self;
}

- (void)drawRect:(CGRect)rect;
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [[UIColor whiteColor] setFill];
    CGContextFillRect(ctx, rect);
    
    DrawOriginMarkerAtPoint(ctx, self.bounds.origin);
    
    CGRect textRect = (CGRect){.size=CGRectInset(self.bounds, 60, 60).size, .origin=CGPointZero};
    NSDictionary *attributes = DefaultAttributesDictionaryWithIndents([UIFont fontWithName:@"Helvetica" size:24], 0, 0, 0);
    [_stringToDraw stringDrawer_drawWithAttributes:attributes inRect:textRect ofContext:ctx usingDeviceMetrics:_usesDeviceMetrics contextIsFlipped:NO];
}

@synthesize usesDeviceMetrics=_usesDeviceMetrics;
- (BOOL)usesDeviceMetrics;
{
    return _usesDeviceMetrics;
}

- (void)setUsesDeviceMetrics:(BOOL)flag;
{
    _usesDeviceMetrics = flag;
    [self setNeedsDisplay];
}

@end
