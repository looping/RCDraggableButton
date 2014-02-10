//
//  RCViewController.m
//  RCDraggableButtonExample
//
//  Created by Looping on 14-2-8.
//  Copyright (c) 2014年 RidgeCorn. All rights reserved.
//

#import "RCViewController.h"

@interface RCViewController ()

@end

@implementation RCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadAvatarInKeyWindow];
    
    [self loadAvatarInCustomView];
    
    [self addControlButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadAvatarInKeyWindow {
    RCDraggableButton *avatar = [[RCDraggableButton alloc] initInKeyWindowWithFrame:CGRectMake(0, 100, 60, 60)];
    [avatar setBackgroundImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
 
    [avatar setLongPressBlock:^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in keyWindow ===  LongPress!!! ===");
        //More todo here.
        
    }];
    
    [avatar setTapBlock:^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in keyWindow ===  Tap!!! ===");
        //More todo here.
        
    }];
    
    [avatar setDoubleTapBlock:^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in keyWindow ===  DoubleTap!!! ===");
        //More todo here.
        
    }];
    
    [avatar setDraggingBlock:^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in keyWindow === Dragging!!! ===");
        //More todo here.
        
    }];
    
    [avatar setDragDoneBlock:^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in keyWindow === DragDone!!! ===");
        //More todo here.
        
    }];
    
    [avatar setAutoDockingBlock:^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in keyWindow === AutoDocking!!! ===");
        //More todo here.
        
    }];
    
    [avatar setAutoDockingDoneBlock:^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in keyWindow === AutoDockingDone!!! ===");
        //More todo here.
        
    }];
}

- (void)loadAvatarInCustomView {
    UIView *customView = nil;
    if ([self.view viewWithTag:89]) {
        customView = [self.view viewWithTag:89];
    } else {
        customView = [[UIView alloc] initWithFrame:CGRectMake(10, 64, 300, 200)];
        [customView setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:1]];
        [customView setTag:89];
        [self.view addSubview:customView];
    }
    RCDraggableButton *avatar = [[RCDraggableButton alloc] initInView:customView WithFrame:CGRectMake(120, 60, 60, 60)];
    [avatar setBackgroundImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    [avatar setAutoDocking:NO];
    
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
    
    avatar.dragDoneBlock = ^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in customView === DragDone!!! ===");
        //More todo here.
        
    };
    
    avatar.autoDockingBlock = ^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in customView === AutoDocking!!! ===");
        //More todo here.
        
    };
    
    avatar.autoDockingDoneBlock = ^(RCDraggableButton *avatar) {
        NSLog(@"\n\tAvatar in customView === AutoDockingDone!!! ===");
        //More todo here.
        
    };
}

- (void)addControlButton {
    RCDraggableButton *removeAllFromKeyWindow = [[RCDraggableButton alloc] initInView:self.view WithFrame:CGRectMake(10, 280, 300, 44)];
    [removeAllFromKeyWindow addTarget:self action:@selector(removeAllFromKeyWindow) forControlEvents:UIControlEventTouchUpInside];
    [removeAllFromKeyWindow setTitle:@"Remove All From KeyWindow" forState:UIControlStateNormal];
    [removeAllFromKeyWindow setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [removeAllFromKeyWindow setDraggable:NO];
    [self.view addSubview:removeAllFromKeyWindow];
    
    RCDraggableButton *addOneToKeyWindow = [[RCDraggableButton alloc] initInView:self.view WithFrame:CGRectMake(10, 330, 300, 44)];
    [addOneToKeyWindow addTarget:self action:@selector(loadAvatarInKeyWindow) forControlEvents:UIControlEventTouchUpInside];
    [addOneToKeyWindow setTitle:@"Add One To KeyWindow" forState:UIControlStateNormal];
    [addOneToKeyWindow setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addOneToKeyWindow setDraggable:NO];
    [self.view addSubview:addOneToKeyWindow];
    
    RCDraggableButton *removeAllFromView = [[RCDraggableButton alloc] initInView:self.view WithFrame:CGRectMake(10, 380, 300, 44)];
    [removeAllFromView addTarget:self action:@selector(removeAllFromView) forControlEvents:UIControlEventTouchUpInside];
    [removeAllFromView setTitle:@"Remove All From View" forState:UIControlStateNormal];
    [removeAllFromView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [removeAllFromView setDraggable:NO];
    [self.view addSubview:removeAllFromView];
    
    RCDraggableButton *addOneToView = [[RCDraggableButton alloc] initInView:self.view WithFrame:CGRectMake(10, 430, 300, 44)];
    [addOneToView addTarget:self action:@selector(loadAvatarInCustomView) forControlEvents:UIControlEventTouchUpInside];
    [addOneToView setTitle:@"Add One To View" forState:UIControlStateNormal];
    [addOneToView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addOneToView setDraggable:NO];
    [self.view addSubview:addOneToView];
}

- (void)removeAllFromKeyWindow {
    [RCDraggableButton removeAllFromKeyWindow];
}

- (void)removeAllFromView {
    [RCDraggableButton removeAllFromView:[self.view viewWithTag:89]];
}

@end
