# ZLTabBarExtension
一个简单block回调实现自定义UITabBarButton的展示，类似咸鱼等App上按钮突出的效果，以及轻松拿到TabBarButton上的UIImageView和UILabel进行自定义动画

```ruby
pod 'ZLTabBarExtension'
```

```ruby

    self.tabBar.layoutSubviewsBlock = ^(UITabBar * _Nonnull tabBar, UIView * _Nonnull tabBarButton, NSInteger index) {
        if (index == 1) {
            tabBarButton.frame = CGRectMake(tabBarButton.frame.origin.x, tabBarButton.frame.origin.y - 15, tabBarButton.frame.size.width, tabBarButton.frame.size.height);
        }
    };
```


## Author

fanpeng, peng.fan@ukelink.com

## License

ZLTabBarExtension is available under the MIT license. See the LICENSE file for more info.
