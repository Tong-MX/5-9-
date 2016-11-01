//
//  BTTopBarViewController.m
//  BTProject
//
//  Created by 明桐的Mac on 16/3/22.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTTopBarViewController.h"

@implementation BTTopBarViewController
- (void)dealloc {
    
    self.navigationBar = nil;
}

- (void)viewDidLoad {
    
    [self initNavigationBar];
    [super viewDidLoad];
    
}

- (void)initParameters {
    
}

- (void)initSize {
    [super initSize];
}

- (void)initNavigationBar {
    self.navigationBar = [[BTNavigationBar alloc] initWithFrame: CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, HKControllerViewWidth, [BTResource topBarHeight])];
    _navigationBar.backgroundColor = [UIColor clearColor];
    _navigationBar.delegate = self;
    [self.view addSubview: _navigationBar];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftButtonAction {
    [self backAction];
}

- (void)backAction {
    if (self.logTagName) {
        [BTLog trace: self.logTagName Content: @"返回"];
    }
    
    [self.navigationController popViewControllerAnimated: YES];
}

- (BOOL)rightButtonAction {
    
    return YES;
}

- (void)leftTwoButtonAction {
    
}
- (void)setNavigationBarBgColor: (UIColor*)color Alpha: (CGFloat)alpha {
    
    self.navigationBar.bgImgView.backgroundColor = color;
    self.navigationBar.bgImgView.alpha = alpha;
}

- (void)setNavigationBarBgImg: (UIImage*)img {
    self.navigationBar.bgImgView.image = img;
}

- (void)setNavigationBarTitleText: (NSString*)text Color: (UIColor*)color Font:(UIFont*)font Bold:(CGFloat)bold{
    self.navigationBar.titleLabel.text = text;
    self.navigationBar.titleLabel.textColor = color;
    self.navigationBar.titleLabel.font = font;
    if (bold > 0) {
        self.navigationBar.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:bold];
    }
}

- (void)setNavigationBarTitleColor: (UIColor*)color {
    self.navigationBar.titleLabel.textColor = color;
}

- (void)setNavigationBarLeftButtonBgImg: (UIImage*)img TouchImg: (UIImage*)touchImg Text: (NSString*)text {
    [self.navigationBar setLeftButtonImg: img TouchImg: touchImg Text: text];
}

- (void)setNavigationBarRightButtonBgImg: (UIImage*)img TouchImg: (UIImage*)touchImg Text: (NSString*)text {
    [self.navigationBar setRightButtonImg: img TouchImg:touchImg Text: text];
}

- (void)hiddelNavigationTitle: (BOOL)show {
    self.navigationBar.titleLabel.hidden = show;
}

- (void)hiddenLeftButton: (BOOL)show {
    [self.navigationBar hiddenLeftButton: show];
}

- (void)hiddenRightButton: (BOOL)show {
    [self.navigationBar hiddenRightButton: show];
}

- (void)hiddenLeftTwoButton: (BOOL)show {
    [self.navigationBar hiddenLeftTwoButton: show];
}

- (void)hiddenRedRemindButton: (BOOL)show{
    [self.navigationBar hiddenRedRemindButton: show];
}

- (void)hiddenTitleTwoBtnWithBtnFirst:(NSString*)btnFirst BtnSec:(NSString*)btnSec TitleImge:(UIImage*)titleImge {
    [self.navigationBar titileFirstBtn:btnFirst SecBtnImag:btnSec TitlImge:titleImge];
}
- (void)hiddenNav: (BOOL)show{

    self.navigationBar.hidden = show;
}

- (void)alphaNav: (CGFloat)alpha{
    
    self.navigationBar.alpha = alpha;
}
- (void)enabledRightButton: (BOOL)enable {
    [self.navigationBar enabledRightButton: enable];
}

- (void)enabledLeftButton: (BOOL)enable {
    [self.navigationBar enabledLeftButton: enable];
}

- (void)addKeyboardObserver{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}

-(void)KeyboardWillHide:(NSNotification *)sender{
    
}

-(void)KeyboardWillShow:(NSNotification *)sender{
    
}


- (void)pushContrllerWithType:(NSString*)type Subtype:(NSString*)subtype Duration:(CFTimeInterval)duration {
    CATransition *transition = [CATransition animation];
    transition.duration = duration;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = type;
    transition.subtype = subtype;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    //dismiss动画效果
    //    controller.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    //    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //    [self presentViewController:controller animated:YES completion:^{
    //    }];
}
@end
