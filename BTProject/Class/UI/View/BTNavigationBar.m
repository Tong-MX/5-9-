//
//  HKNavigationBar.m
//  BTProject
//
//  Created by 明桐的Mac on 16/3/22.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTNavigationBar.h"

#define UILeftDis 5
#define UIRightDis 10
#define UILeftTextDis  10
#define UIRightTextDis 10

@interface BTNavigationBar()
{
    CGFloat leftDis;
    CGFloat leftTextDis;
    CGFloat rightDis;
    CGFloat rightTextDis;
    
    CGFloat leftButtonDis;
    CGFloat leftButtonTextDis;
}
@end
@implementation BTNavigationBar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    
    if (self) {
        
        [self initBgImgView];
        [self initTitleLabel];
        [self initLeftButton];
        [self initTwoTitleBtn];
//        [self initLeftTwoButton];
        [self initRightButton];
//        [self initRedRemindButton];
    }
    
    return self;
}

- (void)initBgImgView {
    self.bgImgView = [BTCommonUtil createImageViewFrame: self.bounds BgColor: [UIColor clearColor] Img: [UIImage imageNamed: @"gg_q001_01"] Tag: 1];
    
    [self addSubview: _bgImgView];
}
- (void)initLeftButton {
    UIImage *leftButtonImg = [UIImage imageNamed: @""];
    CGSize leftButtonSize = [BTCommonUtil HKImageSize: leftButtonImg];
    self.leftButton = [BTCommonUtil createButtonFrame: CGRectMake(leftDis, [BTResource topStatusBarHeight] + [BTCommonUtil viewTopBottomAlignOutH: [BTResource navigationBarHeight] InH: leftButtonSize.height], leftButtonSize.width, leftButtonSize.height) Target: self BgColor: [UIColor clearColor] Title: nil TitleColor: nil BgImg: leftButtonImg action: @selector(leftButtonAction:) Tag: 1];
    
    [self addSubview: _leftButton];
}

- (void)initTitleLabel {
    
    self.titleLabel = [BTCommonUtil createLabelFrame: CGRectMake(HKViewWidth*0.2, [BTResource topStatusBarHeight], HKViewWidth*0.6, HKViewHeight - [BTResource topStatusBarHeight]) BgColor: [UIColor clearColor] Text: @"" textColor: UIColorC3 Font: UISystemFontT7 TextAlignment: NSTextAlignmentCenter Tag: 1];
    self.titleLabel.text = @"";
    
    [self addSubview: _titleLabel];
}

#pragma mark 两个标题按钮
- (void)initTwoTitleBtn {
    self.titleFirBtn = [BTCommonUtil createButtonFrame:CGRectMake(HKViewWidth*0.11, [BTResource topStatusBarHeight], HKViewWidth*0.6, HKViewHeight - [BTResource topStatusBarHeight]) Target:self BgColor:nil Title:@"" TitleColor:[UIColor grayColor] BgImg:nil action:@selector(oneTitleClick:) Tag:0];
    self.titleFirBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleFirBtn.hidden = YES;
    self.titleFirBtn.selected = YES;
    [self.titleFirBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    self.titleSecBtn = [BTCommonUtil createButtonFrame:CGRectMake(HKViewWidth*0.28, [BTResource topStatusBarHeight], HKViewWidth*0.6, HKViewHeight - [BTResource topStatusBarHeight]) Target:self BgColor:nil Title:@"" TitleColor:[UIColor grayColor] BgImg:nil action:@selector(oneTitleClick:) Tag:1];
    self.titleSecBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleSecBtn.hidden = YES;
    self.titleSecBtn.selected = NO;
    [self.titleSecBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    self.titleImage = [BTCommonUtil createImageViewFrame:CGRectMake(HKViewWidth/2 - 1, [BTResource topStatusBarHeight] + 15, 1, 15) BgColor:nil Img:nil Tag:0];
    self.titleImage.hidden = YES;
    
    [self addSubview:_titleFirBtn];
    [self addSubview:_titleSecBtn];
    [self addSubview:_titleImage];
}

- (void)titileFirstBtn:(NSString*)fistStr SecBtnImag:(NSString*)secStr TitlImge:(UIImage*)titleImage {
    
    self.titleFirBtn.hidden = NO;
    self.titleSecBtn.hidden = NO;
    self.titleImage.hidden = NO;
    [self.titleFirBtn setTitle:fistStr forState:UIControlStateNormal];
    [self.titleSecBtn setTitle:secStr forState:UIControlStateNormal];
    self.titleImage.image = titleImage;
}
- (void)oneTitleClick:(UIButton*)btn{
    _titleFirBtn.selected = !_titleSecBtn.selected;
//    .selected = !_titleSecBtn.selected;
    if ([_delegate respondsToSelector:@selector(titleTwoBtnAction:)]) {
        [_delegate titleTwoBtnAction:btn];
    }
}
- (void)initRightButton {
    CGRect rightButtonFrame = _leftButton.frame;
    rightButtonFrame.origin.x = HKViewWidth - rightButtonFrame.size.width - rightDis;
    
    self.rightButton = [BTCommonUtil createButtonFrame: rightButtonFrame Target: self BgColor:[UIColor clearColor] Title: @"" TitleColor: [UIColor clearColor] BgImg: [UIImage imageNamed: @""] action: @selector(rightButtonAction:) Tag: 1];
    _rightButton.hidden = YES;
    [self addSubview: _rightButton];
}

- (void)leftButtonAction: (UIButton*)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(leftButtonAction)]) {
        [self.delegate leftButtonAction];
    }
}

- (void)rightButtonAction: (UIButton*)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(rightButtonAction)]) {
        [self.delegate rightButtonAction];
    }
}

- (void)setLeftButtonImg: (UIImage*)img TouchImg: (UIImage*)touchImg Text: (NSString*)text {
    CGRect rect = CGRectMake(BTZero, BTZero, BTZero, BTZero);
    CGSize buttonSize;
    UIFont *font = UISystemFontT7;
    
    if (img) {
        leftDis = UILeftDis;
        buttonSize  = [BTCommonUtil HKImageSize: img];
        
        if ([text length] > 0) {
            leftDis = UILeftTextDis;
            CGSize fontSize  = [BTCommonUtil getFontSize: font Text: text];
            buttonSize.width = fmaxf(buttonSize.width, fontSize.width);
            buttonSize.height = fmaxf(buttonSize.height, fontSize.height);
        }
    } else {
        if ([text length] > 0) {
            leftDis = UILeftTextDis + 5;
            buttonSize  = [BTCommonUtil getFontSize: font Text: text];
        }
    }
    
    [_leftButton setBackgroundImage: touchImg forState: UIControlStateHighlighted];
    [_leftButton setBackgroundImage: img forState: UIControlStateNormal];
    [_leftButton setTitleColor: UIColorC3 forState: UIControlStateNormal];
    [_leftButton setTitle: text forState: UIControlStateNormal];
    _leftButton.titleLabel.font = font;
    rect.size = buttonSize;
    rect.origin = CGPointMake(leftDis, [BTResource topStatusBarHeight] + [BTCommonUtil viewTopBottomAlignOutH: [BTResource navigationBarHeight] InH: buttonSize.height]);
    _leftButton.frame = rect;
    _leftButton.left += 5;
}


- (void)setRightButtonImg:(UIImage *)img TouchImg: (UIImage*)touchImg Text: (NSString*)text {
    CGRect rect = CGRectZero;
    CGSize buttonSize = CGSizeZero;
    UIFont *font = UISystemFontT7;
    
    if (img) {
        rightDis = UIRightDis;
        buttonSize  = [BTCommonUtil HKImageSize: img];
        
        if ([text length] > 0) {
            rightDis = UIRightTextDis;
            CGSize fontSize  = [BTCommonUtil getFontSize: font Text: text];
            buttonSize.width = fmaxf(buttonSize.width, fontSize.width);
            buttonSize.height = fmaxf(buttonSize.height, fontSize.height);
        }
    } else {
        if ([text length] > 0) {
            rightDis = UIRightTextDis;
            buttonSize  = [BTCommonUtil getFontSize: font Text: text];
        }
    }
    
    [_rightButton setBackgroundImage: img forState: UIControlStateNormal];
    [_rightButton setBackgroundImage: touchImg forState: UIControlStateHighlighted];
    [_rightButton setTitleColor: UIColorC3 forState: UIControlStateNormal];
    [_rightButton setTitle: text forState: UIControlStateNormal];
    _rightButton.titleLabel.font = font;
    rect.size = buttonSize;
    rect.origin = CGPointMake(HKViewWidth - rightDis - buttonSize.width, [BTResource topStatusBarHeight] + [BTCommonUtil viewTopBottomAlignOutH: [BTResource navigationBarHeight] InH: buttonSize.height]);
    _rightButton.frame = rect;
}

- (void)hiddenLeftButton: (BOOL)hidden {
    _leftButton.hidden = hidden;
}

- (void)hiddenRightButton: (BOOL)hidden {
    _rightButton.hidden = hidden;
}
- (void)enabledRightButton: (BOOL)enable {
    _rightButton.enabled = enable;
}

- (void)enabledLeftButton: (BOOL)enable {
    _leftButton.enabled = enable;
}

@end
