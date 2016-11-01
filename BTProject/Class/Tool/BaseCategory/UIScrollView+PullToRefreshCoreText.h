//
//  UIScrollView+PullToRefreshCoreText.h
//  BTProject
//
//  Created by 明桐的Mac on 16/4/21.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshHeaderView.h"
typedef void(^pullToRefreshAction)(void);
@interface UIScrollView (PullToRefreshCoreText)

- (void)addPullToRefreshWithPullText:(NSString *)pullText
                       pullTextColor:(UIColor *)pullTextColor
                        pullTextFont:(UIFont *)pullTextFont
                      refreshingText:(NSString *)refreshingText
                 refreshingTextColor:(UIColor *)refreshingTextColor
                  refreshingTextFont:(UIFont *)refreshingTextFont
                              action:(pullToRefreshAction)action;
- (void)finishLoading;
@end
