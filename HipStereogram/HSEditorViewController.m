//
//  HSEditorViewController.m
//  HipStereogram
//
//  Created by Serge Rykovski on 10/19/12.
//  Copyright (c) 2012 Serge Rykovski. All rights reserved.
//

#import "HSEditorViewController.h"
#import "HSPreviewViewController.h"
#import "HSStereogramCreator.h"
#import "HSStereogramBackgroundImage.h"

#import "HSVertex.h"
#import "HSDot.h"
#import "HSStroke.h"
#import "HSScribble.h"

#import "HSDrawingView.h"

@interface HSEditorViewController ()

@property (strong, nonatomic) HSStereogramBackgroundImage *background;
@property (strong, nonatomic) HSScribble *scribble;
@property (assign, nonatomic) NSUInteger strokeDepth;
@property (assign, nonatomic) CGFloat strokeSize;
@property (assign, nonatomic) CGPoint startingPoint;

- (void)randomizeBackground;

@end

@implementation HSEditorViewController

@synthesize backgroundPattern = _backgroundPattern;
@synthesize backgroundImageView = _backgroundImageView;
@synthesize drawingView = _drawingView;

@synthesize background = _background;
@synthesize scribble = _scribble;
@synthesize strokeDepth = _strokeDepth;
@synthesize strokeSize = _strokeSize;
@synthesize startingPoint = _startingPoint;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (nil != self)
    {
        self.strokeDepth = 100;
        self.strokeSize = 10.0;
    }
    return self;
}

- (void)dealloc
{
    self.scribble = nil; // not to leak observation info
}

- (void)randomizeBackground
{
    self.backgroundPattern = [HSStereogramCreator randomBackgroundPattern];
    self.background = [HSStereogramBackgroundImage imageWithPattern:self.backgroundPattern];
    [self.backgroundImageView setImage:self.background];
}

- (void)setScribble:(HSScribble *)aScribble
{
    if (aScribble != _scribble)
    {
        [_scribble removeObserver:self forKeyPath:@"mark" context:nil];
        _scribble = aScribble;
        [_scribble addObserver:self forKeyPath:@"mark" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) context:nil];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    HSScribble *scribble = [[HSScribble alloc] init];
    [self setScribble:scribble];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (nil == self.backgroundPattern)
    {
        [self randomizeBackground];
    }
}

#pragma UIResponder stuff
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    [self randomizeBackground];
}

#pragma Segue stuff
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    HSPreviewViewController *previewController = [segue destinationViewController];
    UIImage *mask = [UIImage imageNamed:@"mask_hw"];
    [previewController setStereogram:[HSStereogramCreator stereogramWithMask:mask background:self.background]];
}

#pragma mark Touch Event Handlers

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.startingPoint = [[touches anyObject] locationInView:self.drawingView];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint lastPoint = [[touches anyObject] previousLocationInView:self.drawingView];
    if (CGPointEqualToPoint(lastPoint, self.startingPoint))
    {
        id<HSMark> newStroke = [[HSStroke alloc] init];
        [newStroke setDepth:self.strokeDepth];
        [newStroke setSize:self.strokeSize];
        [self.scribble addMark:newStroke shouldAddToPreviousMark:NO];
    }
    
    CGPoint thisPoint = [[touches anyObject] locationInView:self.drawingView];
    HSVertex *vertex = [[HSVertex alloc] initWithLocation:thisPoint];
    [self.scribble addMark:vertex shouldAddToPreviousMark:YES];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint lastPoint = [[touches anyObject] previousLocationInView:self.drawingView];
    CGPoint thisPoint = [[touches anyObject] locationInView:self.drawingView];
    if (CGPointEqualToPoint(lastPoint, thisPoint))
    {
        HSDot *singleDot = [[HSDot alloc] initWithLocation:thisPoint];
        [singleDot setDepth:self.strokeDepth];
        [singleDot setSize:self.strokeSize];
        [self.scribble addMark:singleDot shouldAddToPreviousMark:NO];
    }
    self.startingPoint = CGPointZero;
}
    
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.startingPoint = CGPointZero;
}

#pragma mark Scribble observer method

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([object isKindOfClass:[HSScribble class]] && [keyPath isEqualToString:@"mark"])
    {
        id<HSMark> mark = [change objectForKey:NSKeyValueChangeNewKey];
        [self.drawingView setMark:mark];
        [self.drawingView setNeedsDisplay];
    }
}

@end
