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
    
    [self loadAvatar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadAvatar {
    self.avatar = [[RCDraggableButton alloc] initWithFrame:CGRectMake(100, 100, 60, 60)];
    [self.avatar setBackgroundImage:[UIImage imageNamed:@"avatar"] forState:UIControlStateNormal];
    [self.avatar setAutoDocking:NO];
    [self.avatar touchedBlock:^(RCDraggableButton *avatar) {
        NSLog(@"Avatar touched");
        //More todo here.
    }];
}

@end
