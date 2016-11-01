//
//  BTTopBarViewController.h
//  BTProject
//
//  Created by 明桐的Mac on 16/3/22.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BaseViewController.h"
#import "BTNavigationBar.h"
#import "BaseNavigationController.h"
@interface BTTopBarViewController : BaseViewController<HKNavigationBarDelegate>

@property (nonatomic ,strong) BaseNavigationController *nav;
@property (nonatomic ,strong) BTNavigationBar *navigationBar;

@property (nonatomic, assign) BOOL noReturnLastVC;// 是否正常返回（返回到上个controller）// no 正常返回

#pragma mark 返回
- (void)backAction;

#pragma mark 给导航栏设置颜色
- (void)setNavigationBarBgColor: (UIColor*)color Alpha: (CGFloat)alpha;
#pragma mark 给导航栏设置图片
- (void)setNavigationBarBgImg: (UIImage*)img;
#pragma mark 给导航栏设置标题 和标题颜色 bold加粗不加粗传0
- (void)setNavigationBarTitleText: (NSString*)text Color: (UIColor*)color Font:(UIFont*)font Bold:(CGFloat)bold;
#pragma mark 给导航栏设置标题颜色
- (void)setNavigationBarTitleColor: (UIColor*)color;

#pragma mark 给导航栏左边按钮添加图片功能和文字
- (void)setNavigationBarLeftButtonBgImg: (UIImage*)img TouchImg: (UIImage*)touchImg Text: (NSString*)text;
- (void)setNavigationBarRightButtonBgImg: (UIImage*)img TouchImg: (UIImage*)touchImg Text: (NSString*)text;

- (void)hiddelNavigationTitle: (BOOL)show;

- (void)hiddenLeftButton: (BOOL)show;
- (void)hiddenRightButton: (BOOL)show;
- (void)hiddenRedRemindButton: (BOOL)show;


- (void)hiddenLeftTwoButton: (BOOL)show;

- (void)hiddenNav: (BOOL)show;
- (void)alphaNav: (CGFloat)alpha;//是否隐藏导航栏
- (void)enabledRightButton: (BOOL)enable;
- (void)enabledLeftButton: (BOOL)enable;

- (BOOL)rightButtonAction;

#pragma mark 题目为两个按钮的
- (void)hiddenTitleTwoBtnWithBtnFirst:(NSString*)btnFirst BtnSec:(NSString*)btnSec TitleImge:(UIImage*)titleImge;

#pragma mark 监听键盘
- (void)addKeyboardObserver;

#pragma mark push动画
- (void)pushContrllerWithType:(NSString*)type Subtype:(NSString*)subtype Duration:(CFTimeInterval)duration;
@end
