//
//  UIImage+BitmapData.h
//  HipStereogram
//
//  Created by Serge Rykovski on 10/19/12.
//  Copyright (c) 2012 Serge Rykovski. All rights reserved.
//

@interface UIImage (BitmapData)

+ (UIImage *)imegeWithBitmapData:(unsigned char*)bitmapData width:(NSUInteger)width height:(NSUInteger)height;
- (unsigned char *)RGBA8bitmapData;

@end
