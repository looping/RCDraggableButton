//
//  RCViewController.m
//  RCDraggableButtonDemo
//
//  Created by Looping on 14-2-8.
//  Copyright (c) 2014 RidgeCorn. All rights reserved.
//

#import "RCViewController.h"

@interface RCViewController ()

@end

@implementation RCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadTrashCan];
    
    [self loadAvatarInKeyWindow];
    
    [self loadAvatarInCustomView];
    
    [self addControlButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)loadTrashCan {
    UIView *trashCan = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 120)];
    [trashCan setTag:90];
    [trashCan setBackgroundColor:[UIColor clearColor]];
    [trashCan setHidden:YES];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, 40)];
    [tipLabel setBackgroundColor:[UIColor clearColor]];
    [tipLabel setText:@"Drag here to remove it!"];
    [tipLabel setTextAlignment:NSTextAlignmentCenter];
    [tipLabel setTextColor:[UIColor blueColor]];
    [tipLabel.layer setCornerRadius:20];
    [tipLabel.layer setBorderWidth:1];
    [tipLabel.layer setBorderColor:[UIColor blueColor].CGColor];
    [tipLabel setTag:91];
    
    [trashCan addSubview:tipLabel];
    [self.view addSubview:trashCan];
}

- (void)loadAvatarInKeyWindow {
    RCDraggableButton *avatar = [[RCDraggableButton alloc] initInView:nil WithFrame:CGRectMake(0, 100, 60, 60)];
    
    [self configLayer: avatar];
   
    [avatar setBackgroundImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    [avatar setIsTraceEnabled:YES];
    
    [avatar setLongPressBlock:^(RCDraggableButton *avatar) {
        [[self.view viewWithTag:90] setHidden:NO];
        [RCDraggableButton allInView:self.view moveToPoint:CGPointMake(200, 200)];
    }];
    
    [avatar setTapBlock:^(RCDraggableButton *avatar) {
        [[self.view viewWithTag:90] setHidden:NO];
        [avatar moveToPoint:CGPointMake(avatar.center.x + 1, avatar.center.y - 1)];
    }];
    
    [avatar setDoubleTapBlock:^(RCDraggableButton *avatar) {
        [[self.view viewWithTag:90] setHidden:NO];
        [RCDraggableButton inView:self.view withTag:92 moveToPoint:CGPointMake(200, 400)];
    }];
    
    [avatar setDraggingBlock:^(RCDraggableButton *avatar) {
        [[self.view viewWithTag:90] setHidden:NO];
        
        UILabel *tipsLabel = (UILabel *)[self.view viewWithTag:91];
        if ([avatar isInsideRect:[self.view viewWithTag:90].frame]) {
            [(UILabel *)[self.view viewWithTag:91] setTextColor:[UIColor redColor]];
            [tipsLabel setText:@"Release to remove it!"];
        } else {
            [tipsLabel setTextColor:[UIColor blueColor]];
            [tipsLabel setText:@"Drag here to remove it!"];
        }
    }];
    
    [avatar setDragEndedBlock:^(RCDraggableButton *avatar) {
        UILabel *tipsLabel = (UILabel *)[self.view viewWithTag:91];
        if ([avatar isInsideRect:[self.view viewWithTag:90].frame]) {
            [tipsLabel setTextColor:[UIColor blueColor]];
            [tipsLabel setText:@"Drag here to remove it!"];
        }
        [[self.view viewWithTag:90] setHidden:YES];
        
        [avatar moveToPoint:CGPointMake(30, 130) animatedWithDuration:2.f delay:0 options:0 completion:^{
            NSLog(@"Moving completed!");
        }];
        
        [avatar removeFromSuperviewInsideRect:[self.view viewWithTag:90].frame];
    }];
}

- (void)loadAvatarInCustomView {
    UIView *customView = nil;
    if ([self.view viewWithTag:89]) {
        customView = [self.view viewWithTag:89];
    } else {
        customView = [[UIView alloc] initWithFrame:CGRectMake(120, 100, 160, 160)];
        [customView setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:1]];
        [customView setTag:89];
        [customView.layer setCornerRadius:80];
        [self.view addSubview:customView];
    }
    RCDraggableButton *avatar = [[RCDraggableButton alloc] initInView:customView WithFrame:CGRectMake(50, 50, 60, 60)];
    [avatar setBackgroundImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    
    [self configLayer:avatar];
    
    [avatar setAutoDocking:YES];
    
    [avatar setDockPoint:avatar.center];
    
    [avatar setLimitedDistance:60.f];

    avatar.longPressBlock = ^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in customView ===  LongPress!!! ===");
        //More todo here.
        
    };
    
    avatar.tapBlock = ^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in customView ===  Tap!!! ===");
        //More todo here.
        
    };
    
    avatar.draggingBlock = ^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in customView === Dragging!!! ===");
        //More todo here.
        
    };
    
    avatar.dragEndedBlock = ^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in customView === DragDone!!! ===");
        //More todo here.
        
    };
    
    avatar.autoDockingBlock = ^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in customView === AutoDocking!!! ===");
        //More todo here.
        
    };
    
    avatar.autoDockEndedBlock = ^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in customView === AutoDockingDone!!! ===");
        //More todo here.
        
    };
}

- (void)addControlButton {
    RCDraggableButton *removeAllFromKeyWindow = [[RCDraggableButton alloc] initInView:self.view WithFrame:CGRectMake(10, 280, 300, 44)];
    [removeAllFromKeyWindow addTarget:self action:@selector(removeAllFromKeyWindow) forControlEvents:UIControlEventTouchUpInside];
    [removeAllFromKeyWindow setTag:92];
    [removeAllFromKeyWindow setTitle:@"Remove All From KeyWindow" forState:UIControlStateNormal];
    [removeAllFromKeyWindow setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [removeAllFromKeyWindow setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [removeAllFromKeyWindow setDraggable:NO];
    [self.view addSubview:removeAllFromKeyWindow];
    
    RCDraggableButton *addOneToKeyWindow = [[RCDraggableButton alloc] initInView:self.view WithFrame:CGRectMake(10, 330, 300, 44)];
    [addOneToKeyWindow addTarget:self action:@selector(loadAvatarInKeyWindow) forControlEvents:UIControlEventTouchUpInside];
    [addOneToKeyWindow setTitle:@"Add One To KeyWindow" forState:UIControlStateNormal];
    [addOneToKeyWindow setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [addOneToKeyWindow setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [addOneToKeyWindow setDraggable:NO];
    [self.view addSubview:addOneToKeyWindow];
    
    RCDraggableButton *removeAllFromView = [[RCDraggableButton alloc] initInView:self.view WithFrame:CGRectMake(10, 380, 300, 44)];
    [removeAllFromView addTarget:self action:@selector(removeAllFromView) forControlEvents:UIControlEventTouchUpInside];
    [removeAllFromView setTitle:@"Remove All From View" forState:UIControlStateNormal];
    [removeAllFromView setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [removeAllFromView setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [removeAllFromView setDraggable:NO];
    [self.view addSubview:removeAllFromView];
    
    RCDraggableButton *addOneToView = [[RCDraggableButton alloc] initInView:self.view WithFrame:CGRectMake(10, 430, 300, 44)];
    [addOneToView addTarget:self action:@selector(loadAvatarInCustomView) forControlEvents:UIControlEventTouchUpInside];
    [addOneToView setTitle:@"Add One To View" forState:UIControlStateNormal];
    [addOneToView setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [addOneToView setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [addOneToView setDraggable:NO];
    [self.view addSubview:addOneToView];
}

- (void)removeAllFromKeyWindow {
    [RCDraggableButton removeAllFromView:nil];
}

- (void)removeAllFromView {
    [RCDraggableButton removeAllFromView:[self.view viewWithTag:89]];
}

- (void)configLayer:(RCDraggableButton *)button {
    [button setLayerConfigBlock:^(RCDraggableButton *button) {
        [button.layer setCornerRadius:button.frame.size.height / 2];
        [button.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [button.layer setBorderWidth:0.5];
        [button.layer setMasksToBounds:YES];
    }];
    button.layerConfigBlock(button);
}

@end
