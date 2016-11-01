//
//  BTSHoppingTableVIewCell.m
//  BTProject
//
//  Created by 明桐的Mac on 16/4/30.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTSHoppingTableVIewCell.h"
#import "BTshoppingModel.h"

#define userHeight 25
@interface BTSHoppingTableVIewCell (){
    CGFloat desHeight;
    CGFloat imageViewDic1Height;
    NSInteger imageViewLikesCount;
}
@property (nonatomic, strong)UIView *superAllView;
@property (nonatomic, strong)UIImageView *goodImageView;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UILabel *descLabel;
@property (nonatomic, strong)UILabel *priceLabel;
@property (nonatomic, strong)UIView *lineView;
@property (nonatomic, strong)UILabel *likesLable;
@property (nonatomic, strong)UIImageView *imageViewPic1;
@property (nonatomic, strong)UIImageView *imageViewPic2;
@property (nonatomic, strong)UIImageView *imageViewLikes;
@property (nonatomic, strong)UIImageView *groupArrowImage;
@property (nonatomic, strong)UIView *lineView1;
@property (nonatomic, strong)NSString *desStr;
@property (nonatomic, strong)UIButton *commentBtn;
@property (nonatomic, strong)UIButton *likeBtn;
@property (nonatomic, strong)UILabel *likesNumberLabel;
@property (nonatomic, strong)UIImageView *buyImageView;
@property (nonatomic, strong)NSMutableArray *picArr;
@property (nonatomic, strong)NSMutableArray *likesArr;
@property (nonatomic, strong)NSMutableArray *imageViewLikesArr;
@end
@implementation BTSHoppingTableVIewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Size:(CGSize)size {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier Size:size]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initParameters];
        [self creatCellUI];
    }
    return self;
}

- (void)initParameters {
    imageViewDic1Height = 0;
    desHeight = 0;
    imageViewLikesCount = 0;
    self.picArr = [NSMutableArray array];
    self.likesArr = [NSMutableArray array];
    self.imageViewLikesArr = [NSMutableArray array];
}
- (void)creatCellUI {
    self.superAllView = [[UIView alloc] init];
    self.superAllView.backgroundColor = [UIColor whiteColor];
    self.superAllView.userInteractionEnabled = YES;
    
    self.goodImageView = [[UIImageView alloc] init];
    
    self.titleLabel = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:UIColorC2 Font:[UIFont systemFontOfSize:17] TextAlignment:NSTextAlignmentLeft Tag:0];
    self.titleLabel.numberOfLines = 1;
    
    self.descLabel = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:UIColorC2 Font:[UIFont systemFontOfSize:15] TextAlignment:NSTextAlignmentLeft Tag:0];
    self.descLabel.alpha = .8;
    self.descLabel.numberOfLines = 0;
    self.descLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    self.imageViewPic1 = [[UIImageView alloc] init];
    self.imageViewPic1.userInteractionEnabled = YES;
    self.imageViewPic1.backgroundColor = [UIColor clearColor];
    self.imageViewPic1.contentMode = UIViewContentModeScaleToFill;
    self.imageViewPic1.alpha = 0;
    
    self.imageViewPic2 = [[UIImageView alloc] init];
    self.imageViewPic2.userInteractionEnabled = YES;
    self.imageViewPic2.backgroundColor = [UIColor clearColor];
    self.imageViewPic2.contentMode = UIViewContentModeScaleToFill;
    self.imageViewPic2.alpha = 0;
    
    self.priceLabel = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:[UIColor redColor] Font:[UIFont systemFontOfSize:12] TextAlignment:NSTextAlignmentRight Tag:0];
    self.priceLabel.alpha = .8;
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [UIColor grayColor];
    self.lineView.alpha = .1;
    
    self.likesLable = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:[UIColor grayColor] Font:[UIFont systemFontOfSize:10] TextAlignment:NSTextAlignmentLeft Tag:0];
    self.likesLable.alpha = .8;
    if ([BTCommonUtil deviceID] == RES_dev_iphone_5) {
        imageViewLikesCount = 9;
    }else if ([BTCommonUtil deviceID] == RES_dev_iphone_6) {
        imageViewLikesCount = 11;

    }else if ([BTCommonUtil deviceID] == RES_dev_iphone_6p) {
        imageViewLikesCount = 12;
    }
    for (int i = 0; i < imageViewLikesCount; i++) {
        self.imageViewLikes = [[UIImageView alloc] init];
        self.imageViewLikes.contentMode = UIViewContentModeScaleToFill;
        self.imageViewLikes.backgroundColor = [UIColor clearColor];
        self.imageViewLikes.layer.cornerRadius = userHeight/2;
        self.imageViewLikes.layer.masksToBounds = YES;
        [self.imageViewLikesArr addObject:self.imageViewLikes];
        [self.superAllView addSubview:self.imageViewLikes];
    }

    self.groupArrowImage = [[UIImageView alloc] init];
    self.groupArrowImage.contentMode = UIViewContentModeScaleAspectFill;
    self.groupArrowImage.image = [UIImage imageNamed:@"icon_group_post_product_arrow"];
    self.groupArrowImage.userInteractionEnabled = YES;
    
    self.lineView1 = [[UIView alloc] init];
    self.lineView1.backgroundColor = [UIColor grayColor];
    self.lineView1.alpha = .1;
    
    //
    self.commentBtn = [BTCommonUtil createButtonFrame:CGRectZero Target:self BgColor:nil Title:nil TitleColor:nil BgImg:[UIImage imageNamed:@"product_not_commenticonicon"] action:@selector(commentAction:) Tag:0];
    
    self.likeBtn = [BTCommonUtil createButtonFrame:CGRectZero Target:self BgColor:nil Title:nil TitleColor:nil BgImg:[UIImage imageNamed:@"product_item_unlikeicon"] action:@selector(likeAction:) Tag:0];
    self.likesNumberLabel = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:[UIColor grayColor] Font:[UIFont systemFontOfSize:12] TextAlignment:NSTextAlignmentLeft Tag:0];
    self.likesNumberLabel.alpha = .8;
    
    self.buyImageView = [[UIImageView alloc] init];
    self.buyImageView.backgroundColor = BTColor(252, 99, 100);
    self.buyImageView.layer.cornerRadius = 25/2;
    self.buyImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.buyImageView.userInteractionEnabled = YES;
    self.buyBtn = [BTCommonUtil createButtonFrame:CGRectZero Target:self BgColor:nil Title:@"购买" TitleColor:[UIColor whiteColor] BgImg:[UIImage imageNamed:@""] action:@selector(buyAction:) Tag:0];//icon_topic_product_buy@3x
    self.buyBtn.selected = YES;
    self.buyBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    [self.contentView addSubview:_superAllView];
    [self.superAllView addSubview:_goodImageView];
    [self.superAllView addSubview:_titleLabel];
    [self.superAllView addSubview:_descLabel];
    [self.superAllView addSubview:_imageViewPic1];
    [self.superAllView addSubview:_imageViewPic2];
    [self.superAllView addSubview:_priceLabel];
    [self.superAllView addSubview:_lineView];
    [self.superAllView addSubview:_likesLable];
    [self.superAllView addSubview:_groupArrowImage];
    [self.superAllView addSubview:_lineView1];
    [self.superAllView addSubview:_commentBtn];
    [self.superAllView addSubview:_likeBtn];
    [self.superAllView addSubview:_buyImageView];
    [self.buyImageView addSubview:_buyBtn];
    [self.superAllView addSubview:_likesNumberLabel];
}


- (void)commentAction:(UIButton*)btn {

}

- (void)buyAction:(UIButton*)btn {
    NSLog(@"%ld",btn.tag);
    if (_buyDelegate && [_buyDelegate respondsToSelector:@selector(payBuyActionWithTagCell:)]) {
//        [_buyDelegate payBuyActionWithUrlStr:];
        [_buyDelegate payBuyActionWithTagCell:btn.tag];
    }
}

- (void)setDataSoucreTable:(id)dataSoucreTable {

    if (dataSoucreTable && dataSoucreTable > 0) {
        BTshoppingModel *model = (BTshoppingModel*)dataSoucreTable;
        MTLog(@"%@",model.id);
        self.titleLabel.text =model.title;
        self.priceLabel.text = [NSString stringWithFormat:@"参考价格: ¥%@",model.price];
        self.likesLable.text = [NSString stringWithFormat:@"%@人喜欢",model.likes];
        self.likesNumberLabel.text = model.likes;
        [self.picArr removeAllObjects];
        [model.pic enumerateObjectsUsingBlock:^(NSDictionary *objDic, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *urlStrPic = [NSString stringWithFormat:@"%@%@",PRODUCTCLICkUrl,objDic[@"p"]];
            
            [self.picArr addObject:urlStrPic];
        }];
        
        [self.likesArr removeAllObjects];
        [model.likes_list enumerateObjectsUsingBlock:^(NSDictionary *objDic, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *urlLikes = [NSString stringWithFormat:@"%@%@",LIKESIMGEUrl,objDic[@"a"]];
            [self.likesArr addObject:urlLikes];
        }];
        
        if (self.picArr.count == 2 && self.picArr.count < 3) {
            [_imageViewPic2 sd_setImageWithURL:[NSURL URLWithString:self.picArr[0]]];
            [_imageViewPic1 sd_setImageWithURL:[NSURL URLWithString:self.picArr[1]]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [UIView animateWithDuration:.4 animations:^{
                    _imageViewPic1.alpha = 1;
                    _imageViewPic2.alpha = 1;
                }];
            }];
            
        }else if (self.picArr.count == 1 && self.picArr.count < 2) {
            [_imageViewPic2 sd_setImageWithURL:[NSURL URLWithString:self.picArr[0]]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [UIView animateWithDuration:.4 animations:^{
                    _imageViewPic2.alpha = 1;
                }];
            }];
            
        }
        [self.likesArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (self.imageViewLikesArr.count > idx) {
                [self.imageViewLikesArr[idx] sd_setImageWithURL:obj placeholderImage:[UIImage imageNamed:@"default_loading"]];
            }
        }];
        [self.likesArr removeAllObjects];
        self.desStr = model.desc;
    }
}

- (void)setDesStr:(NSString *)desStr {
    _desStr = desStr;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_desStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [desStr length])];
    _descLabel.attributedText = attributedString;
    [self.descLabel sizeToFit];
    [self layoutSubviewsRepet];
}

- (void)setImageGoodeArr:(NSMutableArray *)imageGoodeArr {
    _imageGoodeArr = imageGoodeArr;
    self.goodImageView.image = (UIImage*)imageGoodeArr;
}

- (CGFloat)layoutSubviewsRepet {
    desHeight  = [BTCommonUtil getStringSize:_desStr Font:[UIFont systemFontOfSize:15] W:HKUIScreenWidth - 12 Spacing:10].height;
    self.goodImageView.frame = CGRectMake(6, 5, 16, 24);
    self.titleLabel.frame = CGRectMake(_goodImageView.left + _goodImageView.width + 10, self.goodImageView.top, HKUIScreenWidth, 20);
    self.descLabel.frame = CGRectMake(self.goodImageView.left, self.goodImageView.top + self.goodImageView.height + 5, HKUIScreenWidth - 12, desHeight);
    self.imageViewPic2.frame = CGRectMake(self.descLabel.left, self.descLabel.top + self.descLabel.height, self.descLabel.width, 320);
    self.imageViewPic1.frame = CGRectMake(self.imageViewPic2.left, self.imageViewPic2.top +self.imageViewPic2.height + 5, self.imageViewPic2.width,self.imageViewPic2.height);

    if (_picArr.count == 1) {
        self.imageViewPic1.height = 0;
    }else if (_picArr.count == 2) {
        self.imageViewPic1.height = self.imageViewPic2.height;
    }
    self.priceLabel.frame = CGRectMake(HKUIScreenWidth - 15 -  HKUIScreenWidth/2, self.imageViewPic1.height != 0 ? self.imageViewPic1.top + self.imageViewPic1.height + 10 : self.imageViewPic2.top +self.imageViewPic2.height + 10, HKUIScreenWidth/2, 20);
    
    self.lineView.frame = CGRectMake(BTZero, self.priceLabel.top + self.priceLabel.height + 15, HKUIScreenWidth, 1);
    
    self.likesLable.frame = CGRectMake(self.imageViewPic2.left, self.priceLabel.top + self.priceLabel.height + 20, HKUIScreenWidth/5, 20);
    [self.imageViewLikesArr enumerateObjectsUsingBlock:^(UIImageView *objImageVIew, NSUInteger idx, BOOL * _Nonnull stop) {
        objImageVIew.frame = CGRectMake(self.goodImageView.left + (32 * idx), self.likesLable.top + self.likesLable.height + 5, userHeight, userHeight);

    }];
    self.groupArrowImage.frame = CGRectMake(HKUIScreenWidth - 8 - 17, self.imageViewLikes.top + 5, 8, 14);
    
    self.lineView1.frame = CGRectMake(self.likesLable.left, self.groupArrowImage.top + self.groupArrowImage.height + 17, HKUIScreenWidth, 1);
    
    self.commentBtn.frame = CGRectMake(self.likesLable.left + 20, self.lineView1.top + 15, 23, 23);
    self.likeBtn.frame = CGRectMake(self.commentBtn.left + self.commentBtn.width + 100, self.commentBtn.top, 24, 21);
    self.likesNumberLabel.frame = CGRectMake(self.likeBtn.left + self.likeBtn.width + 3, self.likeBtn.top, 70, 23);
    
    self.buyImageView.frame = CGRectMake(HKUIScreenWidth - 70 - 10, self.likeBtn.top, 70, 25);
    self.buyBtn.frame = CGRectMake(self.buyImageView.width/2 - 12.5, 5, 25, 15);
    
    self.superAllView.frame = CGRectMake(BTZero, BTZero, HKUIScreenWidth,  self.goodImageView.height + self.titleLabel.height + + self.imageViewPic1.height + self.imageViewPic2.height + self.priceLabel.height + self.likesLable.height + self.imageViewLikes.height + self.buyBtn.height + 87 + self.descLabel.height);
    
    return  self.superAllView.height + 5;
}
@end
