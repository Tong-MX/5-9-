//
//  BTMessageView.m
//  BTProject
//
//  Created by 明桐的Mac on 16/4/25.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTMessageCell.h"

@implementation BTMessageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Size:(CGSize)size {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier Size:size]) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatCellUI];
    }
    return self;
}

- (void)creatCellUI {
    self.messageImage = [[UIImageView alloc] initWithFrame:CGRectZero];

    self.messageComment = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:BTColor(133, 133, 133) Font:[UIFont systemFontOfSize:13] TextAlignment:NSTextAlignmentLeft Tag:0];
    
    self.postProductImage = [[UIImageView alloc] init];
    self.postProductImage.image = [UIImage imageNamed:@"icon_group_post_product_arrow"];
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = BTColor(133, 133, 133);
    self.lineView.alpha = .1;
    [self.contentView addSubview:_messageImage];
    [self.contentView addSubview:_messageComment];
    [self.contentView addSubview:_postProductImage];
    [self.contentView addSubview:_lineView];
}

- (void)layoutSubviews {
    self.messageImage.frame = CGRectMake(10, 15, 20, 20);
    self.messageComment.frame = CGRectMake(self.messageImage.left + self.messageImage.width + 20, 15, HKUIScreenWidth/4, 20);
    self.postProductImage.frame = CGRectMake(HKUIScreenWidth - 20, 17, 8, 14);
    self.lineView.frame = CGRectMake(BTZero, self.messageImage.top + self.messageImage.height + 10, HKUIScreenWidth, 1);
}
@end
