//
//  HSDrawingView.m
//  HipStereogram
//
//  Created by Serge Rykovski on 11/1/12.
//  Copyright (c) 2012 Serge Rykovski. All rights reserved.
//

#import "HSDrawingView.h"

@implementation HSDrawingView
@synthesize mark = _mark;

- (void)drawRect:(CGRect)rect
{
    [self.mark drawWithContext:UIGraphicsGetCurrentContext()];
}

@end
