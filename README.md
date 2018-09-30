# LYProtocolAnimation

[![CI Status](https://img.shields.io/travis/Mega/LYProtocolAnimation.svg?style=flat)](https://travis-ci.org/Mega/LYProtocolAnimation)
[![Version](https://img.shields.io/cocoapods/v/LYProtocolAnimation.svg?style=flat)](https://cocoapods.org/pods/LYProtocolAnimation)
[![License](https://img.shields.io/cocoapods/l/LYProtocolAnimation.svg?style=flat)](https://cocoapods.org/pods/LYProtocolAnimation)
[![Platform](https://img.shields.io/cocoapods/p/LYProtocolAnimation.svg?style=flat)](https://cocoapods.org/pods/LYProtocolAnimation)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

LYProtocolAnimation is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LYProtocolAnimation'
```
## Usage
```
self.modelDelegate = [[LYModelTransitionDelegate alloc]init];

__weak typeof(self) weakSelf = self;
[self.modelDelegate setAnimatedProcessBlock:^(UIViewController *fromVC, UIViewController *toVC, UIView *fromView, UIView *toView, LYProtocolOperationType operationType, NSTimeInterval duration, id<UIViewControllerContextTransitioning> transitionContext) {
__strong typeof(weakSelf) self = weakSelf;

switch (operationType) {
case LYProtocolOperationTypePresentPresentation:{


UIView *superView = self.view.superview;
self.view.translatesAutoresizingMaskIntoConstraints = NO;
[self.view.bottomAnchor constraintEqualToAnchor:superView.bottomAnchor].active = YES;
[self.view.leftAnchor constraintEqualToAnchor:superView.leftAnchor].active = YES;
[self.view.rightAnchor constraintEqualToAnchor:superView.rightAnchor].active = YES;
self.heightCon = [self.view.heightAnchor constraintEqualToConstant:0];
self.heightCon.active = YES;
[transitionContext.containerView layoutIfNeeded];


self.heightCon.constant = 500;

}break;
case LYProtocolOperationTypePresentDismissal:
default:{

self.heightCon.constant = 0;


}break;
}

[UIView animateWithDuration:duration animations:^{
[transitionContext.containerView layoutIfNeeded];
}completion:^(BOOL finished) {
BOOL isCancelled = transitionContext.transitionWasCancelled;
if (isCancelled) {
self.heightCon.constant = 500;
}

[transitionContext completeTransition:!isCancelled];
}];


}];


self.transitioningDelegate = self.modelDelegate;
self.modalPresentationStyle = UIModalPresentationCustom;
[fromViewController presentViewController:self animated:YES completion:nil];
```

## Author

Liyunpeng, lypworkon@sina.com

## License

LYProtocolAnimation is available under the MIT license. See the LICENSE file for more info.
