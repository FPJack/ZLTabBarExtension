//
//  UITabBar+ZLExtension.h
//  ZLTabBarExtension
//
//  Created by admin on 2025/12/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITabBar (ZLExtension)
/// A block that is called during layoutSubviews of the UITabBar.
@property (nonatomic,copy)void (^layoutSubviewsBlock)(UITabBar *tabBar,UIView *tabBarButton,NSInteger index);
@end

NS_ASSUME_NONNULL_END
