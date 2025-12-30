# ZLTabBarExtension

<img src="https://github.com/FPJack/ZLTabBarExtension/blob/master/test.GIF" width="40%" height="40%">  


一个简单block回调实现自定义UITabBarButton的展示，类似咸鱼等App上按钮突出的效果，以及轻松拿到TabBarButton上的UIImageView和UILabel进行自定义动画

```ruby
pod 'ZLTabBarExtension'
```
调整UITabBarButton
```ruby

    self.tabBar.layoutSubviewsBlock = ^(UITabBar * _Nonnull tabBar, UIView * _Nonnull tabBarButton, NSInteger index) {
        if (index == 1) {
            tabBarButton.frame = CGRectMake(tabBarButton.frame.origin.x, tabBarButton.frame.origin.y - 15, tabBarButton.frame.size.width, tabBarButton.frame.size.height);
        }
    };
```

自定义Icon动画
```ruby

   #pragma mark - UITabBarControllerDelegate
   
    - (void)tabBarController:(UITabBarController *)tabBarController
     didSelectViewController:(UIViewController *)viewController {
        NSUInteger index = [tabBarController.viewControllers indexOfObject:viewController];
        ZLTabBarButtonItem *item = self.tabBar.tabBarButtonItems[index];
        CABasicAnimation *animation =
        [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        animation.fromValue = @0.8;
        animation.toValue   = @1.2;
        animation.duration  = 0.2;
        animation.autoreverses = YES;
        animation.timingFunction =
        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [item.imageView.layer addAnimation:animation forKey:nil];
    }

```


## Author

fanpeng, 2551412939@qq.com

## License

ZLTabBarExtension is available under the MIT license. See the LICENSE file for more info.
