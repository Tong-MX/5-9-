//
//  BTPublickZCHeaderView.m
//  BTProject
//
//  Created by 明桐的Mac on 16/5/7.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTPublickZCHeaderView.h"
#import "BTPublikeZCModel.h"

#define userHeight 23

@interface BTPublickZCHeaderView () {
    NSInteger imageViewLikesCount;
}
@property (nonatomic, strong)UIImageView *picImageView;
@property (nonatomic, strong)UIImageView *pic1ImageView;
@property (nonatomic, strong)UILabel *desLable;
@property (nonatomic, strong)NSDictionary *dynamic;
@property (nonatomic, strong)UILabel *viewsLable;
@property (nonatomic, strong)UILabel *attentionsLable;
@property (nonatomic, strong)UILabel *postsLable;
@property (nonatomic, strong)UILabel *addAttentionLable;
@property (nonatomic, strong)UIButton *oringeBtn;
@property (nonatomic, strong)UILabel *leaderLabel;
@property (nonatomic, strong)UIButton *leaderBtn;
@property (nonatomic, strong)UIImageView *imageViewLikes;
@property (nonatomic, strong)NSMutableArray *imageViewLikesArr;
@property (nonatomic, strong)NSMutableArray *avatarArr;
@property (nonatomic, strong)UIImageView *groupArrowImage;
@property (nonatomic, strong)UIView *linView;
@property (nonatomic, strong)UIButton *concentrationBtn;
@property (nonatomic, strong)UIButton *recommendBtn;
@property (nonatomic, strong)UIView *titleView;
@end
@implementation BTPublickZCHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];//BTColor(231, 231, 231)
        [self initParameters];
        [self creatUI];
    }
    
    return self;
}

- (void)initParameters {
    self.imageViewLikesArr = [NSMutableArray array];
    self.avatarArr = [NSMutableArray array];
}

- (void)creatUI {
    self.picImageView = [[UIImageView alloc] init];
    self.picImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.pic1ImageView = [[UIImageView alloc] init];
    
    self.desLable = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:12] TextAlignment:NSTextAlignmentCenter Tag:0];
    self.desLable.numberOfLines = 2;
    
    self.oringeBtn = [BTCommonUtil createButtonFrame:CGRectZero Target:self BgColor:[UIColor orangeColor] Title:@"+ 关注" TitleColor: [UIColor whiteColor] BgImg:nil action:@selector(clictAction) Tag:0];
    self.oringeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.oringeBtn.layer.cornerRadius = 100/10;
    self.oringeBtn.layer.masksToBounds = YES;
    
    self.viewsLable = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:10] TextAlignment:NSTextAlignmentRight Tag:0];
    
    self.postsLable = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:[UIColor whiteColor] Font:[UIFont systemFontOfSize:10] TextAlignment:NSTextAlignmentLeft Tag:0];
    
    self.leaderLabel = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:@"队长" textColor:BTColor(252, 99, 100) Font:[UIFont systemFontOfSize:10] TextAlignment:NSTextAlignmentLeft Tag:0];
    
    self.attentionsLable = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:[UIColor blackColor] Font:[UIFont systemFontOfSize:10] TextAlignment:NSTextAlignmentLeft Tag:0];
    self.attentionsLable.alpha = .5;
    
    self.leaderBtn = [BTCommonUtil createButtonFrame:CGRectZero Target:self BgColor:nil Title:nil TitleColor: [UIColor clearColor] BgImg:nil action:@selector(LeaderClick) Tag:0];
    self.leaderBtn.layer.cornerRadius = userHeight/2;
    self.leaderBtn.layer.masksToBounds = YES;
    
    if ([BTCommonUtil deviceID] == RES_dev_iphone_5) {
        imageViewLikesCount = 6;
    }else if ([BTCommonUtil deviceID] == RES_dev_iphone_6) {
        imageViewLikesCount = 8;
        
    }else if ([BTCommonUtil deviceID] == RES_dev_iphone_6p) {
        imageViewLikesCount = 9;
    }
    for (int i = 0; i < imageViewLikesCount; i++) {
        self.imageViewLikes = [[UIImageView alloc] init];
        self.imageViewLikes.contentMode = UIViewContentModeScaleToFill;
        self.imageViewLikes.backgroundColor = [UIColor clearColor];
        self.imageViewLikes.layer.cornerRadius = userHeight/2;
        self.imageViewLikes.layer.masksToBounds = YES;
        [self.imageViewLikesArr addObject:self.imageViewLikes];
        [self addSubview:self.imageViewLikes];
    }
    
    self.groupArrowImage = [[UIImageView alloc] init];
    self.groupArrowImage.contentMode = UIViewContentModeScaleAspectFill;
    self.groupArrowImage.image = [UIImage imageNamed:@"icon_group_post_product_arrow"];
    self.groupArrowImage.userInteractionEnabled = YES;
    
    self.linView = [[UIView alloc] init];
    self.linView.backgroundColor = BTColor(231, 231, 231);
    
    self.concentrationBtn = [BTCommonUtil createButtonFrame:CGRectZero Target:self BgColor:nil Title:@"最受欢迎" TitleColor:UIColorC2 BgImg:nil action:@selector(clickAction:) Tag:0];
    self.concentrationBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.concentrationBtn.selected = YES;
    
    self.recommendBtn = [BTCommonUtil createButtonFrame:CGRectZero Target:self BgColor:nil Title:@"最新发布" TitleColor:UIColorC2 BgImg:nil action:@selector(clickAction:) Tag:1];
    self.recommendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    self.titleView = [[UIView alloc] init];
    self.titleView.backgroundColor = BTColor(242, 117, 172);
    
    [self addSubview:_picImageView];
    [self.picImageView addSubview:_pic1ImageView];
    [self.picImageView addSubview:_desLable];
    [self.picImageView addSubview:_oringeBtn];
    [self.picImageView addSubview:_viewsLable];
    [self.picImageView addSubview:_postsLable];
    [self addSubview:_leaderLabel];
    [self addSubview:_attentionsLable];
    [self addSubview:_leaderBtn];
    [self addSubview:_groupArrowImage];
    [self addSubview:_linView];
    [self addSubview:_concentrationBtn];
    [self addSubview:_recommendBtn];
    [self addSubview:_titleView];
    
}

- (void)layoutSubviews {
    self.picImageView.frame = CGRectMake(BTZero, BTZero, HKUIScreenHeight, 260);
    self.pic1ImageView.frame = CGRectMake(100, 90, HKUIScreenWidth - 200, 30);
    self.desLable.frame = CGRectMake(15, self.pic1ImageView.top + self.pic1ImageView.height + 10, HKUIScreenWidth - 30, 40);
    self.oringeBtn.frame = CGRectMake(HKUIScreenWidth/2 - 50, self.desLable.top + self.desLable.height + 10, 100, 30);
    self.viewsLable.frame = CGRectMake(self.oringeBtn.left - 48, self.oringeBtn.top + self.oringeBtn.height + 20, 100, 10);
    self.postsLable.frame = CGRectMake(self.viewsLable.left + self.viewsLable.width + 10, self.viewsLable.top, self.viewsLable.width, 10);
    self.leaderLabel.frame = CGRectMake(10, self.postsLable.top + self.postsLable.height + 35, 30, 10);
    self.attentionsLable.frame = CGRectMake(self.leaderLabel.left + self.leaderLabel.width + 20 , self.leaderLabel.top, HKUIScreenWidth /2, 10);
    self.leaderBtn.frame = CGRectMake(self.leaderLabel.left - 3, self.leaderLabel.top + self.leaderLabel.height + 8, userHeight, userHeight);
    [self.imageViewLikesArr enumerateObjectsUsingBlock:^(UIImageView *objImageVIew, NSUInteger idx, BOOL * _Nonnull stop) {
        objImageVIew.frame = CGRectMake(self.attentionsLable.left + (35 * idx), self.leaderBtn.top, userHeight, userHeight);
        
    }];
    self.groupArrowImage.frame = CGRectMake(HKUIScreenWidth - 20, self.leaderBtn.top + 3, 8, 14);
    self.linView.frame = CGRectMake(BTZero, self.leaderBtn.top + userHeight + 10, HKUIScreenWidth, 10);
    self.concentrationBtn.frame = CGRectMake(33, self.linView.top + self.linView.height + 20, 90, 30);
    self.recommendBtn.frame = CGRectMake(HKUIScreenWidth - 133,_concentrationBtn.top, self.concentrationBtn.width, self.concentrationBtn.height);
    self.titleView.frame = CGRectMake(self.concentrationBtn.left, self.concentrationBtn.top + self.concentrationBtn.height + 3, self.concentrationBtn.width + 10, 2);
}

- (void)setModelArr:(NSMutableArray *)modelArr {
    [modelArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BTPublikeZCModel *model = (BTPublikeZCModel*)obj;
            [self.picImageView sd_setImageWithURL:[NSURL URLWithString:model.pic2] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
            }];
        
            [self.pic1ImageView sd_setImageWithURL:[NSURL URLWithString:model.pic3] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
            }];
        

        self.desLable.text = model.desc;
        self.viewsLable.text = [NSString stringWithFormat:@"%@浏览", model.dynamic[@"views"]];
        self.postsLable.text = [NSString stringWithFormat:@"%@帖子",model.dynamic[@"posts"]];
        self.attentionsLable.text = [NSString stringWithFormat:@"%@人关注",model.dynamic[@"attentions"]];
        [self.leaderBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:model.author[@"avatar"]] forState:UIControlStateNormal];
        [model.attention_users enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (self.imageViewLikesArr.count > idx) {
                [self.imageViewLikesArr[idx] sd_setImageWithURL:[NSURL URLWithString:obj[@"avatar"]] placeholderImage:[UIImage imageNamed:@"default_loading"]];
            }
        }];
    }];

}

- (void)clickAction:(UIButton*)btn {
    CGFloat leftFloat;
    if (btn.tag == 0) {
        _concentrationBtn.selected = !_recommendBtn.selected;
        leftFloat = _concentrationBtn.left;
    }else if (btn.tag == 1) {
        _recommendBtn.selected = !_concentrationBtn.selected;
        leftFloat = _recommendBtn.left;
    }
    [UIView animateWithDuration:.3 animations:^{
        _titleView.left = leftFloat;
    }];
}

@end
