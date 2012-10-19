//
//  HSStereogramBackgroundImage.m
//  HipStereogram
//
//  Created by Serge Rykovski on 10/19/12.
//  Copyright (c) 2012 Serge Rykovski. All rights reserved.
//

#import "HSStereogramBackgroundImage.h"
#define IMAGE_WIDTH 480.0
#define IMAGE_HEIGHT 320.0

@interface HSStereogramBackgroundImage()
@property (readwrite, assign, nonatomic) NSUInteger period;
@property (strong, nonatomic) UIImage *backgroundImage;
@end

@implementation HSStereogramBackgroundImage
@synthesize period = _period;

+ (HSStereogramBackgroundImage *)imageWithPattern:(UIImage *)pattern
{
    return [[self alloc] initWithPattern:pattern];
}

- (id)initWithPattern:(UIImage *)pattern
{
    CGSize imageSize = CGSizeMake(IMAGE_WIDTH, IMAGE_HEIGHT);
    UIGraphicsBeginImageContextWithOptions(imageSize, YES, 1.0);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGRect imageRect = CGRectZero;
    imageRect.size = pattern.size;
    imageRect.origin = CGPointMake(0.0, 0.0);
    
    CGContextDrawTiledImage(currentContext, imageRect, [pattern CGImage]);
    UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self = [super initWithCGImage:[backgroundImage CGImage] scale:1.0 orientation:UIImageOrientationUp];
    if (nil != self)
    {
        self.period = pattern.size.width;
    }
    return self;
}

@end
