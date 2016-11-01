//
//  BTNetWorkReloadView.m
//  BTProject
//
//  Created by 明桐的Mac on 16/4/9.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTNetWorkReloadView.h"

@interface BTNetWorkReloadView () {
    CGFloat labelfontH;
}

@property (nonatomic, strong) UIButton *touchButton;

@property (nonatomic, strong) UIFont *labelfont;

@end

@implementation BTNetWorkReloadView

- (void)dealloc {
    _touchButton = nil;
    _explanationLabel = nil;
    _labelfont = nil;
    _delegate = nil;
}

- (id)init {
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    
    if (self) {
//        [self initTouchButton];
        [self initExplanationLabel];
    }
    
    return self;
}

#define UIBgViewAlpha 0.9
- (void)initParameter {
    self.backgroundColor =  UIColorC3;
    
    self.labelfont = UISystemFontT9;
}

- (void)initSize {
    labelfontH = [BTCommonUtil  getFontHeight: _labelfont];
}

- (void)initTouchButton {
    UIImage *img = [UIImage imageNamed: @"netWork"];
    
    CGSize imgSize = [BTCommonUtil HKImageSize: img];
    
    CGRect rect = CGRectMake(BTZero, BTZero, BTZero, BTZero);
    rect.size = imgSize;
    rect.origin = CGPointMake([BTCommonUtil centerXorY: HKViewWidth InH: imgSize.width], [BTCommonUtil centerXorY: HKViewHeight InH: imgSize.height] - HKTopBarHeight * THalfTime - 80);
    
    self.touchButton = [BTCommonUtil createButtonFrame: rect Target: self BgColor: nil Title: nil TitleColor:nil BgImg: img action: @selector(touchEvent) Tag: 0];
    
}

- (void)initExplanationLabel {
    CGRect rect = self.touchButton.frame;
    rect.size = CGSizeMake(HKViewWidth, labelfontH);
    rect.origin.x = BTZero;
    rect.origin.y = self.touchButton.frame.origin.y + [BTCommonUtil centerXorY: self.touchButton.frame.size.height InH: rect.size.height];
    UIView *netView = [[UIView alloc] init];
    netView.userInteractionEnabled = YES;
    netView.frame = CGRectMake(BTZero, BTZero, HKUIScreenWidth, HKUIScreenHeight);
    netView.backgroundColor = [UIColor whiteColor];
    
//    self.explanationLabel = [BTCommonUtil createLabelFrame: rect BgColor: nil Text: NSLocalizedString(@"NetWorkMsg_reload", nil) textColor: UIColorC2 Font: _labelfont TextAlignment: NSTextAlignmentCenter Tag: 0];
    [self initTouchButton];
    [self addSubview: netView];
//    [netView addSubview:imageView];
    [netView addSubview: _touchButton];
}

- (void)touchEvent {
    if (_delegate && [_delegate respondsToSelector: @selector(reloadUI)]) {
        [_delegate reloadUI];
    }
}
@end
