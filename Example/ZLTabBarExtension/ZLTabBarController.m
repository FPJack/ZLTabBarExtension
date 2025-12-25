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
#import <objc/runtime.h>

@interface ZLTabBarController ()<UITabBarControllerDelegate>

@end

@implementation ZLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UITabBarAppearance *appearance = [[UITabBarAppearance alloc] init];
    appearance.backgroundColor = UIColor.whiteColor;
    appearance.shadowColor = UIColor.redColor;

    self.tabBar.standardAppearance = appearance;
    if (@available(iOS 15.0, *)) {
        self.tabBar.scrollEdgeAppearance = appearance;
    }
    
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
            tabBarButton.frame = CGRectMake(tabBarButton.frame.origin.x, - CGRectGetHeight(tabBarButton.frame) / 2, tabBarButton.frame.size.width, tabBarButton.frame.size.height);
            UIImageView *imgView = tabBar.tabBarButtonItems[index].imageView;
            [self zl_addTopHalfCircleLineToView:imgView radius:CGRectGetWidth(imgView.frame) / 2.0 lineWidth:0.5 lineColor:UIColor.redColor];
           
        }
    };
    self.delegate =  self;
    
}
- (CAShapeLayer *)zl_addTopHalfCircleLineToView:(UIView *)view
                                         radius:(CGFloat)radius
                                      lineWidth:(CGFloat)lineWidth
                                      lineColor:(UIColor *)lineColor {
    [view.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    // 半圆中心点（view 顶部居中）
    CGPoint center = CGPointMake(CGRectGetWidth(view.bounds) / 2.0, radius);
    // 半圆路径（180°）
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center
                                                        radius:radius
                                                    startAngle:M_PI
                                                      endAngle:0
                                                     clockwise:YES];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = lineColor.CGColor;
    shapeLayer.fillColor = UIColor.clearColor.CGColor;
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.lineCap = kCALineCapRound;
    
    [view.layer addSublayer:shapeLayer];
    return shapeLayer;
}



#pragma mark - UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController
 didSelectViewController:(UIViewController *)viewController {
    NSUInteger index = [tabBarController.viewControllers indexOfObject:viewController];
    ZLTabBarButtonItem *item = self.tabBar.tabBarButtonItems[index];
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
