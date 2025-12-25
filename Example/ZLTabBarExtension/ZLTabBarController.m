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
@interface ZLTabBarController ()

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
            tabBarButton.frame = CGRectMake(tabBarButton.frame.origin.x, tabBarButton.frame.origin.y - 20, tabBarButton.frame.size.width, tabBarButton.frame.size.height);
        }
    };
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
