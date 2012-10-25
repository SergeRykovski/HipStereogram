//
//  HSBackgroundPatternCreator.m
//  HipStereogram
//
//  Created by Serge Rykovski on 10/19/12.
//  Copyright (c) 2012 Serge Rykovski. All rights reserved.
//

#import "HSStereogramCreator.h"
#import "HSStereogramBackgroundImage.h"
#import "UIImage+BitmapData.h"

#include <math.h>
static inline double radians (double degrees) {return degrees * M_PI / 180;}

#define foo4random() (arc4random() % ((unsigned)RAND_MAX + 1))
#define ground(x) ( (float)(x) / (float)((unsigned)RAND_MAX + 1) )
#define PIC_WIDTH 480
#define PIC_HEIGHT 320

@implementation HSStereogramCreator

+ (UIImage *)backgroundPatternWithColorCount:(NSUInteger)colorCount shapeCount:(NSUInteger)shapeCount period:(NSUInteger)period
{
	NSUInteger width = period;
    NSUInteger height = PIC_HEIGHT;
	UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), YES, 0.0);
	CGContextRef currentContext = UIGraphicsGetCurrentContext();
	CGContextSetBlendMode(currentContext, kCGBlendModeNormal);
	
	NSMutableArray *palette = [[NSMutableArray alloc] init];
	for (NSUInteger count = 0; count < colorCount; count++)
	{
		UIColor *color = [UIColor colorWithRed:ground(foo4random()) green:ground(foo4random()) blue:ground(foo4random()) alpha:1.0f];
		[palette addObject:color];
	}
	
	int xx[] = { -1, 0, 1, -1, 0, 1, -1, 0, 1 };
	int yy[] = { -1, -1, -1, 0, 0, 0, 1, 1, 1 };
	for (int i = 0; i < shapeCount; i++)
	{
		int x = arc4random()%width;//rnd.Next(sizeW);
		int y = arc4random()%height;//rnd.Next(sizeH);
		int w = arc4random()%(10 + arc4random()%11);//rnd.Next(10 + rnd.Next(10));
		int h = arc4random()%(10 + arc4random()%11);//rnd.Next(10 + rnd.Next(10));
		int x2 = x - 5 + arc4random()%12;//rnd.Next(11);
		int y2 = y - 5 + arc4random()%12;//rnd.Next(11);
		int x3 = x + arc4random()%(width+1) - width/2;//rnd.Next(sizeW) - sizeW / 2;
		int y3 = y + arc4random()%(width+1) - width/2;//rnd.Next(sizeW) - sizeW / 2;
		int x4 = x3 - 5 + arc4random()%12;//rnd.Next(11);
		int y4 = y3 - 5 + arc4random()%12;//rnd.Next(11);
		
		int shape = arc4random()%4;//rnd.Next(3);
		
		for (int j = 0; j < 9; j++)
			switch (shape)
        {
            case 0:
                [[palette objectAtIndex:(arc4random() % colorCount)] setFill];
                CGContextFillRect(currentContext, CGRectMake((CGFloat)(x + xx[j] * width), (CGFloat)(y + yy[j] * height), (CGFloat)(w), (CGFloat)(h)));
                //g.FillRectangle(brush1, x + xx[j] * sizeW, y + yy[j] * sizeH, w, h);
                [[palette objectAtIndex:(arc4random() % colorCount)] setFill];
                CGContextFillRect(currentContext, CGRectMake((CGFloat)(x + xx[j] * height + w / 4), (CGFloat)(y + yy[j] * height + w / 4), (CGFloat)(w / 2), (CGFloat)(h - w / 2)));
                //g.FillRectangle(brush2, x + xx[j] * sizeW + w / 4, y + yy[j] * sizeH + w / 4, w / 2, h - w / 2);
                break;
            case 1:
                [[palette objectAtIndex:(arc4random() % colorCount)] setFill];
                CGContextFillEllipseInRect(currentContext, CGRectMake((CGFloat)(x + xx[j] * width), (CGFloat)(y + yy[j] * height), (CGFloat)(w), (CGFloat)(h)));
                //g.FillEllipse(brush1, x + xx[j] * sizeW, y + yy[j] * sizeH, w, h);
                [[palette objectAtIndex:(arc4random() % colorCount)] setFill];
                CGContextFillEllipseInRect(currentContext, CGRectMake(x + xx[j] * width + w / 4, y + yy[j] * height + w / 4, w / 2, h - w / 2));
                //g.FillEllipse(brush2, x + xx[j] * sizeW + w / 4, y + yy[j] * sizeH + w / 4, w / 2, h - w / 2);
                break;
            case 2:
            {
                CGMutablePathRef tempPath = CGPathCreateMutable();
                [[palette objectAtIndex:(arc4random() % colorCount)] setStroke];
                CGPathMoveToPoint(tempPath, NULL, (CGFloat)(x), (CGFloat)(y));
                CGPathAddCurveToPoint(tempPath, NULL, x2, y2, x3, y3, x4, y4);
                CGPathCloseSubpath(tempPath);
                CGContextSetLineWidth(currentContext, 3 + arc4random()%5);
                CGContextAddPath(currentContext, tempPath);
                CGContextStrokePath(currentContext);
                //g.DrawBezier(pen1, x, y, x2, y2, x3, y3, x4, y4);
                tempPath = CGPathCreateMutable();
                [[palette objectAtIndex:(arc4random() % colorCount)] setStroke];
                CGPathMoveToPoint(tempPath, NULL, (CGFloat)(x), (CGFloat)(y));
                CGPathAddCurveToPoint(tempPath, NULL, x2, y2, x3, y3, x4, y4);
                CGPathCloseSubpath(tempPath);
                CGContextSetLineWidth(currentContext, 1 + arc4random()%4);
                CGContextAddPath(currentContext, tempPath);
                CGContextStrokePath(currentContext);
                //g.DrawBezier(pen2, x, y, x2, y2, x3, y3, x4, y4);
                CGPathRelease(tempPath);
                break;
            }/*
              case 3:
              g.DrawCurve(pen1, new[] { new Point(x, y), new Point(x2, y2), new Point(x3, y3), new Point(x4, y4) });
              g.DrawCurve(pen2, new[] { new Point(x, y), new Point(x2, y2), new Point(x3, y3), new Point(x4, y4) });
              break;*/
        }
	}
	
	UIImage *backgroundPattern = UIGraphicsGetImageFromCurrentImageContext();
	
	UIGraphicsEndImageContext();
	
	return backgroundPattern;
}

+ (UIImage *)randomBackgroundPattern
{
    return [self backgroundPatternWithColorCount:30 shapeCount:2500 period:80];
}

+ (UIImage *)stereogramWithMask:(UIImage *)mask background:(HSStereogramBackgroundImage *)background
{
	unsigned char *maskData = [mask RGBA8bitmapData];
    unsigned char *backgroundData = [background RGBA8bitmapData];

	if (NULL == maskData || NULL == backgroundData)
	{
        if (NULL != maskData)
        {
            free(maskData);
        }
        if (NULL != backgroundData)
        {
            free(backgroundData);
        }
		return nil;
	}
	
	int w = CGImageGetWidth([mask CGImage]);
	int h = CGImageGetHeight([mask CGImage]);
	int maskArray[w][h];
	int offset = 0;
	for (int x = 0; x < w; x++)
	{
		for (int y = 0; y < h; y++)
		{
			offset = 4 * (w * y + x);
			maskArray[x][y] = maskData[offset + 1] / 32;
		}
	}
	
	unsigned char s = background.period * [[UIScreen mainScreen] scale], alpha = 0, red = 0, green = 0, blue = 0;
	
	for (int y = 0; y < h; y++)
	{
		for (int x = 0; x < w; x++)
		{
			if (maskArray[x][y] > 0)
			{
				offset = 4 * ((w + s) * y + x + maskArray[x][y]);
				alpha	= backgroundData[offset];
				red		= backgroundData[offset + 1];
				green	= backgroundData[offset + 2];
				blue	= backgroundData[offset + 3];
				//Color pixel = stereoImg.GetPixel(x + mask[x][y], y);
				for (int i = x + s; i < w + s; i += s)
				{
					offset = 4 * ((w + s) * y + i);
					backgroundData[offset]		= alpha;
					backgroundData[offset + 1]	= red;
					backgroundData[offset + 2]	= green;
					backgroundData[offset + 3]	= blue;
					//stereoImg.SetPixel(i, y, pixel);
				}
			}
		}
	}
	
    int imageWidth = CGImageGetWidth([background CGImage]);
    int imageHeight = CGImageGetHeight([background CGImage]);
    UIImage *stereogram = [UIImage imegeWithBitmapData:backgroundData width:imageWidth height:imageHeight];

	free(maskData);
	free(backgroundData);
	
	return stereogram;
}

@end
