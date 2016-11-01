//
//  BTHomeHeadCell.m
//  BTProject
//
//  Created by 明桐的Mac on 16/5/5.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTHomeHeadCell.h"
@interface BTHomeHeadCell ()
@property (nonatomic, strong)UIImageView *topImageView;
@property (nonatomic, strong)UILabel *topLable;
@property (nonatomic, strong)UILabel *commentLable;
@property (nonatomic, strong)UIImageView *likeImageView;
@end
@implementation BTHomeHeadCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Size:(CGSize)size {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier Size:size]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    self.topImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.topImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.backgroundColor = [UIColor clearColor];
    
    self.topLable = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:BTColor(133, 133, 133) Font:[UIFont systemFontOfSize:14] TextAlignment:NSTextAlignmentCenter Tag:0];
    self.topLable.numberOfLines = 1;
    self.likeImageView = [[UIImageView alloc] init];
    self.likeImageView.image = [UIImage imageNamed:@"top_like"];
    
    self.commentLable = [[UILabel alloc] init];
    self.commentLable.font = [UIFont systemFontOfSize:12];
    self.commentLable.numberOfLines = BTZero;
    self.commentLable.textAlignment = NSTextAlignmentLeft;
    self.commentLable.textColor = BTColor(133, 133, 133);
    
    [self.contentView addSubview:self.topImageView];
    [self.contentView addSubview:self.topLable];
    [self.contentView addSubview:self.likeImageView];
    [self.contentView addSubview:self.commentLable];
    
}
- (void)setModel:(BTtopicModel *)model {
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    self.topLable.text = model.title;
    self.commentLable.text = model.likes;
}

- (void)layoutSubviews {
    self.topImageView.frame = CGRectMake(BTZero, BTZero, HKUIScreenWidth, 200);
    self.topLable.frame = CGRectMake(BTZero, self.topImageView.top + self.topImageView.height + 10, HKUIScreenWidth, 10);
    self.likeImageView.frame = CGRectMake(HKUIScreenWidth/2 - 30, self.topLable.top + self.topLable.height + 10, 14, 12);
    self.commentLable.frame = CGRectMake(self.likeImageView.left + self.likeImageView.width + 5, self.likeImageView.top, HKUIScreenWidth/4, 12);
}
@end
