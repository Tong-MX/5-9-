//
//  BTSHoppViewCell.m
//  BTProject
//
//  Created by 明桐的Mac on 16/4/29.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTSHoppViewCell.h"

static NSString *cellIdetify = @"cell";
static NSString *cellIdetifyRecomed = @"cellRecomed";

@interface BTSHoppViewCell()<UITableViewDataSource,UITableViewDelegate,BTShoppingPayClickActionDelegate>{
    CGFloat desHeight;
    CGFloat alphaFloat;
    CGFloat cellHeight;//提前计算高度
    BOOL isForRepect;//判断是否计算出高度
    CGFloat desHeightCell;
    NSInteger recodertag;//全局tag值
}
@property (nonatomic, strong)UILabel *desLabel;
@property (nonatomic, strong)UIButton *concentrationBtn;
@property (nonatomic, strong)UIButton *recommendBtn;
@property (nonatomic, strong)UIView *titleView;
@property (nonatomic, strong)UIView *btnView;
@property (nonatomic, strong)BTSHoppingTableVIewCell *myCellTableView;
@property (nonatomic, strong)NSMutableArray *dataSoucre;
@property (nonatomic, strong)NSMutableArray *imageGoodeArr;
@property (nonatomic, strong)NSMutableArray *cellHeightArr;
@end
@implementation BTSHoppViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initParameters];
        [self creatHearderUI];
        [self createTableView];
    }
    return self;
}

- (void)initParameters {
    self.dataSoucre = [NSMutableArray array];
    self.imageGoodeArr = [NSMutableArray array];
    self.cellHeightArr = [NSMutableArray array];
    _myCellTableView = [[BTSHoppingTableVIewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetify Size:CGSizeMake(HKUIScreenWidth, 200)];
    isForRepect = NO;
    recodertag = 0;
}

#pragma mark 创建头视图

- (void)creatHearderUI {
    self.headerView = [[UIView alloc] initWithFrame:CGRectZero];
    self.headerView.backgroundColor = [UIColor whiteColor];
    self.headerView.userInteractionEnabled = YES;
    
    self.headerOtherView = [[UIView alloc] initWithFrame:CGRectZero];
    self.headerOtherView.backgroundColor = [UIColor whiteColor];
    self.headerOtherView.userInteractionEnabled = YES;
    
    self.snapShotView = [[UIImageView alloc] init];
    self.snapShotView.contentMode = UIViewContentModeScaleAspectFill;
    _snapShotView.clipsToBounds = YES;
    _snapShotView.userInteractionEnabled = YES;
    _snapShotView.backgroundColor = [UIColor clearColor];
    _snapShotView.alpha = 0;
    self.titleLabel = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:UIColorC2 Font:[UIFont systemFontOfSize:17] TextAlignment:NSTextAlignmentLeft Tag:0];
    self.titleLabel.numberOfLines = 1;
    
    self.desLabel = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:UIColorC2 Font:[UIFont systemFontOfSize:15] TextAlignment:NSTextAlignmentLeft Tag:0];
    self.desLabel.numberOfLines = 0;
    self.desLabel.alpha = .8;
    self.desLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    self.btnView = [[UIView alloc] init];
    self.btnView.backgroundColor = [UIColor whiteColor];
    
    self.concentrationBtn = [BTCommonUtil createButtonFrame:CGRectZero Target:self BgColor:nil Title:@"半塘精选" TitleColor:UIColorC2 BgImg:nil action:@selector(clickAction:) Tag:0];
    self.concentrationBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.concentrationBtn.selected = YES;
    
    self.recommendBtn = [BTCommonUtil createButtonFrame:CGRectZero Target:self BgColor:nil Title:@"用户推荐" TitleColor:UIColorC2 BgImg:nil action:@selector(clickAction:) Tag:1];
    self.recommendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    self.titleView = [[UIView alloc] init];
    self.titleView.backgroundColor = BTColor(242, 117, 172);
    
    [self.headerView addSubview:self.snapShotView];
    [self.headerView addSubview:self.headerOtherView];
    [self.headerOtherView addSubview:self.titleLabel];
    [self.headerOtherView addSubview:self.desLabel];
    [self.headerOtherView addSubview:self.btnView];
    [self.btnView addSubview:self.concentrationBtn];
    [self.btnView addSubview:self.recommendBtn];
    [self.btnView addSubview:self.titleView];
}

#pragma mark set方法传出str值调整行与行间距

- (void)setDesStr:(NSString *)desStr {
    _desStr = desStr;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_desStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_desStr length])];
    _desLabel.attributedText = attributedString;
    [self.desLabel sizeToFit];
    //    [BTCommonUtil getAttributedStringSize:attributedString Font:[UIFont systemFontOfSize:15] W:_desLabel.width Spacing:10];
    [self layoutSubviewsHeader];
}

- (void)layoutSubviewsHeader {
    desHeight  = [BTCommonUtil getStringSize:_desStr Font:[UIFont systemFontOfSize:15] W:HKUIScreenWidth - 18 Spacing:10].height;
    
    self.titleLabel.frame = CGRectMake(10, 10, HKUIScreenWidth - 20, 20);
    self.desLabel.frame = CGRectMake(self.titleLabel.left, self.titleLabel.top + self.titleLabel.height + 10, HKUIScreenWidth - 18, desHeight);
    self.btnView.frame = CGRectMake(BTZero, self.desLabel.top + self.desLabel.height + 20, HKUIScreenWidth, 42);
    self.concentrationBtn.frame = CGRectMake(30, 7, 90, 30);
    self.recommendBtn.frame = CGRectMake(HKUIScreenWidth - 130,_concentrationBtn.top, self.concentrationBtn.width, self.concentrationBtn.height);
    self.titleView.frame = CGRectMake(self.concentrationBtn.left, self.concentrationBtn.top + self.concentrationBtn.height + 3, self.concentrationBtn.width + 10, 2);
    self.headerOtherView.frame = CGRectMake(BTZero, 200, HKUIScreenWidth,desHeight + self.titleLabel.height +  self.concentrationBtn.height + self.titleView.height + 60);
    self.snapShotView.frame = CGRectMake(BTZero, BTZero, HKUIScreenWidth, 200);
    self.headerView.frame = CGRectMake(BTZero, BTZero, HKUIScreenWidth, self.headerOtherView.height + 200 + 10);
    self.homeTableView.tableHeaderView.userInteractionEnabled = YES;
    self.homeTableView.tableHeaderView = self.headerView;
}
#pragma mark 创建tableView

- (void)createTableView {
    self.homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(BTZero, BTZero, HKUIScreenWidth, HKUIScreenHeight) style:UITableViewStylePlain];
    _homeTableView.backgroundColor = [UIColor whiteColor];
    _homeTableView.delegate = self;
    _homeTableView.dataSource = self;
    _homeTableView.scrollsToTop = YES;
    _homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView addSubview:_homeTableView];
}


#pragma mark tableView的delagaet

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (recodertag == 1) {
        return 1;
    }else {
    
        return _dataSoucre.count;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (recodertag == 1) {
        return 490 + 20;
    }else {
        self.myCellTableView.dataSoucreTable = _dataSoucre[indexPath.row];
        if (_dataSoucre.count > 0) {
            BTshoppingModel *model = (BTshoppingModel*)_dataSoucre[indexPath.row];
            if (model.pic.count == 2) {
                cellHeight = [self.myCellTableView layoutSubviewsRepet];
            }else if (model.pic.count == 1) {
                cellHeight = [self.myCellTableView layoutSubviewsRepet];
            }
        }
        
        return cellHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (recodertag == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdetifyRecomed];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetifyRecomed];
        cell.backgroundColor = [UIColor clearColor];
        UIButton *topPostWeiKongBtn = [BTCommonUtil createButtonFrame:CGRectMake(BTZero, BTZero, HKUIScreenWidth, 400) Target:self BgColor:nil Title:nil TitleColor:nil BgImg:[UIImage imageNamed:@"topicPost_weikong"] action:@selector(photoAction:) Tag:0];
        [cell.contentView addSubview:topPostWeiKongBtn];
        return cell;
    }else {
        self.myCellTableView = (BTSHoppingTableVIewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdetify];
        
        if (!_myCellTableView) {
            _myCellTableView = [[BTSHoppingTableVIewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetify Size:CGSizeMake(HKUIScreenWidth, 200)];
        }
        _myCellTableView.backgroundColor = BTColor(231, 231, 231);
    }
    return _myCellTableView;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (recodertag == 1) {
    
    }else {
        BTSHoppingTableVIewCell *myCell = (BTSHoppingTableVIewCell*)cell;
        myCell.buyDelegate = self;
        myCell.dataSoucreTable = _dataSoucre[indexPath.row];
        myCell.imageGoodeArr = _imageGoodeArr[indexPath.row];
        myCell.buyBtn.tag = indexPath.row;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    MTLog(@"%ld",indexPath.row);
}

- (void)payBuyActionWithTagCell:(NSInteger)tagCell {
    if (_delegateScrolle && [_delegateScrolle respondsToSelector:@selector(payBuyActionWithShopingModel:)]) {
        [_delegateScrolle payBuyActionWithShopingModel:_dataSoucre[tagCell]];
    }
}
- (void)setProductMutalbe:(NSMutableArray *)productMutalbe {
    _productMutalbe = productMutalbe;
    for (int i = 0; i < productMutalbe.count; i++) {
        if (i + 1 <= 20) {
            NSString *imageStr = [NSString stringWithFormat:@"good%d",i+1];
            [_imageGoodeArr addObject:[UIImage imageNamed:imageStr]];
        }
    }
    _dataSoucre = productMutalbe;
    [_homeTableView reloadData];
}

- (void)clickAction:(UIButton*)btn {
    CGFloat leftFloat;
    if (btn.tag == 0) {
        _concentrationBtn.selected = !_concentrationBtn.selected;
        leftFloat = _concentrationBtn.left;
        recodertag = btn.tag;
        [self.homeTableView reloadData];
    }else if (btn.tag == 1) {
        _recommendBtn.selected = !_recommendBtn.selected;
        leftFloat = _recommendBtn.left;
        recodertag = btn.tag;
        [self.homeTableView reloadData];
    }
    [UIView animateWithDuration:.3 animations:^{
        _titleView.left = leftFloat;
    }];
}

- (void)photoAction:(UIButton *)btn {
    if (_delegateScrolle && [_delegateScrolle respondsToSelector:@selector(clickPhotoDelegate)]) {
        [_delegateScrolle clickPhotoDelegate];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y > 20) {
        alphaFloat = scrollView.contentOffset.y / ((self.headerView.height - 115));
        if (alphaFloat >= .99) {
            self.btnView.top = 62;
            [self.contentView addSubview:self.btnView];
            return;
        }else {
            self.btnView.top = self.desLabel.top + self.desLabel.height + 20;
            [self.headerOtherView addSubview:self.btnView];
        }
    }else if (scrollView.contentOffset.y <= 20){
        alphaFloat = scrollView.contentOffset.y / ((self.headerView.height + self.snapShotView.height - 60 - 5));
    }
    
    if (scrollView.contentOffset.y == 0) {
        return;
    }else {
        self.scolleViewSetY = scrollView.contentOffset.y;
        if (_delegateScrolle && [_delegateScrolle respondsToSelector:@selector(transletSetYData:headerViewHeight:)]) {
            [_delegateScrolle transletSetYData:scrollView.contentOffset.y headerViewHeight:self.headerView.height];
        }
    }
    
    self.headerView.top =  -scrollView.contentOffset.y + 200;
    if (scrollView.contentOffset.y < 0) {
        CGFloat newheight = ABS(scrollView.contentOffset.y) + 200;
        // 2.计算图片变大后的宽度
        CGFloat newWidth = HKUIScreenWidth / 200 * newheight;
        self.snapShotView.frame = CGRectMake(-(newWidth - HKUIScreenWidth) / 2, scrollView.contentOffset.y, newWidth, newheight);
    }
}

- (void)resumeNormolStata {
    self.btnView.top = self.desLabel.top + self.desLabel.height + 20;
    [self.headerOtherView addSubview:self.btnView];
}
@end
