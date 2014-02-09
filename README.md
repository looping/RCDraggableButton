# RCDraggableButton

[![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)](https://github.com/RidgeCorn/RCDraggableButton/blob/master/LICENSE)
[![Build Platform](https://cocoapod-badges.herokuapp.com/p/RCDraggableButton/badge.png)](https://github.com/RidgeCorn/RCDraggableButton)
[![Build Version](https://cocoapod-badges.herokuapp.com/v/RCDraggableButton/badge.png)](https://github.com/RidgeCorn/RCDraggableButton)
[![Build Status](https://travis-ci.org/RidgeCorn/RCDraggableButton.png?branch=master)](https://travis-ci.org/RidgeCorn/RCDraggableButton)

A draggable button that appears in your subviews.

<img src="https://github.com/RidgeCorn/RCDraggableButton/raw/master/Screenshot.png" alt="RCDraggableButton Screenshot" width="320" height="568" />
<img src="https://github.com/RidgeCorn/RCDraggableButton/raw/master/Demo.gif" alt="RCDraggableButton Demo" width="320" height="568" />

## Note

**RCDraggableButton is not ready for production use until version 1.0.**


## Requirements
* Xcode 5 or higher
* Apple LLVM compiler
* iOS 5.0 or higher
* ARC


## Demo

Build and run the `RCDraggableButtonExample` project in Xcode to see `RCDraggableButton` in action.


## Installation

### CocoaPods

The recommended approach for installating `RCDraggableButton` is via the [CocoaPods](http://cocoapods.org/) package manager.

``` bash
platform :ios, '5.0'
pod 'RCDraggableButton', '~> 0.1'
```

### Manual Install

All you need to do is drop `RCDraggableButton` files into your project, and add `#include "RCDraggableButton.h"` to the top of classes that will use it.


## Example Usage

In your AppViewController's `- (void)viewDidLoad` create draggableButton and add it to keyWindow or customView.

```objective-c
// Add button to keyWindow
	RCDraggableButton *draggableButton = [[RCDraggableButton alloc] initInKeyWindowWithFrame:CGRectMake(0, 100, 60, 60)];
	
// Or Add it to customView
	UIView *customView = ...;
    [self.view addSubview:customView];
    RCDraggableButton *avatar = [[RCDraggableButton alloc] initInView:customView WithFrame:CGRectMake(120, 120, 60, 60)];
```

You can also use it manually:

```objective-c
	RCDraggableButton *draggableButton = [[RCDraggableButton alloc] initWithFrame:CGRectMake(0, 100, 60, 60)];
	[self.view addSubview:draggableButton];
```

## License

RCDraggableButton is available under the MIT license.
