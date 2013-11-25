//
//  StringDrawingView.m
//  NSStringDrawer
//
//  Created by Kyle Sluder on 1/25/13.
//  Copyright (c) 2013 Kyle Sluder. All rights reserved.
//

#import "StringDrawingView.h"
#import "StringDrawerCommon.h"

@implementation StringDrawingView
{
    BOOL _flipped;
    NSString *_stringToDraw;
    BOOL _usesDeviceMetrics;
    CGFloat _headIndent, _firstLineHeadIndent, _tailIndent;
}

- (id)initWithFrame:(NSRect)frameRect;
{
    if (!([super initWithFrame:frameRect]))
        return nil;
    
    _stringToDraw = @"hello\nworld";
    
    [self setBoundsOrigin:NSMakePoint(-40, -40)];
    
    return self;
}

- (void)setFrameSize:(NSSize)newSize;
{
    [super setFrameSize:newSize];
    [self setNeedsDisplay:YES];
}

- (BOOL)isFlipped;
{
    return _flipped;
}

- (void)setFlipped:(BOOL)yn;
{
    _flipped = yn;
    [self setNeedsDisplay:YES];
}

- (NSString *)stringToDraw;
{
    return _stringToDraw;
}

- (void)setStringToDraw:(NSString *)stringToDraw;
{
    _stringToDraw = [stringToDraw copy];
    [self setNeedsDisplay:YES];
}

- (BOOL)usesDeviceMetrics;
{
    return _usesDeviceMetrics;
}

- (void)setUsesDeviceMetrics:(BOOL)yn;
{
    _usesDeviceMetrics = yn;
    [self setNeedsDisplay:YES];
}

- (CGFloat)headIndent;
{
    return _headIndent;
}

- (void)setHeadIndent:(CGFloat)val;
{
    _headIndent = val;
    [self setNeedsDisplay:YES];
}

- (CGFloat)firstLineHeadIndent;
{
    return _firstLineHeadIndent;
}

- (void)setFirstLineHeadIndent:(CGFloat)val;
{
    _firstLineHeadIndent = val;
    [self setNeedsDisplay:YES];
}

- (CGFloat)tailIndent;
{
    return _tailIndent;
}

- (void)setTailIndent:(CGFloat)val;
{
    _tailIndent = val;
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect
{
    CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
    
    [[NSColor whiteColor] setFill];
    NSRectFill(dirtyRect);
    
    DrawOriginMarkerAtPoint(ctx, self.bounds.origin);
    
    NSRect textRect = (NSRect){.size=NSInsetRect(self.bounds, 40, 40).size, .origin=NSZeroPoint};
    NSDictionary *attributes = DefaultAttributesDictionaryWithIndents([NSFont fontWithName:@"Helvetica" size:24], _headIndent, _firstLineHeadIndent, _tailIndent);
    [_stringToDraw stringDrawer_drawWithAttributes:attributes inRect:textRect ofContext:ctx usingDeviceMetrics:_usesDeviceMetrics contextIsFlipped:[[NSGraphicsContext currentContext] isFlipped]];
}

@end
