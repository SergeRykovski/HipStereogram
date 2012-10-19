//
//  HSStereogramBackgroundImage.h
//  HipStereogram
//
//  Created by Serge Rykovski on 10/19/12.
//  Copyright (c) 2012 Serge Rykovski. All rights reserved.
//

@interface HSStereogramBackgroundImage : UIImage

+ (HSStereogramBackgroundImage *)imageWithPattern:(UIImage *)pattern;

@property (readonly, nonatomic) NSUInteger period;

@end
