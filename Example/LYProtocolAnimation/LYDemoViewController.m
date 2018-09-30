//
//  LYDemoViewController.m
//  LYProtocolAnimation_Example
//
//  Created by Mega on 2018/9/29.
//  Copyright © 2018 Mega. All rights reserved.
//

#import "LYModelTransitionDelegate.h"
#import "LYDemoViewController.h"

@interface LYDemoViewController () {
}
@property (strong , nonatomic) LYModelTransitionDelegate *modelDelegate;
@property (strong , nonatomic) NSLayoutConstraint *heightCon;
@end

@implementation LYDemoViewController

-(void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"dismiss" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor grayColor]];
    [button addTarget:self action:@selector(dismissClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button setFrame:CGRectMake(20, 40, 0, 0)];
    [button sizeToFit];
    
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
}

-(void)pan:(UIPanGestureRecognizer*)pan {

    switch (pan.state) {
        case UIGestureRecognizerStateBegan:{
            self.modelDelegate.isInteractive = YES;
            [pan setTranslation:CGPointZero inView:self.view];
            [self dismissViewControllerAnimated:YES completion:nil];
        }break;
        case UIGestureRecognizerStateChanged:{
            CGFloat h = 500.0;

            CGPoint translation = [pan translationInView:self.view];
            if (translation.y < 0) return;
            CGFloat percentage = fabs(translation.y / h);
            [self.modelDelegate.interactiveTransition updateInteractiveTransition:percentage];
            NSLog(@"%f",percentage);
        }break;
        case UIGestureRecognizerStateEnded:{
            if (self.modelDelegate.interactiveTransition.percentComplete > 0.5) {
                [self.modelDelegate.interactiveTransition finishInteractiveTransition];
            }else{
                [self.modelDelegate.interactiveTransition cancelInteractiveTransition];
            }
            self.modelDelegate.isInteractive = NO;
        }break;
        default:{
      
            [self.modelDelegate.interactiveTransition cancelInteractiveTransition];
            self.modelDelegate.isInteractive = NO;

        }break;
    }
}

-(void)dismissClick:(UIButton*)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)customPresentedFromViewController:(UIViewController *)fromViewController {
    
    
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


}

@end
