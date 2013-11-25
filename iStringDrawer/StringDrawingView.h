//
//  StringDrawingView.h
//  NSStringDrawer
//
//  Created by Kyle Sluder on 11/16/13.
//  Copyright (c) 2013 Kyle Sluder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StringDrawingView : UIView

@property (copy) NSString *stringToDraw;

@property BOOL usesDeviceMetrics;

@property CGFloat headIndent;
@property CGFloat firstLineHeadIndent;
@property CGFloat tailIndent;

@end
