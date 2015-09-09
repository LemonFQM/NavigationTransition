//
//  PushViewController.m
//  NavigationTransition
//
//  Created by Topband on 15/9/8.
//  Copyright (c) 2015年 Topband. All rights reserved.
//

#import "PushViewController.h"

@interface PushViewController ()

@end

@implementation PushViewController

- (UIColor *)randomColor
{
    return [UIColor colorWithRed:((CGFloat)(arc4random() % 255)) / 255.f
                           green:((CGFloat)(arc4random() % 255)) / 255.f
                            blue:((CGFloat)(arc4random() % 255)) / 255.f
                           alpha:1.0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [self randomColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
