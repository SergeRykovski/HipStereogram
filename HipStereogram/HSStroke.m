//
//  HSStroke.m
//  HipStereogram
//
//  Created by Serge Rykovski on 11/1/12.
//  Copyright (c)2012 Serge Rykovski. All rights reserved.
//

#import "HSStroke.h"
#import "UIColor+DepthMapping.h"

@interface HSStroke()
@property (strong, nonatomic) NSMutableArray *children;
@end

@implementation HSStroke

@synthesize depth = _depth;
@synthesize size = _size;
@synthesize children = _children;
@dynamic location;

- (id)init
{
    self = [super init];
    if (nil != self)
    {
        self.children = [[NSMutableArray alloc] initWithCapacity:5];
    }
    return self;
}

- (void)setLocation:(CGPoint)aPoint
{
}

- (CGPoint)location
{
    CGPoint retValue = CGPointZero;
    if ([self.children count] > 0)
    {
        retValue = [[self.children objectAtIndex:0] location];
    }
    return retValue;
}

- (void)addMark:(id<HSMark>)mark
{
    [self.children addObject:mark];
}

- (void)removeMark:(id<HSMark>)mark
{
    if ([self.children containsObject:mark])
    {
        [self.children removeObject:mark];
    }
    else
    {
        [self.children makeObjectsPerformSelector:@selector(removeMark:)withObject:mark];
    }
}

- (id<HSMark>)childMarkAtIndex:(NSUInteger)index
{
    id<HSMark> retValue = nil;
    if (index < [self.children count])
    {
        retValue = [self.children objectAtIndex:index];
    }
    return retValue;
}

- (id<HSMark>)lastChild
{
    return [self.children lastObject];
}

- (NSUInteger)count
{
    return [self.children count];
}

- (void) drawWithContext:(CGContextRef)context
{
    CGContextMoveToPoint(context, self.location.x, self.location.y);
    for (id<HSMark> mark in self.children)
    {
        [mark drawWithContext:context];
    }
    CGContextSetStrokeColorWithColor(context,[[UIColor colorWithDepth:self.depth] CGColor]);
    CGContextSetLineWidth(context, self.size);
    CGContextStrokePath(context);
}

@end