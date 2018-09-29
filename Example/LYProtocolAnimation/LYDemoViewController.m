//
//  LYDemoViewController.m
//  LYProtocolAnimation_Example
//
//  Created by Mega on 2018/9/29.
//  Copyright © 2018 Mega. All rights reserved.
//

#import "LYModelTransitionDelegate.h"
#import "LYDemoViewController.h"

@interface LYDemoViewController ()
@property (strong , nonatomic) LYModelTransitionDelegate *modelDelegate;
@property (strong , nonatomic) NSLayoutConstraint *heightCon;
@end

@implementation LYDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"dismiss" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(dismissClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button setFrame:CGRectMake(20, 40, 0, 0)];
    [button sizeToFit];
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
            [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        }];
        
        
    }];
    
    
    self.transitioningDelegate = self.modelDelegate;
    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;

    [fromViewController presentViewController:self animated:YES completion:nil];
    

}

@end
