//
//  HSMainViewController.m
//  HipStereogram
//
//  Created by Serge Rykovski on 10/18/12.
//  Copyright (c) 2012 Serge Rykovski. All rights reserved.
//

#import "HSMainViewController.h"
#import "HSEditorViewController.h"
#import "HSStereogramCreator.h"
#import "HSConstants.h"

@interface HSMainViewController () <UIActionSheetDelegate>

@end

@implementation HSMainViewController

- (void)onRollYourOwn:(id)sender
{
	UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Select a background"
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"Select from gallery", @"Generate random", nil];
	[actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
	[actionSheet showInView:self.view];
}

#pragma mark UIActionSheetDelegate methods
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (1 == buttonIndex)
    {
        [self performSegueWithIdentifier:HSPresentEditorViewControllerSegueIdentifier sender:actionSheet];
    }
}

@end
