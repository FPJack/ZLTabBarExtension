//
//  UITabBar+ZLExtension.h
//  ZLTabBarExtension
//
//  Created by admin on 2025/12/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLTabBarButtonItem : NSObject
@property(nonatomic,weak)UIView *tabBarButton;
@property (nonatomic,weak)UIImageView *imageView;
@property (nonatomic,weak)UILabel *titleLabel;
@property (nonatomic,weak)UILabel *badgeLabel;
@end

@interface UITabBar (ZLExtension)
/// 自定义布局每个UITabBarButton
@property (nonatomic,copy)void (^layoutSubviewsBlock)(UITabBar *tabBar,UIView *tabBarButton,NSInteger index);
///获取每个UITabBarButtonItem
@property (nonatomic,readonly)NSArray<ZLTabBarButtonItem *> *tabBarButtonItems;
@end

NS_ASSUME_NONNULL_END
