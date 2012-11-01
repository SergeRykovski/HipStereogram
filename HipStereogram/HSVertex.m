//
//  HSVertex.m
//  HipStereogram
//
//  Created by Serge Rykovski on 11/1/12.
//  Copyright (c) 2012 Serge Rykovski. All rights reserved.
//

#import "HSVertex.h"

@implementation HSVertex

@synthesize location = _location;
@dynamic depth, size;

- (id)initWithLocation:(CGPoint) aLocation
{
    self = [super init];
    if (nil != self)
    {
        [self setLocation:aLocation];
    }
    return self;
}

- (void)setColor:(UIColor *)color
{
}

- (NSUInteger)depth
{
    return 0;
}

- (void)setSize:(CGFloat)size
{
}

- (CGFloat)size
{
    return 0.0;
}

- (void)addMark:(id<HSMark>)mark
{
}

- (void)removeMark:(id<HSMark>)mark
{
}

- (id<HSMark>)childMarkAtIndex:(NSUInteger)index
{
    return nil;
}

- (id<HSMark>)lastChild
{
    return nil;
}

- (NSUInteger)count
{
    return 0;
}

- (void)drawWithContext:(CGContextRef)context
{
    CGContextAddLineToPoint(context, self.location.x, self.location.y);
}

@end