//
//  StringDrawerCommon.h
//  NSStringDrawer
//
//  Created by Kyle Sluder on 11/16/13.
//  Copyright (c) 2013 Kyle Sluder. All rights reserved.
//

#import <TargetConditionals.h>

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#else
#import <Cocoa/Cocoa.h>
#endif

extern void DrawOriginMarkerAtPoint(CGContextRef ctx, CGPoint point);
extern NSDictionary *DefaultAttributesDictionaryWithIndents(id font, CGFloat headIndent, CGFloat firstLineHeadIndent, CGFloat tailIndent);

@interface NSString (StringDrawerCommon)

- (void)stringDrawer_drawWithAttributes:(NSDictionary *)attributes inRect:(CGRect)rect ofContext:(CGContextRef)ctx usingDeviceMetrics:(BOOL)useDeviceMetrics contextIsFlipped:(BOOL)isFlipped;

@end
