//
//  HSDot.m
//  HipStereogram
//
//  Created by Serge Rykovski on 11/1/12.
//  Copyright (c) 2012 Serge Rykovski. All rights reserved.
//

#import "HSDot.h"
#import "UIColor+DepthMapping.h"

@implementation HSDot

@synthesize size = _size;
@synthesize depth = _depth;

- (void)drawWithContext:(CGContextRef)context
{
    CGFloat x = self.location.x;
    CGFloat y = self.location.y;
    CGFloat frameSize = self.size;
    CGRect frame = CGRectMake(x - frameSize / 2.0, y - frameSize / 2.0, frameSize, frameSize);
    CGContextSetFillColorWithColor(context, [[UIColor colorWithDepth:self.depth] CGColor]);
    CGContextFillEllipseInRect(context, frame);
}

@end