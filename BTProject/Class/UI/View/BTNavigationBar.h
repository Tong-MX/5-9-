//
//  HKNavigationBar.h
//  BTProject
//
//  Created by 明桐的Mac on 16/3/22.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTObjectView.h"
@protocol HKNavigationBarDelegate<NSObject>

- (void)leftButtonAction;
- (BOOL)rightButtonAction;
- (void)leftTwoButtonAction;
- (void)titleTwoBtnAction:(UIButton*)btn;

@end


@interface BTNavigationBar : BTObjectView

@property (strong) UIImageView *bgImgView;
@property (strong) UIButton *leftButton;
@property (strong) UIButton *rightButton;
@property (strong) UILabel *titleLabel;
@property (nonatomic ,strong) UIButton *titleFirBtn;
@property (nonatomic ,strong) UIButton *titleSecBtn;
@property (strong) UIImageView *titleImage;
@property (strong) UIButton *leftTwoButton;

@property (assign) id<HKNavigationBarDelegate> delegate;


- (void)setLeftButtonImg: (UIImage*)img TouchImg: (UIImage*)touchImg Text: (NSString*)text;
- (void)setRightButtonImg:(UIImage *)img TouchImg: (UIImage*)touchImg Text: (NSString*)text;

- (void)hiddenLeftButton: (BOOL)hidden;
- (void)hiddenRightButton: (BOOL)hidden;

- (void)enabledRightButton: (BOOL)enable;
- (void)enabledLeftButton: (BOOL)enable;

- (void)hiddenLeftTwoButton: (BOOL)hidden;
- (void)hiddenRedRemindButton: (BOOL)hidden;

- (void)titileFirstBtn:(NSString*)fistStr SecBtnImag:(NSString*)secStr TitlImge:(UIImage*)titleImage;

@end
