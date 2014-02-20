//
//  RCDraggableButton.m
//  RCDraggableButton
//
//  Created by Looping (www.looping@gmail.com) on 14-2-8.
//  Copyright (c) 2014 RidgeCorn (https://github.com/RidgeCorn).
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "RCDraggableButton.h"

#define RC_DEFAULT_DELAY_TIME 0.f
#define RC_DEFAULT_ANIMATE_DURATION 0.2f
#define RC_DOUBLE_TAP_TIME_INTERVAL 0.36f

#define RC_TRACES_NUMBER 10
#define RC_TRACE_DISMISS_TIME_INTERVAL 0.05f

#define RC_POINT_NULL CGPointMake(MAXFLOAT, -MAXFLOAT)

@implementation RCDraggableButton

#pragma mark - Init

- (id)init {
    self = [super init];
    
    if (self) {
        [self defaultSetting];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self defaultSetting];
    }
    return self;
}

- (id)initInView:(id)view WithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self defaultSetting];

        if (view) {
            [view addSubview:self];
        } else {
            [self performSelector:@selector(addButtonToKeyWindow) withObject:nil afterDelay:RC_DEFAULT_DELAY_TIME];
        }
    }
    return self;
}

#pragma mark Default Setting

- (void)defaultSetting {
    [self.layer setCornerRadius:self.frame.size.height / 2];
    [self.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.layer setBorderWidth:0.5];
    [self.layer setMasksToBounds:YES];
    
    _draggable = YES;
    _autoDocking = YES;
    _singleTapCanceled = NO;
    
    UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] init];
    [longPressGestureRecognizer addTarget:self action:@selector(gestureRecognizerHandle:)];
    [longPressGestureRecognizer setAllowableMovement:0];
    [self addGestureRecognizer:longPressGestureRecognizer];
    
    [self setDockPoint:RC_POINT_NULL];
    
    [self setLimitedDistance: -1.f];
    
    self.isTraceEnabled = NO;
    _traceButtons = [[NSMutableArray alloc] initWithCapacity:RC_TRACES_NUMBER];
}

#pragma mark Add Button To KeyWindow

- (void)addButtonToKeyWindow {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

#pragma mark - Gesture Recognizer Handle

- (void)gestureRecognizerHandle:(UILongPressGestureRecognizer *)gestureRecognizer {
    switch ([gestureRecognizer state]) {
        case UIGestureRecognizerStateBegan: {
            if (_longPressBlock) {
                _longPressBlock(self);
            }
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Blocks
#pragma mark Single Tap Block

- (void)setTapBlock:(void (^)(RCDraggableButton *))tapBlock {
    _tapBlock = tapBlock;
    
    if (_tapBlock) {
        [self addTarget:self action:@selector(buttonTouched) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - Touch Event Handle

- (void)buttonTouched {
    [self performSelector:@selector(executeButtonTouchedBlock) withObject:nil afterDelay:(_doubleTapBlock ? RC_DOUBLE_TAP_TIME_INTERVAL : 0)];
}

- (void)executeButtonTouchedBlock {
    if ( !_singleTapCanceled && _tapBlock && !_isDragging) {
        _tapBlock(self);
    }
}

#pragma mark - Touch Delegate

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _isDragging = NO;
    
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    
    if (touch.tapCount == 2) {
        if (_doubleTapBlock) {
            _singleTapCanceled = YES;
            _doubleTapBlock(self);
        }
    } else {
        _singleTapCanceled = NO;
    }
    
    _touchBeginPoint = [[touches anyObject] locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_draggable) {
        _isDragging = YES;
        
        UITouch *touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInView:self];
        
        float offsetX = currentPoint.x - _touchBeginPoint.x;
        float offsetY = currentPoint.y - _touchBeginPoint.y;
        
        [self resetCenter:CGPointMake(self.center.x + offsetX, self.center.y + offsetY)];
        
        if (self.isTraceEnabled) {
            if ([_traceButtons count] < RC_TRACES_NUMBER) {
                RCDraggableButton *traceButton = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:self]];;
                [traceButton setAlpha:0.8];
                [traceButton setSelected:NO];
                [traceButton setHighlighted:NO];
                [traceButton defaultSetting];
                [self.superview addSubview: traceButton];
                [_traceButtons addObject:traceButton];
            }
            [self.superview bringSubviewToFront:self];
            if ( !_traceDismissTimer) {
                _traceDismissTimer = [NSTimer scheduledTimerWithTimeInterval:RC_TRACE_DISMISS_TIME_INTERVAL target:self selector:@selector(dismissTraceButton) userInfo:nil repeats:YES];
            }
        }
        
        if (_draggingBlock) {
            _draggingBlock(self);
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded: touches withEvent: event];
    
    if (_isDragging && _dragEndedBlock) {
        _dragEndedBlock(self);
        _singleTapCanceled = YES;
    }
    
    if (_isDragging && _autoDocking) {
        if ( ![self isDockPointAvailable]) {
            [self dockingToBorder];
        } else {
            [self dockingToPoint];
        }
    }

    _isDragging = NO;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    _isDragging = NO;
    _singleTapCanceled = YES;
    
    [super touchesCancelled:touches withEvent:event];
}

- (BOOL)isDragging {
    return _isDragging;
}

#pragma mark - Docking

- (BOOL)isDockPointAvailable {
    return !CGPointEqualToPoint(self.dockPoint, RC_POINT_NULL);
}

- (void)dockingToBorder {
    CGRect superviewFrame = self.superview.frame;
    CGRect frame = self.frame;
    CGFloat middleX = superviewFrame.size.width / 2;
    
    [UIView animateWithDuration:RC_DEFAULT_ANIMATE_DURATION animations:^{
        if (self.center.x >= middleX) {
            self.center = CGPointMake(superviewFrame.size.width - frame.size.width / 2, self.center.y);
        } else {
            self.center = CGPointMake(frame.size.width / 2, self.center.y);
        }
        
        if (_autoDockingBlock) {
            _autoDockingBlock(self);
        }
    } completion:^(BOOL finished) {
        if (_autoDockEndedBlock) {
            _autoDockEndedBlock(self);
        }
    }];
}

- (void)dockingToPoint {
    [UIView animateWithDuration:RC_DEFAULT_ANIMATE_DURATION animations:^{
        self.center = self.dockPoint;
        if (_autoDockingBlock) {
            _autoDockingBlock(self);
        }
    } completion:^(BOOL finished) {
        if (_autoDockEndedBlock) {
            _autoDockEndedBlock(self);
        }
    }];
}

#pragma mark - Dragging Distance And Checkings

- (BOOL)isLimitedDistanceAvailable {
    return (self.limitedDistance > 0);
}

- (BOOL)checkIfExceedingLimitedDistanceThenFixIt {
    CGPoint tmpDPoint = CGPointMake(self.center.x - self.dockPoint.x, self.center.y - self.dockPoint.y);
    
    CGFloat distance = hypotf(tmpDPoint.x, tmpDPoint.y);
    
    BOOL willExceedingLimitedDistance = (distance >= self.limitedDistance);
    
    if (willExceedingLimitedDistance) {
        self.center = CGPointMake(tmpDPoint.x * self.limitedDistance / distance + self.dockPoint.x, tmpDPoint.y * self.limitedDistance / distance + self.dockPoint.y);
    }
    
    return willExceedingLimitedDistance;
}

- (BOOL)checkIfOutOfBorderThenFixIt {
    BOOL willOutOfBorder = YES;
    
    CGRect superviewFrame = self.superview.frame;
    CGRect frame = self.frame;
    CGFloat leftLimitX = frame.size.width / 2;
    CGFloat rightLimitX = superviewFrame.size.width - leftLimitX;
    CGFloat topLimitY = frame.size.height / 2;
    CGFloat bottomLimitY = superviewFrame.size.height - topLimitY;
    
    CGPoint fixedPoint = self.center;
    
    if (self.center.x > rightLimitX) {
        fixedPoint.x = rightLimitX;
    }else if (self.center.x <= leftLimitX) {
        fixedPoint.x = leftLimitX;
    }
    
    if (self.center.y > bottomLimitY) {
        fixedPoint.y = bottomLimitY;
    }else if (self.center.y <= topLimitY){
        fixedPoint.y = topLimitY;
    }
    
    if (CGPointEqualToPoint(self.center, fixedPoint)) {
        willOutOfBorder = NO;
    } else {
        self.center = fixedPoint;
    }
    
    return willOutOfBorder;
}

#pragma mark - Version

+ (NSString *)version {
    return RCDRAGGABLEBUTTON_VERSION;
}

#pragma mark - Common Tools

#pragma mark Items In View

+ (NSArray *)itemsInView:(id)view {
    if ( !view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    
    NSMutableArray *subviews = [[NSMutableArray alloc] init];
    
    for (id subview in [view subviews]) {
        if ([subview isKindOfClass:[RCDraggableButton class]]) {
            [subviews addObject:subview];
        }
    }
    
    return subviews;
}

- (BOOL)isInView:(id)view {
    return [self.superview isEqual:view];
}

#pragma mark Rect Detecter

- (BOOL)isInsideRect:(CGRect)rect {
    return  CGRectContainsRect(rect, self.frame);
}

- (BOOL)isIntersectsRect:(CGRect)rect {
    return  CGRectIntersectsRect(rect, self.frame);
}

- (BOOL)isCrossedRect:(CGRect)rect {
    return  [self isIntersectsRect:rect] && ![self isInsideRect:rect];
}

#pragma mark Clean All Code Blocks

- (void)cleanAllCodeBlocks {
    self.longPressBlock = nil;
    self.tapBlock = nil;
    self.doubleTapBlock = nil;
    
    self.draggingBlock = nil;
    self.dragEndedBlock = nil;
    
    self.autoDockingBlock = nil;
    self.autoDockEndedBlock = nil;
}

#pragma mark Reset Center

- (void)resetCenter:(CGPoint)center {
    self.center = center;
    
    if ([self isDockPointAvailable] && [self isLimitedDistanceAvailable]) {
        [self checkIfExceedingLimitedDistanceThenFixIt];
    } else {
        [self checkIfOutOfBorderThenFixIt];
    }
}

#pragma mark - Remove All From View

+ (void)removeAllFromView:(id)view {
    for (id subview in [self itemsInView:view]) {
        [subview removeFromSuperview];
    }
}

#pragma mark - Remove From View With Tag(s)

+ (void)removeFromView:(id)view withTag:(NSInteger)tag {
    for (RCDraggableButton *subview in [self itemsInView:view]) {
        if (subview.tag == tag) {
            [subview removeFromSuperview];
        }
    }
}

+ (void)removeFromView:(id)view withTags:(NSArray *)tags {
    for (NSNumber *tag in tags) {
        [RCDraggableButton removeFromView:view withTag:[tag intValue]];
    }
}

#pragma mark - Remove From View Inside Rect

+ (void)removeAllFromView:(id)view insideRect:(CGRect)rect {
    for (id subview in [self itemsInView:view]) {
        if ([subview isInsideRect:rect]) {
            [subview removeFromSuperview];
        }
    }
}

- (void)removeFromSuperviewInsideRect:(CGRect)rect {
    if (self.superview && [self isInsideRect:rect]) {
        [self removeFromSuperview];
    }
}

#pragma mark - Remove From View Overlapped Rect

+ (void)removeAllFromView:(id)view intersectsRect:(CGRect)rect {
    for (id subview in [self itemsInView:view]) {
        if ([subview isIntersectsRect:rect]) {
            [subview removeFromSuperview];
        }
    }
}

- (void)removeFromSuperviewIntersectsRect:(CGRect)rect {
    if (self.superview && [self isIntersectsRect:rect]) {
        [self removeFromSuperview];
    }
}

#pragma mark - Remove From View Crossed Rect

+ (void)removeAllFromView:(id)view crossedRect:(CGRect)rect {
    for (id subview in [self itemsInView:view]) {
        if ([subview isCrossedRect:rect]) {
            [subview removeFromSuperview];
        }
    }
}

- (void)removeFromSuperviewCrossedRect:(CGRect)rect {
    if (self.superview && [self isInsideRect:rect]) {
        [self removeFromSuperview];
    }
}

#pragma mark - removeFromSuperview

- (void)removeFromSuperview {
    [super removeFromSuperview];
    [self cleanAllCodeBlocks];
}

#pragma mark - Auto Move To Point

+ (void)allInView:(id)view moveToPoint:(CGPoint)point animatedWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options completion:(void (^)())completion {
    for (RCDraggableButton *subview in [self itemsInView:view]) {
        [subview moveToPoint:point animatedWithDuration:duration delay:delay options:options completion:completion];
    }
}

+ (void)inView:(id)view withTag:(NSInteger)tag moveToPoint:(CGPoint)point animatedWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options completion:(void (^)())completion {
    for (RCDraggableButton *subview in [self itemsInView:view]) {
        if (tag == subview.tag) {
            [subview moveToPoint:point animatedWithDuration:duration delay:delay options:options completion:completion];
        }
    }
}

+ (void)inView:(id)view withTags:(NSArray *)tags moveToPoint:(CGPoint)point animatedWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options completion:(void (^)())completion {
    for (NSNumber *tag in tags) {
        [self inView:view withTag:[tag integerValue] moveToPoint:point animatedWithDuration:duration delay:delay options:options completion:completion];
    }
}

- (void)moveToPoint:(CGPoint)point animatedWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options completion:(void (^)())completion {
    [UIView animateWithDuration:duration delay:delay options:options animations:^{
        [self resetCenter:point];
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

+ (void)allInView:(id)view moveToPoint:(CGPoint)point {
    for (RCDraggableButton *subview in [self itemsInView:view]) {
        [subview moveToPoint:point];
    }
}

+ (void)inView:(id)view withTag:(NSInteger)tag moveToPoint:(CGPoint)point {
    for (RCDraggableButton *subview in [self itemsInView:view]) {
        if (tag == subview.tag) {
            [subview moveToPoint:point];
        }
    }
}

+ (void)inView:(id)view withTags:(NSArray *)tags moveToPoint:(CGPoint)point {
    for (NSNumber *tag in tags) {
        [self inView:view withTag:[tag integerValue] moveToPoint:point];
    }
}

- (void)moveToPoint:(CGPoint)point {
    [self moveToPoint:point animatedWithDuration:RC_DEFAULT_ANIMATE_DURATION delay:0 options:0 completion:nil];
}

#pragma mark - Trace
#pragma mark Dismiss

- (void)dismissTraceButton {
    if ([_traceButtons count]) {
        [[_traceButtons firstObject] removeFromSuperview];
        [_traceButtons removeObject:[_traceButtons firstObject]];
    } else {
        [_traceDismissTimer invalidate];
        _traceDismissTimer = nil;
    }
}
@end