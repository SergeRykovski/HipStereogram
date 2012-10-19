//
//  HSBackgroundPatternCreator.h
//  HipStereogram
//
//  Created by Serge Rykovski on 10/19/12.
//  Copyright (c) 2012 Serge Rykovski. All rights reserved.
//

@interface HSStereogramCreator : NSObject

+ (UIImage *)backgroundPatternWithColorCount:(NSUInteger)colorCount shapeCount:(NSUInteger)shapeCount period:(NSUInteger)period;
+ (UIImage *)randomBackgroundPattern;

@end
