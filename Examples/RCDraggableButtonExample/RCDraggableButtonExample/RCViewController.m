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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadAvatarInKeyWindow {
    RCDraggableButton *avatar = [[RCDraggableButton alloc] initInKeyWindowWithFrame:CGRectMake(0, 100, 60, 60)];
    [avatar setBackgroundImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    [avatar touchedBlock:^(RCDraggableButton *avatar) {
        NSLog(@"Avatar in keyWindow touched!");
        //More todo here.
    }];
}

- (void)loadAvatarInCustomView {
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 300, 300)];
    [customView setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:1]];
    [self.view addSubview:customView];
    
    RCDraggableButton *avatar = [[RCDraggableButton alloc] initInView:customView WithFrame:CGRectMake(120, 120, 60, 60)];
    [avatar setBackgroundImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    [avatar setAutoDocking:NO];
    [avatar touchedBlock:^(RCDraggableButton *avatar) {
        NSLog(@"Avatar in customView touched!");
        //More todo here.
    }];
}

@end
