//
//  HSEditorViewController.m
//  HipStereogram
//
//  Created by Serge Rykovski on 10/19/12.
//  Copyright (c) 2012 Serge Rykovski. All rights reserved.
//

#import "HSEditorViewController.h"
#import "HSPreviewViewController.h"
#import "HSStereogramCreator.h"
#import "HSStereogramBackgroundImage.h"

@interface HSEditorViewController ()
@property (strong, nonatomic) HSStereogramBackgroundImage *background;
- (void)randomizeBackground;
@end

@implementation HSEditorViewController
@synthesize backgroundPattern = _backgroundPattern;
@synthesize backgroundImageView = _backgroundImageView;
@synthesize background = _background;

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (nil == self.backgroundPattern)
    {
        [self randomizeBackground];
    }
}

- (void)randomizeBackground
{
    self.backgroundPattern = [HSStereogramCreator randomBackgroundPattern];
    self.background = [HSStereogramBackgroundImage imageWithPattern:self.backgroundPattern];
    [self.backgroundImageView setImage:self.background];
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

#pragma Segue stuff
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    HSPreviewViewController *previewController = [segue destinationViewController];
    UIImage *mask = [UIImage imageNamed:@"mask_hw"];
    [previewController setStereogram:[HSStereogramCreator stereogramWithMask:mask background:self.background]];
}

@end
