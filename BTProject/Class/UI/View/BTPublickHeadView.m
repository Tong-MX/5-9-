//
//  BTPublickHeadView.m
//  BTProject
//
//  Created by 明桐的Mac on 16/4/15.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTPublickHeadView.h"
#import "BTPublickCollectionViewCell.h"
#import "BTPublickModEleModel.h"
#import "BTPublicModel.h"
@interface BTPublickHeadView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout> {
    BOOL    recodeBool;
    NSInteger recodeData;
    NSInteger i;
}
@property (nonatomic ,strong)UIButton *titileBtn;
@property (nonatomic ,strong)NSString *recodeStr;
@property (nonatomic ,strong)NSMutableArray *titileArr;
@property (nonatomic ,strong)UICollectionView *publicCollecionView;
@property (nonatomic ,strong)BTPublickCollectionViewCell *myCell;
@property (nonatomic ,strong)NSMutableArray *dataSouce;
@property (nonatomic ,strong)NSMutableArray *publicModelArr;

@property (nonatomic ,strong)NSMutableArray *imageArr;
@property (nonatomic ,strong)NSMutableArray *nameArr;
@property (nonatomic ,strong)NSMutableArray *popularityArr;
@property (nonatomic ,strong)NSMutableArray *tmpBtn;
@property (nonatomic ,strong)UIView *titleView;
@property (nonatomic ,strong)NSIndexPath *indexPath;
@end
@implementation BTPublickHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self initParameters];
        self.backgroundColor = UIColorC3;
    }
    return self;
}

#pragma mark 初始化
- (void)initParameters {
    _publicModelArr = [NSMutableArray array];
    _dataSouce = [NSMutableArray array];
    self.imageArr = [NSMutableArray array];
    self.popularityArr = [NSMutableArray array];
    self.nameArr = [NSMutableArray array];
    self.titileArr = [NSMutableArray array];
    self.tmpBtn = [NSMutableArray array];
    self.titleView = [[UIView alloc] init];
}
#pragma mark 创建导航按钮
- (void)creatCollectionView{
    [_upDataDic[@"upDataArr"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BTPublickModEleModel *model = (BTPublickModEleModel*)obj;
        self.titileBtn = [BTCommonUtil createButtonFrame:CGRectMake(idx * HKUIScreenWidth/4 ,BTZero + [BTCommonUtil setHeightPX:28],HKUIScreenWidth/4,20) Target:self BgColor:nil Title:model.title TitleColor:BTColor(133, 133, 133) BgImg:nil action:@selector(titleClickAction:) Tag:idx+0.0];
        _titileBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_titileBtn setTitleColor:UIColorC17 forState:UIControlStateSelected];
        if (idx == 0) {
            _titileBtn.selected = YES;
            _titleView.frame = CGRectMake(_titileBtn.left + 15,_titileBtn.top + _titileBtn.height + 10, _titileBtn.width/1.5, 2);
            _titleView.backgroundColor = BTColor(242, 117, 172);
            _recodeStr = model.title;
        }
        [_titileArr addObject:model.title];
        [self addSubview:_titileBtn];
        [self addSubview:_titleView];
        [_tmpBtn addObject:_titileBtn];
    }];
}

#pragma mark btn点击事件
- (void)titleClickAction:(UIButton*)sender {
    [UIView animateWithDuration:.5 animations:^{
        
    }];
    for (UIButton* btn in self.tmpBtn) {
        if (btn != sender) {
            btn.selected = NO;
        }else {
            [UIView animateWithDuration:.3 animations:^{
                btn.selected = YES;
                self.titleView.frame = CGRectMake(btn.tag + btn.left + 15, _titileBtn.top + _titileBtn.height + 10, _titileBtn.width/1.5, 2);
            }];
        }
    }
    if (sender.tag > recodeData) {
        [_publicCollecionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:3 inSection:sender.tag] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }else if (sender.tag < recodeData) {
        [_publicCollecionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:sender.tag] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }else {
        [_publicCollecionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:sender.tag] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    recodeData = sender.tag;
    i = sender.tag;
}
#pragma mark 创建滑动视图的colleciton
- (void)creatCollecionViewScrollView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(HKUIScreenWidth / 4, self.height);
    layout.minimumLineSpacing = 0;
    self.publicCollecionView = [[UICollectionView alloc] initWithFrame:CGRectMake(BTZero, self.titileBtn.frame.origin.y + _titileBtn.height, HKUIScreenWidth,self.height) collectionViewLayout:layout];
    self.publicCollecionView.bounces = NO;
    self.publicCollecionView.scrollsToTop = YES;
    self.publicCollecionView.backgroundColor = [UIColor clearColor];
    self.publicCollecionView.delegate = self;
    self.publicCollecionView.showsVerticalScrollIndicator = YES;
    self.publicCollecionView.pagingEnabled = YES;
    self.publicCollecionView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    [self addSubview:_publicCollecionView];
    
    [_publicCollecionView registerClass:[BTPublickCollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    _publicCollecionView.delegate = self;
    _publicCollecionView.dataSource = self;
}


//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section

{   //cell竖行个数因为是横向滑动的
    return 4;
}

//定义展示的Section的个数竖行多少个
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}
#pragma mark collectionViewCell
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    _myCell = (BTPublickCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    _indexPath = indexPath;
    return _myCell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self setCellImageNameWithIndexPath:indexPath];

}

#pragma mark 为cell里的标题图片传值
- (void)setCellImageNameWithIndexPath:(NSIndexPath*)indexPath {

    if (indexPath.section == 0) {
        [_myCell.titleOneBtn sd_setBackgroundImageWithURL:_imageArr[indexPath.row] forState:UIControlStateNormal];
        [_myCell.titleTwoBtn sd_setBackgroundImageWithURL:_imageArr[indexPath.row + 4] forState:UIControlStateNormal];
        
        _myCell.nameOneLabel.text = _nameArr[indexPath.row];
        _myCell.nameTwoLabel.text = _nameArr[indexPath.row + 4];
        
        _myCell.popularityOneLabel.text = _popularityArr[indexPath.row];
        _myCell.popularityTwoLabel.text = _popularityArr[indexPath.row + 4];

    }else if (indexPath.section == 1) {
        [_myCell.titleOneBtn sd_setBackgroundImageWithURL:_imageArr[indexPath.row + 8] forState:UIControlStateNormal];
        [_myCell.titleTwoBtn sd_setBackgroundImageWithURL:_imageArr[indexPath.row + 12] forState:UIControlStateNormal];
        
        _myCell.nameOneLabel.text = _nameArr[indexPath.row + 8];
        _myCell.nameTwoLabel.text = _nameArr[indexPath.row + 12];
        
        _myCell.popularityOneLabel.text = _popularityArr[indexPath.row + 8];
        _myCell.popularityTwoLabel.text = _popularityArr[indexPath.row + 12];
    }else if (indexPath.section == 2) {
        [_myCell.titleOneBtn sd_setBackgroundImageWithURL:_imageArr[indexPath.row + 16] forState:UIControlStateNormal];
        [_myCell.titleTwoBtn sd_setBackgroundImageWithURL:_imageArr[indexPath.row + 20] forState:UIControlStateNormal];
        
        _myCell.nameOneLabel.text = _nameArr[indexPath.row + 16];
        _myCell.nameTwoLabel.text = _nameArr[indexPath.row + 20];
        
        _myCell.popularityOneLabel.text = _popularityArr[indexPath.row + 16];
        _myCell.popularityTwoLabel.text = _popularityArr[indexPath.row + 20];
    }else if (indexPath.section == 3) {
        [_myCell.titleOneBtn sd_setBackgroundImageWithURL:_imageArr[indexPath.row + 24] forState:UIControlStateNormal];
        [_myCell.titleTwoBtn sd_setBackgroundImageWithURL:_imageArr[indexPath.row + 28] forState:UIControlStateNormal];
        
        _myCell.nameOneLabel.text = _nameArr[indexPath.row + 24];
        _myCell.nameTwoLabel.text = _nameArr[indexPath.row + 28];
        _myCell.popularityOneLabel.text = _popularityArr[indexPath.row + 24];
        _myCell.popularityTwoLabel.text = _popularityArr[indexPath.row + 28];
    }
}
#pragma set方法传送model数组循环出热门推荐的数据
- (void)setUpDataDic:(NSDictionary *)upDataDic{
    _upDataDic = upDataDic;

    [_upDataDic[@"publickHeadTitelArr"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [_dataSouce addObject:obj];
    }];
    //双循环全部取出
    [_dataSouce enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BTPublicModel *model = [BTPublicModel publickWithDic:obj];
            [_imageArr addObject:model.photo];
            [_popularityArr addObject:model.sub_title];
            [_nameArr addObject:model.title];
            
        }];
    }];

    [self creatCollectionView];
    [self creatCollecionViewScrollView];
    [_publicCollecionView reloadData];

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    i = scrollView.contentOffset.x / HKUIScreenWidth;
    UIButton *btn = _tmpBtn[i];
    for (UIButton *btn1 in _tmpBtn) {
        if (btn != btn1) {
            btn1.selected = NO;
        }else {
            btn.selected = YES;
            [UIView animateWithDuration:.3 animations:^{
                self.titleView.frame = CGRectMake(3 + btn.left + 15, btn.top + btn.height + 10, btn.width/1.5, 2);
            }];
        }
    }
    
}
@end
