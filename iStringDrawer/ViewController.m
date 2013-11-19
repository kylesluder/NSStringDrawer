//
//  ViewController.m
//  iStringDrawer
//
//  Created by Kyle Sluder on 11/16/13.
//  Copyright (c) 2013 Kyle Sluder. All rights reserved.
//

#import "ViewController.h"
#import "StringDrawingView.h"

@implementation ViewController
{
    StringDrawingView *_stringDrawingView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _stringDrawingView = [[StringDrawingView alloc] initWithFrame:CGRectZero];
    _stringDrawingView.translatesAutoresizingMaskIntoConstraints = NO;
    UIView *superview = self.view;
    [superview insertSubview:_stringDrawingView atIndex:0];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_stringDrawingView);
    [superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_stringDrawingView]|" options:0 metrics:nil views:views]];
    [superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_stringDrawingView]|" options:0 metrics:nil views:views]];
    
    [self _updateUI];
}

- (void)_updateUI;
{
    _deviceMetricsSwitch.on = _stringDrawingView.usesDeviceMetrics;
}

- (void)deviceMetricsSwitchAction:(id)sender;
{
    _stringDrawingView.usesDeviceMetrics = _deviceMetricsSwitch.on;
}

@end
