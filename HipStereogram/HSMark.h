//
//  HSMark.h
//  HipStereogram
//
//  Created by Serge Rykovski on 11/1/12.
//  Copyright (c) 2012 Serge Rykovski. All rights reserved.
//

@protocol HSMark <NSObject>

@property (assign, nonatomic) NSUInteger depth;
@property (assign, nonatomic) CGFloat size;
@property (assign, nonatomic) CGPoint location;
@property (readonly, nonatomic) NSUInteger count;
@property (readonly, nonatomic) id<HSMark> lastChild;

- (void)addMark:(id<HSMark>)mark;
- (void)removeMark:(id<HSMark>) mark;
- (id<HSMark>)childMarkAtIndex:(NSUInteger) index;

- (void)drawWithContext:(CGContextRef)context;

@end