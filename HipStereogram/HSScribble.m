//
//  HSScribble.m
//  HipStereogram
//
//  Created by Serge Rykovski on 11/1/12.
//  Copyright (c) 2012 Serge Rykovski. All rights reserved.
//

#import "HSScribble.h"
#import "HSStroke.h"

@interface HSScribble()
@property (strong, nonatomic) id<HSMark> mark;
@end

@implementation HSScribble

@synthesize mark = _parentMark;

- (id)init
{
    self = [super init];
    if (nil != self)
    {
        _parentMark = [[HSStroke alloc] init];
    }
    return self;
}

- (void)addMark:(id<HSMark>)aMark shouldAddToPreviousMark:(BOOL)shouldAddToPreviousMark
{
    [self willChangeValueForKey:@"mark"];
    if (shouldAddToPreviousMark)
    {
        [[_parentMark lastChild] addMark:aMark];
    }
    else
    {
        [_parentMark addMark:aMark];
    }
    [self didChangeValueForKey:@"mark"];
}

- (void)removeMark:(id<HSMark>)aMark
{
    if (aMark == _parentMark)
    {
        return;
    }
    
    [self willChangeValueForKey:@"mark"];
    [_parentMark removeMark:aMark];
    [self didChangeValueForKey:@"mark"];
}

@end