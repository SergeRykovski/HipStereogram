//
//  HSDrawingView.h
//  HipStereogram
//
//  Created by Serge Rykovski on 11/1/12.
//  Copyright (c) 2012 Serge Rykovski. All rights reserved.
//

#import "HSMark.h"

@interface HSDrawingView : UIView

@property (strong, nonatomic) id<HSMark> mark;

@end