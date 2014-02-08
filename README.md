# RCDraggableButton

A draggable button that appears in your subviews.


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
pod 'RCDraggableButton', '~> 0.0.1'
```

### Manual Install

All you need to do is drop `RCDraggableButton` files into your project, and add `#include "RCDraggableButton.h"` to the top of classes that will use it.


## Example Usage
```objective-c
[[RCDraggableButton alloc] initWithFrame:CGRectMake(100, 100, 60, 60)];
```

That's it!


## License

RCDraggableButton is available under the MIT license.
