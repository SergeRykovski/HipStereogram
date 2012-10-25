//
//  UIImage+BitmapData.m
//  HipStereogram
//
//  Created by Serge Rykovski on 10/19/12.
//  Copyright (c) 2012 Serge Rykovski. All rights reserved.
//

#import "UIImage+BitmapData.h"

@implementation UIImage (BitmapData)

- (CGContextRef)bitmapRGBA8Context
{
    CGImageRef imageRef = [self CGImage];
	CGContextRef context = NULL;
	CGColorSpaceRef colorSpace;
	uint32_t *bitmapData;
    
	size_t bitsPerPixel = 32;
	size_t bitsPerComponent = 8;
	size_t bytesPerPixel = bitsPerPixel / bitsPerComponent;
    
	size_t width = CGImageGetWidth(imageRef);
	size_t height = CGImageGetHeight(imageRef);
    
	size_t bytesPerRow = width * bytesPerPixel;
	size_t bufferLength = bytesPerRow * height;
    
	colorSpace = CGColorSpaceCreateDeviceRGB();
	if (NULL == colorSpace)
    {
		NSLog(@"Error allocating color space RGB\n");
		return NULL;
	}
    
	// Allocate memory for image data
	bitmapData = (uint32_t *)malloc(bufferLength);
	if (NULL == bitmapData)
    {
		NSLog(@"Error allocating memory for bitmap\n");
		CGColorSpaceRelease(colorSpace);
		return NULL;
	}
    
	//Create bitmap context
	context = CGBitmapContextCreate(bitmapData,
                                    width,
                                    height,
                                    bitsPerComponent,
                                    bytesPerRow,
                                    colorSpace,
                                    kCGImageAlphaPremultipliedLast);
	if (NULL == context)
    {
		free(bitmapData);
		NSLog(@"Bitmap context not created");
	}
    
	CGColorSpaceRelease(colorSpace);
    
	return context;	
}

- (unsigned char *)RGBA8bitmapData
{
	// Create a bitmap context to draw the uiimage into
	CGContextRef context = [self bitmapRGBA8Context];
	if (NULL == context)
    {
		return NULL;
	}
    
	CGImageRef imageRef = [self CGImage];
    size_t width = CGImageGetWidth(imageRef);
	size_t height = CGImageGetHeight(imageRef);
    
	CGRect rect = CGRectMake(0, 0, width, height);
	CGContextDrawImage(context, rect, imageRef);
    
	unsigned char *bitmapData = (unsigned char *)CGBitmapContextGetData(context);
    
	// Copy the data and release the memory (return memory allocated with new)
	size_t bytesPerRow = CGBitmapContextGetBytesPerRow(context);
	size_t bufferLength = bytesPerRow * height;
    
	unsigned char *newBitmap = NULL;
    
	if (NULL != bitmapData)
    {
		newBitmap = (unsigned char *)malloc(sizeof(unsigned char) * bytesPerRow * height);
		if (NULL != newBitmap)
        {	// Copy the data
			for (int i = 0; i < bufferLength; ++i)
            {
				newBitmap[i] = bitmapData[i];
			}
		}
		free(bitmapData);
	}
    else
    {
		NSLog(@"Error getting bitmap pixel data\n");
	}
    
	CGContextRelease(context);
    
	return newBitmap;	
}

+ (UIImage *)imegeWithBitmapData:(unsigned char*)bitmapData width:(NSUInteger)width height:(NSUInteger)height
{
	size_t bufferLength = width * height * 4;
	CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, bitmapData, bufferLength, NULL);
	size_t bitsPerComponent = 8;
	size_t bitsPerPixel = 32;
	size_t bytesPerRow = 4 * width;
    
	CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
	if (NULL == colorSpaceRef)
    {
		NSLog(@"Error allocating color space");
		CGDataProviderRelease(provider);
		return nil;
	}
    
	CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
	CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    
	CGImageRef iref = CGImageCreate(width,
                                    height,
                                    bitsPerComponent,
                                    bitsPerPixel,
                                    bytesPerRow,
                                    colorSpaceRef,
                                    bitmapInfo,
                                    provider,	// data provider
                                    NULL,		// decode
                                    YES,			// should interpolate
                                    renderingIntent);
    
	uint32_t *pixels = (uint32_t *)malloc(bufferLength);
    
	if (NULL == pixels)
    {
		NSLog(@"Error: Memory not allocated for bitmap");
		CGDataProviderRelease(provider);
		CGColorSpaceRelease(colorSpaceRef);
		CGImageRelease(iref);
		return nil;
	}
    
	CGContextRef context = CGBitmapContextCreate(pixels,
                                                 width,
                                                 height,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpaceRef,
                                                 bitmapInfo);
    
	if (NULL == context)
    {
		NSLog(@"Error context not created");
		free(pixels);
	}
    
	UIImage *image = nil;
	if (NULL != context)
    {
		CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, width, height), iref);
        
		CGImageRef imageRef = CGBitmapContextCreateImage(context);
        
		// Support both iPad 3.2 and iPhone 4 Retina displays with the correct scale
		if ([UIImage respondsToSelector:@selector(imageWithCGImage:scale:orientation:)])
        {
			float scale = [[UIScreen mainScreen] scale];
			image = [UIImage imageWithCGImage:imageRef scale:scale orientation:UIImageOrientationUp];
		}
        else
        {
			image = [UIImage imageWithCGImage:imageRef];
		}
        
		CGImageRelease(imageRef);	
		CGContextRelease(context);	
	}
    
	CGColorSpaceRelease(colorSpaceRef);
	CGImageRelease(iref);
	CGDataProviderRelease(provider);
    
	if(NULL != pixels)
    {
		free(pixels);
	}	
	return image;
}

@end
