//
//  AppDelegate.h
//  NSStringDrawer
//
//  Created by Kyle Sluder on 1/25/13.
//  Copyright (c) 2013 Kyle Sluder. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class StringDrawingView;

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet StringDrawingView *stringDrawingView;

- (IBAction)takeFlipped:(id)sender;
- (IBAction)takeStringToDraw:(id)sender;
- (IBAction)takeUsesDeviceMetrics:(id)sender;
- (IBAction)takeUsesFontLeading:(id)sender;

- (IBAction)takeHeadIndentFrom:(id)sender;
- (IBAction)takeFirstLineHeadIndentFrom:(id)sender;
- (IBAction)takeTailIndentFrom:(id)sender;

@end
