//
//  LYViewController.m
//  LYProtocolAnimation
//
//  Created by Mega on 09/29/2018.
//  Copyright (c) 2018 Mega. All rights reserved.
//"
#import "LYDemoViewController.h"
#import "LYViewController.h"

@interface LYViewController ()

@end

@implementation LYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (IBAction)present:(id)sender {
    LYDemoViewController *vc = [[LYDemoViewController alloc]init];
    [vc customPresentedFromViewController:self];
}



@end
