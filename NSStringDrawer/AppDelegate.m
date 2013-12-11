//
//  AppDelegate.m
//  NSStringDrawer
//
//  Created by Kyle Sluder on 1/25/13.
//  Copyright (c) 2013 Kyle Sluder. All rights reserved.
//

#import "AppDelegate.h"
#import "StringDrawingView.h"

@implementation AppDelegate

- (IBAction)takeFlipped:(id)sender;
{
    [_stringDrawingView setFlipped:[sender state] == NSOnState];
}

- (IBAction)takeStringToDraw:(id)sender;
{
    [_stringDrawingView setStringToDraw:[sender stringValue]];
}

- (IBAction)takeUsesDeviceMetrics:(id)sender;
{
    [_stringDrawingView setUsesDeviceMetrics:[sender state] == NSOnState];
}

- (void)takeUsesFontLeading:(id)sender;
{
    [_stringDrawingView setUsesFontLeading:[sender state] == NSOnState];
}

- (void)takeHeadIndentFrom:(id)sender;
{
    [_stringDrawingView setHeadIndent:[[sender objectValue] floatValue]];
}

- (void)takeFirstLineHeadIndentFrom:(id)sender;
{
    [_stringDrawingView setFirstLineHeadIndent:[[sender objectValue] floatValue]];
}

- (void)takeTailIndentFrom:(id)sender;
{
    [_stringDrawingView setTailIndent:[[sender objectValue] floatValue]];
}

@end
