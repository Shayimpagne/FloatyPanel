# FloatyPanel

[![CI Status](https://img.shields.io/travis/Shayimpagne/FloatyPanel.svg?style=flat)](https://travis-ci.org/Shayimpagne/FloatyPanel)
[![Version](https://img.shields.io/cocoapods/v/FloatyPanel.svg?style=flat)](https://cocoapods.org/pods/FloatyPanel)
[![License](https://img.shields.io/cocoapods/l/FloatyPanel.svg?style=flat)](https://cocoapods.org/pods/FloatyPanel)
[![Platform](https://img.shields.io/cocoapods/p/FloatyPanel.svg?style=flat)](https://cocoapods.org/pods/FloatyPanel)

Lightweight and easy to use floating panel.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

FloatyPanel is compatible with iOS 10.0+.

## Installation

FloatyPanel is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'FloatyPanel'
```

## Getting Started 

### Create new UIViewController with .xib file and inherit it from FloatyPanelViewController:

```swift
import UIKit
import FloatyPanel

class CustomFloatyPanelViewController: FloatyPanelViewController { }
```

### Make main view color .clear and add new UIView and connect this view to panelView outlet 

![Step1](https://github.com/Shayimpagne/FloatyPanel/blob/master/assets/step1.png)

### Add constraints to your panelView, but don't add .height constraint, this will not give an opportunity to "stretch" your panel while it's dragged up. Then connect your panelView .bottom constraint to panelViewBottomConstraint outlet.

![Step2](https://github.com/Shayimpagne/FloatyPanel/blob/master/assets/step2.png)

### Add content to your panelView and connect .bottom constraint of your content to panelViewBottomContentConstraint outlet, also if you need you can add separator and title to top of your panelView.

![Step3](https://github.com/Shayimpagne/FloatyPanel/blob/master/assets/step3.png)
![Step4](https://github.com/Shayimpagne/FloatyPanel/blob/master/assets/step4.png)

### Add next code to present your floatyPanel controller:

```swift
let viewController = CustomFloatingPanelViewController()
viewController.modalPresentationStyle = .overCurrentContext  
present(viewController, animated: false, completion: nil) // Important point, FloatyPanel has it's own animation, set animated to false. 
```

### Run your code: 

![Step5](https://github.com/Shayimpagne/FloatyPanel/blob/master/assets/step5.png)


## Delegate functions

### Additional features are available by implementing the FloatyPanelDelegate protocol.

```swift
floatyPanelDidClose(_ floatingPanel: FloatyPanelViewController) // called when controller is closed.
floatyPanelWillBeginDragging(_ floatingPanel: FloatyPanelViewController) // called when panelView is begin dragging.
floatyPanelDidEndDragging(_ floatingPanel: FloatyPanelViewController, targetPosition: FloatyPanelState) // called when panelView is stop dragging. 
```

## FloatyPanel parameters

```swift
public var isGrabberHidden: Bool // hides grabber.
public var isInteractiveBackground: Bool // disable closing panelView by tap to background.
public var state: FloatyPanelState // current panelView state.
public var panelViewHeight: CGFloat // panelView height.
public var partialHeight: CGFloat? // if you will set value for this parameter, panelView will have third state = .partial, for this state panelView may be shown partially. 
public var isAnimatedGrabber: Bool // animating grabber when tapping, by default is false.
```

## Author

Shayimpagne, emchigg5@gmail.com

## License

FloatyPanel is available under the MIT license. See the LICENSE file for more info.
