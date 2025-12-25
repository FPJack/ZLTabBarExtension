//
//  UITabBar+ZLExtension.m
//  ZLTabBarExtension
//
//  Created by admin on 2025/12/25.
//

#import "UITabBar+ZLExtension.h"
#import <objc/runtime.h>
@implementation ZLTabBarButtonItem
- (UIImageView *)imageView {
    if (!_imageView) {
        __block UIImageView *imgView;
        [self findSubviewInView:self.tabBarButton matchBlock:^BOOL(__kindof UIView *subView) {
            if ([subView isKindOfClass:UIImageView.class]) {
                imgView = subView;
            }
            return NO;
        }];
        _imageView =  imgView;
    }
    return _imageView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        __block UILabel *label;
        [self findSubviewInView:self.tabBarButton matchBlock:^BOOL(__kindof UIView *subView) {
            if ([subView isKindOfClass:UILabel.class] && CGRectGetMaxY(subView.frame) > CGRectGetHeight(self.tabBarButton.frame) / 2.0) {
                label = subView;
            }
            return NO;
        }];
        _titleLabel = label;
    }
    return _titleLabel;
}
- (UILabel *)badgeLabel {
    if (!_badgeLabel) {
        __block UILabel *label;
        [self findSubviewInView:self.tabBarButton matchBlock:^BOOL(__kindof UIView *subView) {
            if ([subView isKindOfClass:UILabel.class] && CGRectGetMinY(subView.frame) < CGRectGetHeight(self.tabBarButton.frame) / 2.0) {
                label = subView;
            }
            return NO;
        }];
        _badgeLabel = label;
    }
    return _badgeLabel;
}
- (__kindof UIView *)findSubviewInView:(UIView *)view
                               matchBlock:(BOOL (^)(__kindof UIView *subView))matchBlock {
    if (!view || !matchBlock) return nil;
    for (UIView *subView in view.subviews) {
        // 先判断当前 subView
        if (matchBlock(subView)) {
            return subView;
        }
        // 递归查找子层级
        UIView *found = [self findSubviewInView:subView matchBlock:matchBlock];
        if (found) {
            return found;
        }
    }
    return nil;
}
@end

@interface UITabBar()
@property (nonatomic,readwrite)NSArray<ZLTabBarButtonItem *> *tabBarButtonItems;
@end
@implementation UITabBar (ZLExtension)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self __zl_hook_swizzleInstanceMethod:@selector(layoutSubviews) with: @selector(__tab_hook_layoutSubviews)];
        [self __zl_hook_swizzleInstanceMethod:@selector(hitTest:withEvent:) with: @selector(__tab_hook_hitTest:withEvent:)];
    });
}
+ (BOOL)__zl_hook_swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel {
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    if (!originalMethod || !newMethod) return NO;
    class_addMethod(self,
                    originalSel,
                    class_getMethodImplementation(self, originalSel),
                    method_getTypeEncoding(originalMethod));
    class_addMethod(self,
                    newSel,
                    class_getMethodImplementation(self, newSel),
                    method_getTypeEncoding(newMethod));
    
    method_exchangeImplementations(class_getInstanceMethod(self, originalSel),
                                   class_getInstanceMethod(self, newSel));
    return YES;
}
- (void)setLayoutSubviewsBlock:(void (^)(UITabBar * _Nonnull, UIView * _Nonnull, NSInteger))layoutSubviewsBlock {
    objc_setAssociatedObject(self, @selector(layoutSubviewsBlock), layoutSubviewsBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(UITabBar * _Nonnull, UIView * _Nonnull, NSInteger))layoutSubviewsBlock {
    return objc_getAssociatedObject(self, @selector(layoutSubviewsBlock));
}
- (void)setTabBarButtonItems:(NSArray<ZLTabBarButtonItem *> *)sortedSubviews {
    objc_setAssociatedObject(self, @selector(tabBarButtonItems), sortedSubviews, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSArray<ZLTabBarButtonItem *> *)tabBarButtonItems {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)__tab_hook_layoutSubviews {
    [self __tab_hook_layoutSubviews];
    NSMutableArray <UIView *> *subviews = self.subviews.mutableCopy;
    [subviews enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj isKindOfClass:UIControl.class]) {
            [subviews removeObjectAtIndex:idx];
        }
    }];

    NSArray *sortedSubviews = [subviews sortedArrayUsingComparator:^NSComparisonResult(UIView * formerView, UIView * latterView) {
        CGFloat formerViewX = formerView.frame.origin.x;
        CGFloat latterViewX = latterView.frame.origin.x;
        return  (formerViewX > latterViewX) ? NSOrderedDescending : NSOrderedAscending;
    }];
    
    NSMutableArray *tabBarButtonItems = NSMutableArray.array;
    [sortedSubviews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ZLTabBarButtonItem *item = ZLTabBarButtonItem.new;
        item.tabBarButton = obj;
        [tabBarButtonItems addObject:item];
    }];
    self.tabBarButtonItems = tabBarButtonItems.copy;
    
    
    [sortedSubviews enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.layoutSubviewsBlock) {
            self.layoutSubviewsBlock(self,obj,idx);
        }
    }];
}

- (UIView *)__tab_hook_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    __block UIView *view = nil;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (CGRectContainsPoint(obj.frame, point)) {
            view = obj;
        }
    }];
    if (view) return view;
    return [super hitTest:point withEvent:event];
}
@end
