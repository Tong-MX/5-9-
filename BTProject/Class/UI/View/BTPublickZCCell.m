//
//  BTPublickZCCell.m
//  BTProject
//
//  Created by 明桐的Mac on 16/5/7.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTPublickZCCell.h"
#import "BTPublikeZCPostListMode.h"
#define userHeight 28

@interface BTPublickZCCell () {
    NSInteger tagNameCount;
    CGFloat desHeight;
    CGFloat superHeight;
}
@property (nonatomic, strong)UIImageView *avatarImageView;
@property (nonatomic, strong)UIView *superCellView;
@property (nonatomic, strong)UILabel *nicknameLabel;
@property (nonatomic, strong)UIImageView *nicknameImage;
@property (nonatomic, strong)UILabel *datestrLable;
@property (nonatomic, strong)UIImageView *middlePicImageView;
@property (nonatomic, strong)UIButton *commentBtn;
@property (nonatomic, strong)UIButton *likeBtn;
@property (nonatomic, strong)UIButton *shareItemBtn;
@property (nonatomic, strong)UIImageView *editNameImage;
@property (nonatomic, strong)UILabel *tagNameLable;
@property (nonatomic, strong)NSMutableArray *tagNameArr;
@property (nonatomic, strong)NSMutableArray *tagsArr;
@property (nonatomic, strong)UILabel *contentLable;
@property (nonatomic, strong)UILabel *linkLable;
@property (nonatomic, strong)UIImageView *minPicImage;
@property (nonatomic, strong)NSString *desStr;
@property (nonatomic, strong)UILabel *titleLable;
@property (nonatomic, strong)UILabel *priceLable;
@property (nonatomic, strong)UIImageView *likeImageView;
@property (nonatomic, strong)UILabel *likeLabel;
@property (nonatomic, strong)UIImageView *platformImage;////判读是京东天猫还是淘宝的图片
@property (nonatomic, strong)UIView *linkView;
@property (nonatomic, strong)UILabel *platformLabel;
@property (nonatomic, strong)UIImageView *buyImageView;
@property (nonatomic, strong)UILabel *commentsLable;
@property (nonatomic, strong)UIButton *usernameBtn;
@property (nonatomic, strong)UILabel *conentLabel;
@property (nonatomic, strong)NSMutableArray *usernameArr;
@property (nonatomic, strong)NSMutableArray *commentsArr;
@property (nonatomic, strong)NSMutableArray *conentArr;
@property (nonatomic, strong)NSMutableArray *conentUserArr;
@property (nonatomic, assign)CGFloat userWidth;
@property (nonatomic, strong)UIImageView *meImageView;
@property (nonatomic, strong)UIButton *meTalkBtn;

@end
@implementation BTPublickZCCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Size:(CGSize)size {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier Size:size]) {
        self.backgroundColor = BTColor(247, 247, 247);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initParameters];
        [self creatUI];
        
    }
    
    return self;
}

- (void)initParameters {
    self.tagNameArr = [NSMutableArray array];
    self.tagsArr = [NSMutableArray array];
    self.usernameArr = [NSMutableArray array];
    self.commentsArr = [NSMutableArray array];
    self.conentArr = [NSMutableArray array];
    self.conentUserArr = [NSMutableArray array];
}

- (void)creatUI {
    self.superCellView = [[UIView alloc] init];
    self.superCellView.backgroundColor = [UIColor whiteColor];
    
    self.avatarImageView = [[UIImageView alloc] init];
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.avatarImageView.layer.cornerRadius = userHeight/2;
    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.backgroundColor = [UIColor clearColor];
    
    self.nicknameLabel = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:[UIColor blackColor] Font:[UIFont systemFontOfSize:10] TextAlignment:NSTextAlignmentLeft Tag:0];
    
    self.nicknameImage = [[UIImageView alloc] init];
    self.nicknameImage.contentMode = UIViewContentModeScaleAspectFill;
    self.nicknameImage.image = [UIImage imageNamed:@"icon_grop_recommend"];
    self.nicknameLabel.alpha = .8;
    
    self.datestrLable = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:[UIColor blackColor] Font:[UIFont systemFontOfSize:10] TextAlignment:NSTextAlignmentRight Tag:0];
    self.datestrLable.alpha = .5;
    
    self.middlePicImageView = [[UIImageView alloc] init];
//    self.middlePicImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.commentBtn = [BTCommonUtil createButtonFrame:CGRectZero Target:self BgColor:nil Title:nil TitleColor:nil BgImg:[UIImage imageNamed:@"product_not_commenticonicon"] action:@selector(commentAction:) Tag:0];
    
    self.likeBtn = [BTCommonUtil createButtonFrame:CGRectZero Target:self BgColor:nil Title:nil TitleColor:nil BgImg:[UIImage imageNamed:@"product_item_unlikeicon"] action:@selector(likeAction:) Tag:0];
    
    self.shareItemBtn = [BTCommonUtil createButtonFrame:CGRectZero Target:self BgColor:nil Title:nil TitleColor:nil BgImg:[UIImage imageNamed:@"share_item_icon"] action:@selector(likeAction:) Tag:0];
    
    self.editNameImage = [[UIImageView alloc] init];
    self.editNameImage.image = [UIImage imageNamed:@"icon_tag_edit_name"];
    tagNameCount = 7;
    for (int i = 0; i < tagNameCount; i ++ ) {
        self.tagNameLable = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:BTColor(252, 99, 100) Font:[UIFont systemFontOfSize:10] TextAlignment:NSTextAlignmentRight Tag:0];
        
        [self.superCellView addSubview:_tagNameLable];
        [self.tagNameArr addObject:_tagNameLable];
    }
    
    self.contentLable = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:UIColorC2 Font:[UIFont systemFontOfSize:12] TextAlignment:NSTextAlignmentRight Tag:0];
    self.contentLable.numberOfLines = 0;
    self.contentLable.lineBreakMode = NSLineBreakByCharWrapping;
    
    self.linkLable = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:@"相关链接" textColor:[UIColor blackColor] Font:[UIFont systemFontOfSize:10] TextAlignment:NSTextAlignmentLeft Tag:0];
    self.linkLable.alpha = .6;
    
    self.minPicImage = [[UIImageView alloc] init];
    
    self.linkView = [[UIView alloc] init];
    self.linkView.backgroundColor = [UIColor grayColor];
    self.linkView.alpha = .2;
    
    self.titleLable = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:[UIColor blackColor] Font:[UIFont systemFontOfSize:12] TextAlignment:NSTextAlignmentLeft Tag:0];
    self.titleLable.alpha = .5;
    
    self.platformImage = [[UIImageView alloc] init];
    
    self.platformLabel = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:[UIColor blackColor] Font:[UIFont systemFontOfSize:10] TextAlignment:NSTextAlignmentLeft Tag:0];
    self.platformLabel.alpha = .5;
    
    self.priceLable = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:BTColor(252, 99, 100) Font:[UIFont systemFontOfSize:10] TextAlignment:NSTextAlignmentLeft Tag:0];
    
    self.buyImageView = [[UIImageView alloc] init];
    self.buyImageView.image = [UIImage imageNamed:@"icon_product_buy"];

    self.likeImageView = [[UIImageView alloc] init];
    self.likeImageView.image = [UIImage imageNamed:@"product_item_likeicon"];
    
    self.likeLabel = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:[UIColor blackColor] Font:[UIFont systemFontOfSize:11] TextAlignment:NSTextAlignmentLeft Tag:0];
    self.likeLabel.alpha = .5;
    
    self.commentsLable = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:[UIColor blackColor] Font:[UIFont systemFontOfSize:10] TextAlignment:NSTextAlignmentLeft Tag:0];
    self.commentsLable.alpha = .4;
    
    for (int i = 0; i < 3; i ++ ) {
        self.usernameBtn = [BTCommonUtil createButtonFrame:CGRectZero Target:self BgColor:[UIColor clearColor] Title:nil TitleColor:[UIColor blueColor] BgImg:nil action:@selector(likeAction:) Tag:0];
        self.usernameBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        self.usernameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.usernameBtn.titleLabel.alpha = .5;

        self.conentLabel = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:        UIColorC2 Font:[UIFont systemFontOfSize:10] TextAlignment:NSTextAlignmentLeft Tag:0];
        self.contentLable.alpha = .5;
        
        [self.superCellView addSubview:_usernameBtn];
        [self.superCellView addSubview:_conentLabel];
        [self.usernameArr addObject:_usernameBtn];
        [self.conentArr addObject:_conentLabel];
    }
    self.meImageView = [[UIImageView alloc] init];
    self.meImageView.layer.cornerRadius = userHeight/2;
    self.meImageView.layer.masksToBounds = YES;
    self.meImageView.image = [UIImage imageNamed:@"default_loading"];

    self.meTalkBtn = [BTCommonUtil createButtonFrame:CGRectZero Target:self BgColor:[UIColor grayColor] Title:@"我来说两句" TitleColor: [UIColor blackColor] BgImg:nil action:@selector(likeAction:) Tag:0];
    self.meTalkBtn.alpha = .2;//
    self.meTalkBtn.layer.cornerRadius = 100/5;
    self.meTalkBtn.layer.masksToBounds = YES;
    self.meTalkBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    self.meTalkBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.meTalkBtn.titleLabel.alpha = 1;
    self.meTalkBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    
    [self.contentView addSubview:_superCellView];
    [self.superCellView addSubview:_avatarImageView];
    [self.superCellView addSubview:_nicknameLabel];
    [self.superCellView addSubview:_nicknameImage];
    [self.superCellView addSubview:_datestrLable];
    [self.superCellView addSubview:_middlePicImageView];
    [self.superCellView addSubview:_commentBtn];
    [self.superCellView addSubview:_likeBtn];
    [self.superCellView addSubview:_shareItemBtn];
    [self.superCellView addSubview:_editNameImage];
    [self.superCellView addSubview:_contentLable];
    [self.superCellView addSubview:_linkLable];
    [self.superCellView addSubview:_minPicImage];
    [self.superCellView addSubview:_linkView];
    [self.superCellView addSubview:_titleLable];
    [self.superCellView addSubview:_platformImage];
    [self.superCellView addSubview:_platformLabel];
    [self.superCellView addSubview:_priceLable];
    [self.superCellView addSubview:_buyImageView];
    [self.superCellView addSubview:_likeImageView];
    [self.superCellView addSubview:_likeLabel];
    [self.superCellView addSubview:_commentsLable];
    [self.superCellView addSubview:_meImageView];
    [self.superCellView addSubview:_meTalkBtn];
}

- (CGFloat)layoutSuperSubviews {
     desHeight  = [BTCommonUtil getStringSize:_desStr Font:[UIFont systemFontOfSize:12] W:HKUIScreenWidth - 16 Spacing:10].height;
    self.superCellView.frame = CGRectMake(BTZero, BTZero, HKUIScreenWidth, BTZero);
    
    self.avatarImageView.frame = CGRectMake(10, 10, userHeight, userHeight);
    
    self.nicknameLabel.frame = CGRectMake(self.avatarImageView.left + self.avatarImageView.width + 8, self.avatarImageView.top + 10, 50, 10);
    self.nicknameImage.frame = CGRectMake(self.nicknameLabel.width + self.nicknameLabel.left + 10, self.nicknameLabel.top - 5, 16, 15);
    
    self.datestrLable.frame = CGRectMake(HKUIScreenWidth - 100 - 10, self.nicknameLabel.top, 100, self.nicknameLabel.height);
    self.middlePicImageView.frame = CGRectMake(BTZero, self.avatarImageView.top + self.avatarImageView.height + 10, HKUIScreenWidth, HKUIScreenHeight/2);
    self.commentBtn.frame = CGRectMake(self.avatarImageView.left, self.middlePicImageView.top + self.middlePicImageView.height + 10, 23, 23);
    self.likeBtn.frame = CGRectMake(self.commentBtn.left + self.commentBtn.width + 20 , self.commentBtn.top, 24, 21);
    self.shareItemBtn.frame = CGRectMake(self.likeBtn.left + self.likeBtn.width + 20, self.likeBtn.top, 25, 24);
    self.editNameImage.frame = CGRectMake(9, self.shareItemBtn.top + self.shareItemBtn.height + 25, 12, 12);
    [self.tagNameArr enumerateObjectsUsingBlock:^(UILabel *objLable, NSUInteger idx, BOOL * _Nonnull stop) {
        objLable.frame = CGRectMake(self.editNameImage.left + self.editNameImage.width + (35 * idx), self.editNameImage.top, 35, 10);
        if (_tagsArr.count > idx) {
            objLable.text = _tagsArr[idx];
        }
    }];
    self.contentLable.frame = CGRectMake(self.editNameImage.left, self.editNameImage.top + self.editNameImage.height + 10, HKUIScreenWidth - 16,desHeight);
    self.linkLable.frame = CGRectMake(self.editNameImage.left, self.contentLable.top + self.contentLable.height + 10, 100, 10);
    self.minPicImage.frame = CGRectMake(self.linkLable.left, self.linkLable.top + self.linkLable.height + 10, 50, 50);
    self.linkView.frame = CGRectMake(self.minPicImage.left + self.minPicImage.width, self.minPicImage.top, HKUIScreenWidth - 70, self.minPicImage.height);
    self.titleLable.frame = CGRectMake(self.minPicImage.left + self.minPicImage.width + 10, self.minPicImage.top + 10, HKUIScreenWidth - 130, 12);
    self.platformImage.frame = CGRectMake(self.titleLable.left, self.titleLable.top + self.titleLable.height + 10, 16, 14);
    self.platformLabel.frame = CGRectMake(self.platformImage.left + self.platformImage.width + 8, self.platformImage.top + 3, 50, 10);
    self.priceLable.frame = CGRectMake(self.platformLabel.left + self.platformLabel.width + 7, self.platformLabel.top, 100, 10);
    self.buyImageView.frame = CGRectMake(HKUIScreenWidth - 40, self.titleLable.top + self.titleLable.height - 3, 18, 19);
    self.likeImageView.frame = CGRectMake(self.minPicImage.left, self.minPicImage.top + self.minPicImage.height + 15, 13, 11);
    self.likeLabel.frame = CGRectMake(self.likeImageView.left + self.likeImageView.width + 3, self.likeImageView.top, HKUIScreenWidth/2, 10);
    self.commentsLable.frame = CGRectMake(self.likeImageView.left, self.likeImageView.top + self.likeImageView.height + 10, HKUIScreenWidth/2, 10);
    
    if (_commentsArr.count > 0) {
        [_usernameArr enumerateObjectsUsingBlock:^(UIButton *objBtn, NSUInteger idx, BOOL * _Nonnull stop) {
            if (_commentsArr.count > idx) {
                [objBtn setTitle:[NSString stringWithFormat:@"%@:",_commentsArr[idx]] forState:UIControlStateNormal];
                CGFloat userWidth = [BTCommonUtil getFontSize:[UIFont systemFontOfSize:10] Text:_commentsArr[idx]].width;
                objBtn.frame = CGRectMake(self.commentsLable.left,10 + self.commentsLable.top + self.commentsLable.height + (idx * 15), userWidth + 5, 20);
                objBtn.backgroundColor = [UIColor clearColor];
                
                UILabel *commentLable = _conentArr[idx];
                commentLable.frame = CGRectMake(objBtn.left +userWidth + 5, 10 + self.commentsLable.top + self.commentsLable.height + (idx * 15), HKUIScreenWidth - 130, 20);
                commentLable.text = _conentUserArr[idx];
            
            }
        }];
    }
    
    
        if (_commentsArr.count > _usernameArr.count) {
            superHeight = _usernameArr.count;
        }else if (_commentsArr.count == 0){
            superHeight = 0;
        }else {
            superHeight = _commentsArr.count;
        }
    self.meImageView.frame = CGRectMake(self.commentsLable.left, self.commentsLable.top + self.commentsLable.height +(superHeight * 17)+ 15, userHeight, userHeight);
    self.meTalkBtn.frame = CGRectMake(self.meImageView.left + self.meImageView.width + 10, self.meImageView.top, HKUIScreenWidth - userHeight - 25, self.meImageView.height);
    self.superCellView.height = self.meImageView.top + self.meImageView.height + 15 + 5;
    
    [_commentsArr removeAllObjects];
    
    return self.commentsLable.top + self.commentsLable.height + 15;
}
- (void)setPostListArr:(NSMutableArray *)postListArr {
    _postListArr = postListArr;
    BTPublikeZCPostListMode *model = (BTPublikeZCPostListMode*)postListArr;
   [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.author[@"avatar"]]placeholderImage:[UIImage imageNamed:@"default_loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       
   }];
    self.nicknameLabel.text = model.author[@"nickname"];
    self.datestrLable.text = model.datestr;
    [self.middlePicImageView sd_setImageWithURL:[NSURL URLWithString:model.middle_pic_url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    [model.tags enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.tagsArr addObject:obj[@"name"]];
    }];
    [model.product enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.minPicImage sd_setImageWithURL:[NSURL URLWithString:obj[@"pic"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        self.titleLable.text = obj[@"title"];
        if ([obj[@"platform"] integerValue] == 1) {
            self.platformImage.image = [UIImage imageNamed:@"icon_order_list_tb"];
            self.platformLabel.text = @"来自淘宝";
        }else if ([obj[@"platform"] integerValue] == 2) {
            self.platformImage.image = [UIImage imageNamed:@"icon_order_list_tm"];
            self.platformLabel.text = @"来自天猫";
        }else if ([obj[@"platform"] integerValue] == 3) {
            self.platformImage.image = [UIImage imageNamed:@"icon_order_list_jd"];
            self.platformLabel.text = @"来自京东";
        }
        self.priceLable.text = [NSString stringWithFormat:@"¥%@",obj[@"price"]];
    }];
    self.likeLabel.text = [NSString stringWithFormat:@"%@人喜欢",model.dynamic[@"likes"]];
    self.commentsLable.text = [NSString stringWithFormat:@"所有%@评论",model.dynamic[@"comments"]];
//    _commentBtn.width
    [model.comments enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [_usernameArr[idx] setTitle:[NSString stringWithFormat:@"%@:",obj[@"username"]] forState:UIControlStateNormal];
        NSLog(@"%lf",[BTCommonUtil getFontSize:[UIFont systemFontOfSize:9] Text:obj[@"username"]].width);
        [_commentsArr addObject:obj[@"username"]];
        [_conentUserArr addObject:obj[@"conent"]];
    }];
    
    //platform 判读天猫还是淘宝
    self.desStr = model.content;
}

- (void)setDesStr:(NSString *)desStr {
    _desStr = desStr;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_desStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [desStr length])];
    _contentLable.attributedText = attributedString;
//    [self.contentLable sizeToFit];

    [self layoutSuperSubviews];
}
@end
