//
//  HSEditorViewController.h
//  HipStereogram
//
//  Created by Serge Rykovski on 10/19/12.
//  Copyright (c) 2012 Serge Rykovski. All rights reserved.
//

@class HSDrawingView;

@interface HSEditorViewController : UIViewController

@property (strong, nonatomic) UIImage *backgroundPattern;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet HSDrawingView *drawingView;

@end
