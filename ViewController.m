//
//  ViewController.m
//  NavigationTransition
//
//  Created by Topband on 15/9/8.
//  Copyright (c) 2015年 Topband. All rights reserved.
//

#import "ViewController.h"
#import "NavigationTransition.h"

@interface ViewController ()

@property (nonatomic, strong) NavigationTransition *navigationTransition;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.delegate = self.navigationTransition;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NavigationTransition *)navigationTransition
{
    if (!_navigationTransition)
    {
        _navigationTransition = [[NavigationTransition alloc] init];
        _navigationTransition.navigationController = self.navigationController;
    }
    return _navigationTransition;
}


@end
