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
#define ANIMATEDURATION 0.2f

@implementation RCDraggableButton
@synthesize draggable = _draggable;
@synthesize autoDocking = _autoDocking;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self performSelector:@selector(addButtonToKeyWindow) withObject:nil afterDelay:0.1];
        [self defaultSetting];
    }
    return self;
}

- (void)defaultSetting {
    [self.layer setCornerRadius:self.frame.size.width / 2];
    [self.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.layer setBorderWidth:0.5];
    [self.layer setMasksToBounds:YES];
    
    _draggable = YES;
    _autoDocking = YES;
}

- (void)addButtonToKeyWindow {
    [self addTarget:self action:@selector(buttonTouched) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)touchedBlock:(void (^)(RCDraggableButton *))block {
    self.touchedBlock = block;
}

#pragma mark - touch
- (void)buttonTouched {
    if (self.touchedBlock && !_isDragging) {
        self.touchedBlock(self);
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    _isDragging = NO;
    [super touchesBegan:touches withEvent:event];
    
    _beginLocation = [[touches anyObject] locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (_draggable) {
        _isDragging = YES;
        
        UITouch *touch = [touches anyObject];
        CGPoint currentLocation = [touch locationInView:self];
        
        float offsetX = currentLocation.x - _beginLocation.x;
        float offsetY = currentLocation.y - _beginLocation.y;
        
        self.center = CGPointMake(self.center.x + offsetX, self.center.y + offsetY);
        
        CGRect superviewFrame = self.superview.frame;
        CGRect frame = self.frame;
        CGFloat middleX = frame.size.width / 2;
        CGFloat limitX = superviewFrame.size.width - middleX;
        CGFloat middleY = frame.size.height / 2;
        CGFloat limitY = superviewFrame.size.height - middleY;
        
        if (self.center.x > limitX) {
            self.center = CGPointMake(limitX, self.center.y + offsetY);
        }else if (self.center.x < middleX) {
            self.center = CGPointMake(middleX, self.center.y + offsetY);
        }
        
        if (self.center.y > limitY) {
            self.center = CGPointMake(self.center.x, limitY);
        }else if (self.center.y <= middleY){
            self.center = CGPointMake(self.center.x, middleY);
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded: touches withEvent: event];

    if (_autoDocking) {
        if (self.center.x >= self.superview.frame.size.width/2) {
            [UIView animateWithDuration:ANIMATEDURATION animations:^{
                self.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - self.frame.size.width, self.center.y - self.frame.size.width / 2, self.frame.size.width, self.frame.size.width);
            }];
        } else {
            [UIView animateWithDuration:ANIMATEDURATION animations:^{
                self.frame = CGRectMake(0.0f, self.center.y - self.frame.size.width / 2, self.frame.size.width, self.frame.size.width);
            }];
        }
    }
    
    _isDragging = NO;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    _isDragging = NO;
    [super touchesCancelled:touches withEvent:event];
}

- (BOOL)isDragging {
    return _isDragging;
}
@end