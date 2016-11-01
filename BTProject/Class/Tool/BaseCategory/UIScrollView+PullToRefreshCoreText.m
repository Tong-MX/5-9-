//
//  UIScrollView+PullToRefreshCoreText.m
//  BTProject
//
//  Created by 明桐的Mac on 16/4/21.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "UIScrollView+PullToRefreshCoreText.h"
#import <objc/runtime.h>
#define DefaultTextColor    [UIColor blackColor]
#define DefaultTextFont     [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:30]
@interface UIScrollView ()
@property (nonatomic, strong) RefreshHeaderView *mjRefreshHeaderView;
@end
@implementation UIScrollView (PullToRefreshCoreText)

- (void)addPullToRefreshWithPullText:(NSString *)pullText
                       pullTextColor:(UIColor *)pullTextColor
                        pullTextFont:(UIFont *)pullTextFont
                      refreshingText:(NSString *)refreshingText
                 refreshingTextColor:(UIColor *)refreshingTextColor
                  refreshingTextFont:(UIFont *)refreshingTextFont
                              action:(pullToRefreshAction)action {
    
    if (self.pullToRefreshView) return;
    
    float ptrH = [self labelHeightForString:pullText labelWidth:self.bounds.size.width andFont:pullTextFont];
    CGRect ptrRect = CGRectMake(0, -ptrH - 10, self.bounds.size.width, ptrH);
    
    self.pullToRefreshView = [[RefreshHeaderView alloc] initWithFrame:ptrRect pullText:pullText pullTextColor:pullTextColor pullTextFont:pullTextFont refreshingText:refreshingText refreshingTextColor:refreshingTextColor refreshingTextFont:refreshingTextFont action:action];
    [self.pullToRefreshView setScrollView:self];
    [self addSubview:self.pullToRefreshView];
}


#pragma mark - Loading

- (void)finishLoading {
    [self.pullToRefreshView endLoading];
}


#pragma mark - Utils

- (CGFloat)labelHeightForString:(NSString*)string labelWidth:(float)width andFont:(UIFont*)font {
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: font}];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return rect.size.height;
}


#pragma mark - Properties

- (void)setPullToRefreshView:(RefreshHeaderView *)pullToRefreshView {
    objc_setAssociatedObject(self, @selector(pullToRefreshView), pullToRefreshView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (RefreshHeaderView *)pullToRefreshView {
    return objc_getAssociatedObject(self, @selector(pullToRefreshView));
}
@end
