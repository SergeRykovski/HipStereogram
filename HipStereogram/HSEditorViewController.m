//
//  HSEditorViewController.m
//  HipStereogram
//
//  Created by Serge Rykovski on 10/19/12.
//  Copyright (c) 2012 Serge Rykovski. All rights reserved.
//

#import "HSEditorViewController.h"
#import "HSBackgroundPatternCreator.h"

@interface HSEditorViewController ()
- (void)randomizeBackground;
- (void)tileBackgroundPatternInBackgroundImagView:(UIImage *)backgroundPattern;
@end

@implementation HSEditorViewController
@synthesize backgroundPattern = _backgroundPattern;
@synthesize backgroundImageView = _backgroundImageView;

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self randomizeBackground];
}

- (void)tileBackgroundPatternInBackgroundImagView:(UIImage *)backgroundPattern
{
    CGSize imageSize = self.backgroundImageView.frame.size;
	UIGraphicsBeginImageContextWithOptions(imageSize, YES, 0.0);
	CGContextRef currentContext = UIGraphicsGetCurrentContext();
	
	CGRect imageRect = CGRectZero;
	imageRect.size = backgroundPattern.size;
	imageRect.origin = CGPointMake(0.0, 0.0);
	
	CGContextDrawTiledImage(currentContext, imageRect, [backgroundPattern CGImage]);
    UIImage *background = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
    [self.backgroundImageView setImage:background];
}

- (void)randomizeBackground
{
    self.backgroundPattern = [HSBackgroundPatternCreator randomBackgroundPattern];
    [self tileBackgroundPatternInBackgroundImagView:self.backgroundPattern];
}

#pragma UIResponder stuff
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    [self randomizeBackground];
}

@end
