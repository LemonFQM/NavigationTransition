//
//  NavigationTransition.m
//  NavigationTransition
//
//  Created by Topband on 15/9/8.
//  Copyright (c) 2015年 Topband. All rights reserved.
//

#import "NavigationTransition.h"

@interface NavigationTransition ()

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTransition;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@end

@implementation NavigationTransition

#pragma mark - action
- (void)pan:(UIPanGestureRecognizer *)gesture
{
    static BOOL isMove = NO;
    CGFloat progress = [gesture translationInView:self.navigationController.view].x / (self.navigationController.view.bounds.size.width * 1.0);
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        if (self.navigationController.viewControllers.count > 1)
        {
            CGPoint velocity = [gesture velocityInView:self.navigationController.view];
            
            if (ABS(velocity.x) < 1000)
            {
                self.interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
                [self.navigationController popViewControllerAnimated:YES];
                isMove = YES;
            } else
            {
                isMove = NO;
            }
        }
        
    } else if (gesture.state == UIGestureRecognizerStateChanged)
    {
        if (isMove)
            [self.interactiveTransition updateInteractiveTransition:progress];
    } else
    {
        if (progress >= 0.25)
        {
            [self.interactiveTransition finishInteractiveTransition];
        } else
        {
            [self.interactiveTransition cancelInteractiveTransition];
        }
        self.interactiveTransition = nil;
    }
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    [[transitionContext containerView] addSubview:toViewController.view];
    [[transitionContext containerView] sendSubviewToBack:toViewController.view];

    CGRect finalFrame = [transitionContext finalFrameForViewController:toViewController];
    toViewController.view.frame = CGRectOffset(finalFrame, -CGRectGetWidth(finalFrame) / 3.f, 0);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromViewController.view.transform = CGAffineTransformMakeTranslation(CGRectGetWidth(fromViewController.view.bounds), 0);
        toViewController.view.frame = finalFrame;
    } completion:^(BOOL finished) {
        fromViewController.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

#pragma mark = UINavigationControllerDelegate
- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    return self.interactiveTransition;
}

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPop)
    {
        return self;
    }
    return nil;
}

#pragma mark - getter setter
- (void)setNavigationController:(UINavigationController *)navigationController
{
    _navigationController = navigationController;
    if (![_navigationController.view.gestureRecognizers containsObject:self.pan])
    {
        [_navigationController.view addGestureRecognizer:self.pan];
    }
}

- (UIPanGestureRecognizer *)pan
{
    if (!_pan)
    {
        _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    }
    return _pan;
}
@end
