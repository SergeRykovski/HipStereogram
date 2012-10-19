//
//  HSPreviewViewController.m
//  HipStereogram
//
//  Created by Serge Rykovski on 10/19/12.
//  Copyright (c) 2012 Serge Rykovski. All rights reserved.
//

#import "HSPreviewViewController.h"

@implementation HSPreviewViewController
@synthesize stereogram = _stereogram;
@synthesize stereogramImageView = _stereogramImageView;

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.stereogramImageView.image = self.stereogram;
}

@end
