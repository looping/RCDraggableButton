//
//  RCDraggableButtonExampleTests.m
//  RCDraggableButtonExampleTests
//
//  Created by Looping on 14-2-8.
//  Copyright (c) 2014年 RidgeCorn. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RCDraggableButton.h"

@interface RCDraggableButtonExampleTests : XCTestCase

@end

@implementation RCDraggableButtonExampleTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testVersion {
    XCTAssertEqualObjects(RC_DB_VERSION, [RCDraggableButton version]);
}

- (void)testInitInKeyWindow {
    RCDraggableButton *draggableButton = [[RCDraggableButton alloc] initInKeyWindowWithFrame:CGRectMake(120, 120, 60, 60)];
    
    XCTAssertEqualObjects([UIButton class], [draggableButton superclass]);
    XCTAssertEqualObjects(NULL, [draggableButton superview]);
}

- (void)testInitInView {
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 300, 300)];
    [customView setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:1]];
    
    RCDraggableButton *draggableButton = [[RCDraggableButton alloc] initInView:customView WithFrame:CGRectMake(120, 120, 60, 60)];
    
    XCTAssertEqualObjects([UIButton class], [draggableButton superclass]);
    XCTAssertEqualObjects(customView, [draggableButton superview]);
}

- (void)testRemoveFromView {
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 300, 300)];
    [customView setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:1]];
    
    RCDraggableButton *draggableButton = [[RCDraggableButton alloc] initInView:customView WithFrame:CGRectMake(120, 120, 60, 60)];
    
    XCTAssertEqualObjects([UIButton class], [draggableButton superclass]);
    XCTAssertEqualObjects(customView, [draggableButton superview]);

    [RCDraggableButton removeAllFromView:customView];
    
    XCTAssertEqualObjects(NULL, [draggableButton superview]);
}
@end
