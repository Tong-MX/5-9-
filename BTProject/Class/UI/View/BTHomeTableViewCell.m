//
//  BTHomeTableViewCell.m
//  BTProject
//
//  Created by 明桐的Mac on 16/4/4.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTHomeTableViewCell.h"
#import "BTHomeModel.h"
#import "BTtopicModel.h"
@interface BTHomeTableViewCell()

@property (nonatomic ,strong)UIImageView *homeImageView;
@end
@implementation BTHomeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Size:(CGSize)size{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier Size:size]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatUi];
    }
    return self;
}
- (void)creatUi{
    
    for (id subView in self.contentView.subviews) {
        [subView removeFromSuperview];
    }
    self.homeImageView = [BTCommonUtil createImageViewFrame:CGRectMake(BTZero, BTZero, BTZero, BTZero) BgColor:nil Img:nil Tag:0];
//    self.homeImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.homeImageView.alpha = 0;
    self.namelabel = [[UILabel alloc] init];
    _namelabel.font = [UIFont systemFontOfSize:14];
    _namelabel.numberOfLines = BTZero;
    _namelabel.textAlignment = NSTextAlignmentCenter;
    _namelabel.textColor = BTColor(133, 133, 133);
    
    _heartImageView = [[UIImageView alloc] init];
    _heartImageView.image = [UIImage imageNamed:@"top_like"];
    
    _numberLabel = [[UILabel alloc] init];
    _numberLabel.font = [UIFont systemFontOfSize:12];
    _numberLabel.numberOfLines = BTZero;
    _numberLabel.textAlignment = NSTextAlignmentLeft;
    _numberLabel.textColor = BTColor(133, 133, 133);
    
    [self addSubview:_namelabel];
    [self addSubview:_homeImageView];
    [self addSubview:_heartImageView];
    [self addSubview:_numberLabel];
    
    [self UIRefreshFrame];
}

- (void)layoutSubviews {
    
    [self UIRefreshFrame];
}

- (CGFloat)anualLayoutSubviews {
    
    return self.homeImageView.height + self.namelabel.height + self.heartImageView.height + self.numberLabel.height;
}

- (void)setTopModel:(NSMutableArray*)topModel {

    if ([topModel isKindOfClass:[BTHomeModel class]]) {
        BTHomeModel *model = (BTHomeModel*)topModel;
        if ([model.type isEqualToString:@"webview"]) {
            [UIView animateWithDuration:.5 animations:^{
                [_homeImageView sd_setImageWithURL:[NSURL URLWithString:model.photo] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    [UIView animateWithDuration:.4 animations:^{
                        self.homeImageView.alpha = 1;
                    }];
                }];
            }];
            _namelabel.text = model.title;
            _namelabel.textColor = UIColorC17;
            _heartImageView.image = [UIImage imageNamed:@""];
        }else {

            [_homeImageView sd_setImageWithURL:[NSURL URLWithString:model.photo]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [UIView animateWithDuration:.5 animations:^{
                    self.homeImageView.alpha = 1;
                }];
            }];
            _namelabel.text = model.title;
        }
    }else if ([topModel isKindOfClass:[BTtopicModel class]]) {
        BTtopicModel *model = (BTtopicModel*)topModel;
        
        [_homeImageView sd_setImageWithURL:[NSURL URLWithString:model.pic] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [UIView animateWithDuration:.5 animations:^{
                self.homeImageView.alpha = 1;
            }];
        }];
        _namelabel.text = model.title;
        _numberLabel.text = model.likes;
    }
}

- (void)UIRefreshFrame{
    
    self.homeImageView.frame = CGRectMake(BTZero, BTZero, HKUIScreenWidth,200);
    self.namelabel.frame = CGRectMake(BTZero, self.homeImageView.height + 10, HKUIScreenWidth, 6);
    self.heartImageView.frame = CGRectMake(HKUIScreenWidth/2 - 28, self.namelabel.frame.origin.y + [BTCommonUtil getFontHeight:self.namelabel.font], 14, 12);
    self.numberLabel.frame = CGRectMake(self.heartImageView.frame.origin.x + self.heartImageView.width + 2,self.heartImageView.frame.origin.y, HKUIScreenWidth, 12);
}
@end
