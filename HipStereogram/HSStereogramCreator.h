//
//  HSBackgroundPatternCreator.h
//  HipStereogram
//
//  Created by Serge Rykovski on 10/19/12.
//  Copyright (c) 2012 Serge Rykovski. All rights reserved.
//

@class HSStereogramBackgroundImage;

@interface HSStereogramCreator : NSObject

+ (UIImage *)backgroundPatternWithColorCount:(NSUInteger)colorCount shapeCount:(NSUInteger)shapeCount period:(NSUInteger)period;
+ (UIImage *)randomBackgroundPattern;

+ (UIImage *)stereogramWithMask:(UIImage *)mask background:(HSStereogramBackgroundImage *)background;

@end
