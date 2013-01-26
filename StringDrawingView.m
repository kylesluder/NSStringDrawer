//
//  StringDrawingView.m
//  NSStringDrawer
//
//  Created by Kyle Sluder on 1/25/13.
//  Copyright (c) 2013 Kyle Sluder. All rights reserved.
//

#import "StringDrawingView.h"

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
    [stringToDraw retain];
    [_stringToDraw release];
    _stringToDraw = stringToDraw;
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
    [[NSColor whiteColor] setFill];
    NSRectFill(dirtyRect);
    
    NSRect yAxis = (NSRect){.origin={-0.5, self.bounds.origin.y - 0.5}, .size=(NSSize){.width=1, .height=self.bounds.size.height}};
    [[NSColor lightGrayColor] setFill];
    NSRectFill(yAxis);
    
    NSRect xAxis = (NSRect){.origin={self.bounds.origin.x - 0.5, -0.5}, .size=(NSSize){.width=self.bounds.size.width, .height=1}};
    NSRectFill(xAxis);
    
    NSRect textRect = (NSRect){.size=self.bounds.size, .origin=NSZeroPoint};
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.headIndent = _headIndent;
    style.firstLineHeadIndent = _firstLineHeadIndent;
    style.tailIndent = _tailIndent;
    NSMutableDictionary *attributes = [@{NSFontAttributeName : [NSFont fontWithName:@"Helvetica" size:24], NSParagraphStyleAttributeName : style} mutableCopy];
    [style release];
        
    NSStringDrawingOptions options = 0;
    if (_usesDeviceMetrics)
        options |= NSStringDrawingUsesDeviceMetrics;
    
    {
        NSRect lineFragmentRect = [_stringToDraw boundingRectWithSize:textRect.size options:(options | NSStringDrawingUsesLineFragmentOrigin) attributes:attributes];
        [[[NSColor redColor] colorWithAlphaComponent:0.5f] setFill];
        
        [NSBezierPath fillRect:lineFragmentRect];
        
        if ([[NSGraphicsContext currentContext] isFlipped]) {
            [[[NSColor orangeColor] colorWithAlphaComponent:0.5f] setFill];
            lineFragmentRect.origin.y = -lineFragmentRect.origin.y;
            lineFragmentRect.origin.y -= lineFragmentRect.size.height;
            [NSBezierPath fillRect:lineFragmentRect];
        }
    }
    
    {
        NSRect baselineRect = [_stringToDraw boundingRectWithSize:textRect.size options:options attributes:attributes];
        [[[NSColor greenColor] colorWithAlphaComponent:0.5f] setFill];
        
        [NSBezierPath fillRect:baselineRect];
        
        if ([[NSGraphicsContext currentContext] isFlipped]) {
            [[[NSColor blueColor] colorWithAlphaComponent:0.5f] setFill];
            baselineRect.origin.y = -baselineRect.origin.y;
            baselineRect.origin.y -= baselineRect.size.height;
            [NSBezierPath fillRect:baselineRect];
        }
    }
    
    [attributes setObject:[NSColor greenColor] forKey:NSForegroundColorAttributeName];
    [_stringToDraw drawWithRect:textRect options:options attributes:attributes];
    
    [attributes setObject:[NSColor redColor] forKey:NSForegroundColorAttributeName];
    [_stringToDraw drawWithRect:textRect options:(options | NSStringDrawingUsesLineFragmentOrigin) attributes:attributes];
    
    [attributes release];
}

@end
