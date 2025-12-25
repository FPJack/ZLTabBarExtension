//
//  ZLTabBarController.m
//  ZLTabBarExtension_Example
//
//  Created by admin on 2025/12/25.
//  Copyright © 2025 fanpeng. All rights reserved.
//

#import "ZLTabBarController.h"
#import "ZLNavigationController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThreeViewController.h"
#import <ZLTabBarExtension/ZLTabBarExtension.h>
@interface ZLTabBarController ()<UITabBarControllerDelegate>

@end

@implementation ZLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZLNavigationController *firstNav = [[ZLNavigationController alloc] initWithRootViewController:[[FirstViewController alloc] init]];
    firstNav.tabBarItem.title = @"First";
    firstNav.tabBarItem.image = [UIImage systemImageNamed:@"1.circle"];
    
    ZLNavigationController *secondNav = [[ZLNavigationController alloc] initWithRootViewController:[[SecondViewController alloc] init]];
    secondNav.tabBarItem.title = @"";
    secondNav.tabBarItem.image = [[UIImage imageNamed:@"post_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    secondNav.tabBarItem.selectedImage = [[UIImage imageNamed:@"post_highlight"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    ZLNavigationController *threeNav = [[ZLNavigationController alloc] initWithRootViewController:[[ThreeViewController alloc] init]];
    threeNav.tabBarItem.title = @"Three";
    threeNav.tabBarItem.image = [UIImage systemImageNamed:@"3.circle"];
    
    self.viewControllers = @[firstNav, secondNav, threeNav];
    
    self.tabBar.layoutSubviewsBlock = ^(UITabBar * _Nonnull tabBar, UIView * _Nonnull tabBarButton, NSInteger index) {
        if (index == 1) {
            tabBarButton.frame = CGRectMake(tabBarButton.frame.origin.x, tabBarButton.frame.origin.y - 15, tabBarButton.frame.size.width, tabBarButton.frame.size.height);
        }
    };
    self.delegate =  self;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController
 didSelectViewController:(UIViewController *)viewController {
    NSUInteger index = [tabBarController.viewControllers indexOfObject:viewController];
    [self animateTabBarItemAtIndex:index];
}
- (void)animateTabBarItemAtIndex:(NSInteger)index {
    ZLTabBarButtonItem *item = self.tabBar.tabBarButtonItems[index];
    [self addScaleAnimationToView:item.imageView];
    
//    [self transform:item.imageView];
    
//    [self fadeAnimation:item.imageView];
//    [self transformZ:item.imageView];
   // [self transform3D:item.imageView];

}

- (void)addScaleAnimationToView:(UIView *)iconView {
    CABasicAnimation *animation =
    [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = @0.8;
    animation.toValue   = @1.2;
    animation.duration  = 0.2;
    animation.autoreverses = YES;
    animation.timingFunction =
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [iconView.layer addAnimation:animation forKey:nil];
}
- (void)transform:(UIView *)iconView {
    [UIView animateWithDuration:0.15 animations:^{
        iconView.transform = CGAffineTransformMakeTranslation(0, -6);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            iconView.transform = CGAffineTransformIdentity;
        }];
    }];

}
- (void)fadeAnimation:(UIView *)iconView {
    iconView.alpha = 0.5;
    [UIView animateWithDuration:0.2 animations:^{
        iconView.alpha = 1.0;
    }];


}
- (void)transformZ:(UIView *)iconView {
    [UIView animateWithDuration:0.3 animations:^{
        iconView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI);
    } completion:^(BOOL finished) {
        iconView.transform = CGAffineTransformIdentity;
    }];



}
- (void)transform3D:(UIView *)iconView {
    CATransform3D t = CATransform3DIdentity;
    t.m34 = -1.0 / 500;

    [UIView animateWithDuration:0.3 animations:^{
        iconView.layer.transform = CATransform3DRotate(t, M_PI, 0, 1, 0);
    } completion:^(BOOL finished) {
        iconView.layer.transform = CATransform3DIdentity;
    }];



}
@end
