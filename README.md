# RCDraggableButton

[![License MIT](https://go-shields.herokuapp.com/license-MIT-blue.png)](https://github.com/RidgeCorn/RCDraggableButton/blob/master/LICENSE)
[![Build Platform](https://cocoapod-badges.herokuapp.com/p/RCDraggableButton/badge.png)](https://github.com/RidgeCorn/RCDraggableButton)
[![Build Version](https://cocoapod-badges.herokuapp.com/v/RCDraggableButton/badge.png)](https://github.com/RidgeCorn/RCDraggableButton)
[![Build Status](https://travis-ci.org/RidgeCorn/RCDraggableButton.png?branch=master)](https://travis-ci.org/RidgeCorn/RCDraggableButton)
[![RCDraggableButton Chat](https://badges.gitter.im/RidgeCorn/RCDraggableButton.png)](https://gitter.im/RidgeCorn/RCDraggableButton)
[![Stories in Ready](https://badge.waffle.io/RidgeCorn/RCDraggableButton.png?label=ready)](https://waffle.io/RidgeCorn/RCDraggableButton)

A draggable button that appears in your view.

<img src="https://github.com/RidgeCorn/RCDraggableButton/raw/master/Screenshots/Screenshot1.png" alt="RCDraggableButton Screenshot1" width="320" height="568" />
<img src="https://github.com/RidgeCorn/RCDraggableButton/raw/master/Screenshots/Screenshot2.png" alt="RCDraggableButton Screenshot2" width="320" height="568" />
<img src="https://github.com/RidgeCorn/RCDraggableButton/raw/master/Screenshots/Screenshot3.png" alt="RCDraggableButton Screenshot3" width="320" height="568" />
<img src="https://github.com/RidgeCorn/RCDraggableButton/raw/master/Screenshots/Screenshot4.png" alt="RCDraggableButton Screenshot4" width="320" height="568" />
<img src="https://github.com/RidgeCorn/RCDraggableButton/raw/master/Screenshots/Screenshot5.png" alt="RCDraggableButton Screenshot5" width="320" height="568" />
<img src="https://github.com/RidgeCorn/RCDraggableButton/raw/master/Screenshots/Screenshot6.png" alt="RCDraggableButton Screenshot6" width="320" height="568" />

## Note

**RCDraggableButton is not ready for production use until version 1.0.**


## Requirements
* Xcode 5.0 or higher
* iOS 5.0 or higher
* ARC


## Demo

In your terminal,

``` bash
cd [projdir]/RCDraggableButtonDemo
pod install
```

After a cup of tea, you should be able to build and run the `RCDraggableButtonDemo` project by open `RCDraggableButtonDemo.xcworkspace` in Xcode5.

``` bash
open RCDraggableButtonDemo.xcworkspace
```


## Installation

### CocoaPods

The recommended approach for installating `RCDraggableButton` is via the [CocoaPods](http://cocoapods.org/) package manager.

In your `Podfile`, add a line shows below:

``` bash
pod 'RCDraggableButton', '~> 0.1'
```

Then,

``` bash
pod update
```

If you haven't used `CocoaPods` before, you should visit [CocoaPods](http://cocoapods.org/) for more info. 


### Manual Install

All you need to do is drop `Src` files into your project, and add `#include "RCDraggableButton.h"` to the top of classes that will use it. 


## Example Usage

In your AppViewController's `- (void)viewDidLoad` create draggableButton and add it to keyWindow or customView.

```objective-c
// Set view as nil, means add button to keyWindow
	RCDraggableButton *draggableButton = [[RCDraggableButton alloc] initInView:nil WithFrame:CGRectMake(120, 120, 60, 60)];
	
// Or add button to customView that you set in -init method
	UIView *customView = ...;
    [self.view addSubview:customView];
    
    RCDraggableButton *avatar = [[RCDraggableButton alloc] initInView:customView WithFrame:CGRectMake(120, 120, 60, 60)];
```

You can also use it manually:

```objective-c
	RCDraggableButton *draggableButton = [[RCDraggableButton alloc] initWithFrame:CGRectMake(0, 100, 60, 60)];
	[self.view addSubview:draggableButton];
```

For more usage example, please look up the demo project in `RCDraggableButtonDemo`, or the source files in `Src`.


## License

RCDraggableButton is available under the MIT license. See the [LICENSE](https://github.com/RidgeCorn/RCDraggableButton/blob/master/LICENSE) file for more info.
