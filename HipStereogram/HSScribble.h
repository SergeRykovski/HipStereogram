//
//  HSScribble.h
//  HipStereogram
//
//  Created by Serge Rykovski on 11/1/12.
//  Copyright (c) 2012 Serge Rykovski. All rights reserved.
//

@protocol HSMark;

@interface HSScribble : NSObject

- (void)addMark:(id<HSMark>)aMark shouldAddToPreviousMark:(BOOL)shouldAddToPreviousMark;
- (void)removeMark:(id<HSMark>)aMark;

@end