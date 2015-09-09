//
//  NavigationTransition.h
//  NavigationTransition
//
//  Created by Topband on 15/9/8.
//  Copyright (c) 2015年 Topband. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NavigationTransition : NSObject<UINavigationControllerDelegate, UIViewControllerAnimatedTransitioning>

@property (nonatomic, weak) UINavigationController *navigationController;

@end
