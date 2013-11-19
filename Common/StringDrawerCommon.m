//
//  StringDrawerCommon.m
//  NSStringDrawer
//
//  Created by Kyle Sluder on 11/16/13.
//  Copyright (c) 2013 Kyle Sluder. All rights reserved.
//

#import "StringDrawerCommon.h"

#if TARGET_OS_IPHONE
#define COLOR UIColor
#else
#define COLOR NSColor
#endif

void DrawOriginMarkerAtPoint(CGContextRef ctx, CGPoint point)
{
    CGContextSaveGState(ctx);
    CGContextSetBlendMode(ctx, kCGBlendModeNormal);
    
    
    [[COLOR lightGrayColor] setFill];
    
    CGRect yAxis = (CGRect){.origin={0, point.y}, .size=(CGSize){.width=1, .height=10000}};
    CGContextFillRect(ctx, yAxis);
    
    CGRect xAxis = (CGRect){.origin={point.x, 0}, .size=(CGSize){.width=10000, .height=1}};
    CGContextFillRect(ctx, xAxis);
    
    
    CGContextRestoreGState(ctx);
}

static void StrokeRect(CGContextRef ctx, CGRect rect)
{
    rect.origin.x += 0.5f;
    rect.origin.y += 0.5f;
    rect.size.width -= 1;
    rect.size.height -= 1;
    
    CGContextStrokeRect(ctx, rect);
}

NSDictionary *DefaultAttributesDictionaryWithIndents(id font, CGFloat headIndent, CGFloat firstLineHeadIndent, CGFloat tailIndent)
{
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.headIndent = headIndent;
    style.firstLineHeadIndent = firstLineHeadIndent;
    style.tailIndent = tailIndent;
    
    NSDictionary *attributes = @{NSFontAttributeName : font, NSParagraphStyleAttributeName : style};
    return attributes;
}

@implementation NSString (StringDrawerCommon)

- (CGRect)stringDrawer_boundingRectWithSize:(CGSize)size options:(NSStringDrawingOptions)options attributes:(NSDictionary *)attributes;
{
#if TARGET_OS_IPHONE
    return [self boundingRectWithSize:size options:options attributes:attributes context:nil];
#else
    return [self boundingRectWithSize:size options:options attributes:attributes];
#endif
}

- (void)stringDrawer_drawWithRect:(CGRect)rect options:(NSStringDrawingOptions)options attributes:(NSDictionary *)attributes;
{
#if TARGET_OS_IPHONE
    [self drawWithRect:rect options:options attributes:attributes context:nil];
#else
    [self drawWithRect:rect options:options attributes:attributes];
#endif
}

#pragma mark -

- (void)stringDrawer_drawWithAttributes:(NSDictionary *)attributes inRect:(CGRect)rect ofContext:(CGContextRef)ctx usingDeviceMetrics:(BOOL)useDeviceMetrics contextIsFlipped:(BOOL)contextIsFlipped;
{
    CGContextSaveGState(ctx);
    CGContextSetBlendMode(ctx, kCGBlendModeNormal);
    
    
    [[COLOR blueColor] setStroke];
    StrokeRect(ctx, rect);
    
    
    NSStringDrawingOptions options = 0;
    if (useDeviceMetrics)
        options |= NSStringDrawingUsesDeviceMetrics;
    
    {
        CGRect lineFragmentRect = [self stringDrawer_boundingRectWithSize:rect.size options:(options | NSStringDrawingUsesLineFragmentOrigin) attributes:attributes];
        
        [[[COLOR redColor] colorWithAlphaComponent:0.5f] setFill];
        CGContextFillRect(ctx, lineFragmentRect);
        
        if (contextIsFlipped) {
            [[[COLOR orangeColor] colorWithAlphaComponent:0.5f] setFill];
            lineFragmentRect.origin.y = -lineFragmentRect.origin.y;
            lineFragmentRect.origin.y -= lineFragmentRect.size.height;
            CGContextFillRect(ctx, lineFragmentRect);
        }
    }
    
    {
        CGRect baselineRect = [self stringDrawer_boundingRectWithSize:rect.size options:options attributes:attributes];
        
        [[[COLOR greenColor] colorWithAlphaComponent:0.5f] setFill];
        CGContextFillRect(ctx, baselineRect);
        
        if (contextIsFlipped) {
            [[[COLOR blueColor] colorWithAlphaComponent:0.5f] setFill];
            baselineRect.origin.y = -baselineRect.origin.y;
            baselineRect.origin.y -= baselineRect.size.height;
            CGContextFillRect(ctx, baselineRect);
        }
    }
    
    NSMutableDictionary *mutableAttributes = [attributes mutableCopy];
    
    [mutableAttributes setObject:[COLOR greenColor] forKey:NSForegroundColorAttributeName];
    [self stringDrawer_drawWithRect:rect options:options attributes:attributes];
    
    [mutableAttributes setObject:[COLOR redColor] forKey:NSForegroundColorAttributeName];
    [self stringDrawer_drawWithRect:rect options:(options | NSStringDrawingUsesLineFragmentOrigin) attributes:attributes];

    
    CGContextRestoreGState(ctx);
}

@end
