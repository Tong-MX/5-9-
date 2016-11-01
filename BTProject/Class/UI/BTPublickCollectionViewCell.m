//
//  BTPublickCollectionViewCell.m
//  BTProject
//
//  Created by 明桐的Mac on 16/4/15.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTPublickCollectionViewCell.h"
#import "BTPublicModel.h"
#define image 100
#define imgH [BTCommonUtil setHeightPX:image]
@interface BTPublickCollectionViewCell()

@end
@implementation BTPublickCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self creatScroolBtn];
    }
    return self;
}

- (void)creatScroolBtn {
     self.titleOneBtn = [BTCommonUtil createButtonFrame:CGRectZero Target:self BgColor:nil Title:nil TitleColor:nil BgImg:nil action:@selector(titleAction:) Tag:0];
    self.titleTwoBtn = [BTCommonUtil createButtonFrame:CGRectZero Target:self BgColor:nil Title:nil TitleColor:nil BgImg:nil action:@selector(titleAction:) Tag:0];
    
    self.nameOneLabel = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:BTColor(133, 133, 133) Font:[UIFont systemFontOfSize:13] TextAlignment:NSTextAlignmentCenter Tag:1];
    self.nameTwoLabel = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:BTColor(133, 133, 133) Font:[UIFont systemFontOfSize:13] TextAlignment:NSTextAlignmentCenter Tag:1];
    
    self.popularityOneLabel = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:BTColor(133, 133, 133) Font:[UIFont systemFontOfSize:11] TextAlignment:NSTextAlignmentLeft Tag:0];
    self.popularityTwoLabel = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:BTColor(133, 133, 133) Font:[UIFont systemFontOfSize:11] TextAlignment:NSTextAlignmentLeft Tag:0];
    
    
    
    [self addSubview:_titleOneBtn];
    [self addSubview:_titleTwoBtn];
    [self addSubview:_nameOneLabel];
    [self addSubview:_nameTwoLabel];
    [self addSubview:_popularityOneLabel];
    [self addSubview:_popularityTwoLabel];

}

- (void)layoutSubviews {
    _titleOneBtn.frame = CGRectMake([BTCommonUtil setWidthPX:40],[BTCommonUtil setHeightPX:60], imgH, imgH);
    _titleTwoBtn.frame = CGRectMake([BTCommonUtil setWidthPX:40],[BTCommonUtil setHeightPX:260], imgH, imgH);
    _titleOneBtn.layer.cornerRadius = imgH/2;
    _titleOneBtn.layer.masksToBounds = YES;
    _titleTwoBtn.layer.cornerRadius = imgH/2;
    _titleTwoBtn.layer.masksToBounds = YES;
    
    _nameOneLabel.frame = CGRectMake(_titleOneBtn.frame.origin.x,_titleOneBtn.height + _titleOneBtn.orightY - [BTCommonUtil setHeightPX:20], imgH, imgH);
    _nameTwoLabel.frame = CGRectMake(_titleOneBtn.frame.origin.x,_titleTwoBtn.height + _titleTwoBtn.orightY - [BTCommonUtil setHeightPX:20], imgH, imgH);
    
    _popularityOneLabel.frame = CGRectMake(_nameOneLabel.orightX, _nameOneLabel.height + _nameOneLabel.orightY - [BTCommonUtil setHeightPX:40], 80, 20);
    _popularityTwoLabel.frame = CGRectMake(_nameTwoLabel.orightX, _nameTwoLabel.height + _nameTwoLabel.orightY - [BTCommonUtil setHeightPX:40], 80, 20);
    
}

#pragma mark set方法传输局
- (void)setDataSouce:(NSMutableArray *)dataSouce {
    _dataSouce = dataSouce;
  
}
- (void)titleAction: (UIButton*)btn {
}
@end
