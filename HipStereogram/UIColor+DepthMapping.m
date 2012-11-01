//
//  UIColor+DepthMapping.m
//  HipStereogram
//
//  Created by Serge Rykovski on 11/1/12.
//  Copyright (c) 2012 Serge Rykovski. All rights reserved.
//

@implementation UIColor (DepthMapping)

+ (UIColor *)colorWithDepth:(NSUInteger)depth
{
    CGFloat reverseDepth = 1.0 - ((CGFloat)depth / 256.0);
    return [UIColor colorWithRed:reverseDepth green:reverseDepth blue:reverseDepth alpha:1.0];
}

@end
