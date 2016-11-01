//
//  RegisterController.m
//  BTProject
//
//  Created by 明桐的Mac on 16/4/27.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTRegisterController.h"
@interface BTRegisterController()
@end
@implementation BTRegisterController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatLoadingView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)creatLoadingView {
    UIButton *btnClose = [BTCommonUtil createButtonFrame:CGRectMake(15, 15, 45, 45) Target:self BgColor:nil Title:nil TitleColor:nil BgImg:[UIImage imageNamed:@"login_close_btn"] action:@selector(backClickAction) Tag:0];
    UILabel *registerLabel = [BTCommonUtil createLabelFrame:CGRectMake(HKUIScreenWidth - (HKUIScreenWidth/3)-15, 25, HKUIScreenWidth/3, 20) BgColor:nil Text:@"手机号注册/登陆" textColor:BTColor(133, 133, 133) Font:[UIFont systemFontOfSize:12] TextAlignment:NSTextAlignmentRight Tag:0];
    
    UIImageView *imageBTview = [BTCommonUtil createImageViewFrame:CGRectMake(HKUIScreenWidth/2 - (147/2), HKUIScreenHeight/5, 147, 125.5) BgColor:[UIColor clearColor] Img:[UIImage imageNamed:@"BT"] Tag:0];

    UIImageView *lodingImageView = [BTCommonUtil createImageViewFrame:CGRectMake(HKUIScreenWidth/2 - (216.5/2), HKUIScreenHeight/1.3 + 31, 216.5, 16.5) BgColor:nil Img:[UIImage imageNamed:@"longin_type_icon"] Tag:0];
    
    NSArray *arry = @[@"wechat",@"qq_icon",@"weibo_icon"];
    [arry enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *weChatBtn = [BTCommonUtil createButtonFrame:CGRectMake(lodingImageView.left + (idx * 90), lodingImageView.top + lodingImageView.height + 20, 41, 41) Target:self BgColor:nil Title:nil TitleColor:nil BgImg:[UIImage imageNamed:obj] action:@selector(weChatClick) Tag:0];
        [self.view addSubview:weChatBtn];
    }];
    
    [self.view addSubview:btnClose];
    [self.view addSubview:registerLabel];
    [self.view addSubview:imageBTview];
    [self.view addSubview:lodingImageView];
}

- (void)weChatClick {
    NSLog(@"登陆");
}
- (void)backClickAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
