//
//  BTPublckTableViewCell.m
//  BTProject
//
//  Created by 明桐的Mac on 16/4/15.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTPublckTableViewCell.h"
@interface BTPublckTableViewCell ()
@end
@implementation BTPublckTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Size: (CGSize)size indexPax:(NSIndexPath *)indexPath {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatTitleAndImageUI];
    }
    return self;
}

- (void)creatTitleAndImageUI {
    self.lineView = [[UIView alloc] init];
    _lineView.backgroundColor = BTColor(247, 247, 247);
    self.titleLabel = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:BTColor(133, 133, 133) Font:[UIFont systemFontOfSize:13] TextAlignment:NSTextAlignmentCenter Tag:0];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.frame = CGRectMake(HKUIScreenWidth/2 - [BTCommonUtil setWidthPX:80], [BTCommonUtil setHeightPX:30], [BTCommonUtil setWidthPX:160], [BTCommonUtil setHeightPX:60]);
    self.cellImage = [BTCommonUtil createImageViewFrame:CGRectZero BgColor:nil Img:nil Tag:1];
    self.cellImage.backgroundColor = [UIColor grayColor];
    
    self.imageName = [BTCommonUtil createImageViewFrame:CGRectZero BgColor:nil Img:nil Tag:0];
    self.browseLabel = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:9] TextAlignment:NSTextAlignmentRight Tag:1];
    self.postLabel = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:9] TextAlignment:NSTextAlignmentLeft Tag:0];
    self.changeBtn = [BTCommonUtil createButtonFrame:CGRectZero Target:self BgColor:nil Title:nil TitleColor:nil BgImg:nil action:@selector(changeAction:) Tag:0];
    
    [self.contentView addSubview:_lineView];
    [self.contentView addSubview:_titleLabel];
    [self.contentView addSubview:_cellImage];
    [self.cellImage addSubview:_imageName];
    [self.cellImage addSubview:_browseLabel];
    [self.cellImage addSubview:_postLabel];
    [self.contentView addSubview:_changeBtn];
}

- (void)layoutSubviews {
    
    
}

#pragma mark 点击事件
- (void)changeAction:(UIButton *)btn {
    if ([_delegate respondsToSelector:@selector(chageBtnSelectate:)]) {
        [_delegate chageBtnSelectate:btn];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
