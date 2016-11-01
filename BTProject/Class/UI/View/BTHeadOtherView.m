//
//  BTHeadOtherView.m
//  BTProject
//
//  Created by 明桐的Mac on 16/3/27.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTHeadOtherView.h"
#import "BTHomeModel.h"
#import "BTDownMoreLoadFile.h"
#import "BTTitleScrollCollectionViewCell.h"
#import "BTHomeViewController.h"
#import "BTWebViewController.h"
#import <objc/runtime.h>
#define TagUI @"其他头视图"
@interface BTHeadOtherView()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,BTTitleScrollCollectionViewCellDelegate>

@property (nonatomic ,strong)NSMutableArray *photoArray;
@property (nonatomic ,strong)NSMutableArray *titleArray;
@property (nonatomic ,strong)NSMutableArray *categoryTitlArr;
@property (nonatomic ,strong)UIButton *haoWuButton;
@property (nonatomic ,strong)UIButton *searchButton;
@property (nonatomic ,strong)UIButton *seedingButton;
@property (nonatomic ,strong)UIButton *registerButton;
@property (nonatomic ,strong)UILabel *tagLable;
@property (nonatomic ,strong)UILabel *seedingLable;
@property (nonatomic ,strong)UILabel *searchLable;
@property (nonatomic ,strong)UILabel *registerLable;
@property (nonatomic ,strong)UICollectionView *collectionTitle;
@property (nonatomic ,strong)UIButton *hotButton;
@property (nonatomic ,strong)NSMutableArray *loadTitlArr;
@property (nonatomic ,strong)BTTitleScrollCollectionViewCell *myCell;

@property (nonatomic, assign) NSInteger *selectedIndex;
@property (nonatomic, copy) NSString *titleName;

@end
@implementation BTHeadOtherView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor redColor];
        
        [self creatButtonViewAndScroolTielView];
        [self creatCollectionView];
        self.titleName = @"最新";
        //运行时方法
//        unsigned int count;
//        objc_property_t *person = class_copyPropertyList([NSArray class], &count);
//        NSMutableArray *arr = [NSMutableArray array];
//        for (int i = 0; i < count; i++) {
//            //获取该类的一个属性指针
//            objc_property_t property = person[i];
//            const char *name = property_getName(property);
//            NSString *key = [NSString stringWithUTF8String:name];
//            
//            [arr addObject:key];
//        }
//        free(person);
        
    }
    
    return self;
}
- (void)creatButtonViewAndScroolTielView{
    self.haoWuButton = [BTCommonUtil createButtonFrame:CGRectMake([BTCommonUtil setWidthPX:50],[BTCommonUtil setHeightPX:30],[BTCommonUtil setWidthPX:100],[BTCommonUtil setHeightPX:100]) Target:nil BgColor:nil Title:nil TitleColor:nil BgImg:nil action:@selector(clickAction:) Tag:1];
    self.searchButton = [BTCommonUtil createButtonFrame:CGRectMake([BTCommonUtil setWidthPX:235],[BTCommonUtil setHeightPX:30], [BTCommonUtil setWidthPX:100], [BTCommonUtil setHeightPX:100]) Target:nil BgColor:nil Title:nil TitleColor:nil BgImg:nil action:@selector(clickAction:) Tag:2];
    self.seedingButton = [BTCommonUtil createButtonFrame:CGRectMake([BTCommonUtil setWidthPX:435], [BTCommonUtil setHeightPX:30], [BTCommonUtil setWidthPX:100], [BTCommonUtil setHeightPX:100]) Target:nil BgColor:nil Title:nil TitleColor:nil BgImg:nil action:@selector(clickAction:) Tag:3];
    self.registerButton = [BTCommonUtil createButtonFrame:CGRectMake([BTCommonUtil setWidthPX:610], [BTCommonUtil setHeightPX:30], [BTCommonUtil setWidthPX:100], [BTCommonUtil setHeightPX:100]) Target:nil BgColor:nil Title:nil TitleColor:nil BgImg:nil action:@selector(clickAction:) Tag:4];
    
    self.tagLable = [BTCommonUtil createLabelFrame:CGRectMake([BTCommonUtil setWidthPX:50],[BTCommonUtil setHeightPX:30] + self.haoWuButton.frame.size.height - [BTCommonUtil setHeightPX:18],[BTCommonUtil setWidthPX:100],[BTCommonUtil setHeightPX:120]) BgColor:nil Text:nil textColor:BTColor(133, 133, 133) Font:[UIFont systemFontOfSize:13] TextAlignment:NSTextAlignmentCenter Tag:0];
    self.searchLable = [BTCommonUtil createLabelFrame:CGRectMake([BTCommonUtil setWidthPX:235],self.haoWuButton.frame.size.height + [BTCommonUtil setHeightPX:30] - [BTCommonUtil setHeightPX:18],[BTCommonUtil setWidthPX:100],[BTCommonUtil setHeightPX:120]) BgColor:nil Text:nil textColor:BTColor(133, 133, 133) Font:[UIFont systemFontOfSize:13] TextAlignment:NSTextAlignmentCenter Tag:0];
    self.seedingLable = [BTCommonUtil createLabelFrame:CGRectMake([BTCommonUtil setWidthPX:435], [BTCommonUtil setHeightPX:30] + self.haoWuButton.frame.size.height - [BTCommonUtil setHeightPX:18], [BTCommonUtil setWidthPX:100], [BTCommonUtil setHeightPX:120]) BgColor:nil Text:nil textColor:BTColor(133, 133, 133) Font:[UIFont systemFontOfSize:13] TextAlignment:NSTextAlignmentCenter Tag:0];
    self.registerLable = [BTCommonUtil createLabelFrame:CGRectMake([BTCommonUtil setWidthPX:610], [BTCommonUtil setHeightPX:30] + self.haoWuButton.frame.size.height - [BTCommonUtil setHeightPX:18], [BTCommonUtil setWidthPX:100],[BTCommonUtil setHeightPX:120]) BgColor:nil Text:nil textColor:BTColor(133, 133, 133) Font:[UIFont systemFontOfSize:13] TextAlignment:NSTextAlignmentCenter Tag:0];
    
    [self addSubview:_searchLable];
    [self addSubview:_tagLable];
    [self addSubview:_seedingLable];
    [self addSubview:_registerLable];
    [self addSubview:_haoWuButton];
    [self addSubview:_searchButton];
    [self addSubview:_seedingButton];
    [self addSubview:_registerButton];
    
    _loadTitlArr = [NSMutableArray array];
    [_loadTitlArr addObject:@"最新"];
//    [BTPreferences setOterHeadView:nil];
    NSMutableArray *arrOtherArr = [BTPreferences oterHeadView];
    NSMutableArray *arrOtherTitle = [BTPreferences otherHeadViewTitle];
    NSMutableArray *arrOtherScollTitle = [BTPreferences otherHeadViewScrollTitle];
    [_loadTitlArr addObjectsFromArray:arrOtherScollTitle];
    if (arrOtherArr.count > 0 && arrOtherTitle.count > 0) {
//        [self.haoWuButton setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:arrOtherArr[0]]]] forState:UIControlStateNormal];
//        [self.searchButton setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:arrOtherArr[1]]]] forState:UIControlStateNormal];
//        [self.seedingButton setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:arrOtherArr[2]]]] forState:UIControlStateNormal];
//        [self.registerButton setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:arrOtherArr[3]]]] forState:UIControlStateNormal];
//异步请求图片
            [self.haoWuButton sd_setBackgroundImageWithURL:[NSURL URLWithString:arrOtherArr[0]] forState:UIControlStateNormal placeholderImage:nil];
            [self.searchButton sd_setBackgroundImageWithURL:[NSURL URLWithString:arrOtherArr[1]] forState:UIControlStateNormal placeholderImage:nil];
            [self.seedingButton sd_setBackgroundImageWithURL:[NSURL URLWithString:arrOtherArr[2]] forState:UIControlStateNormal placeholderImage:nil];
            [self.registerButton sd_setBackgroundImageWithURL:[NSURL URLWithString:arrOtherArr[3]] forState:UIControlStateNormal placeholderImage:nil];

            self.tagLable.text = arrOtherTitle[0];
            self.searchLable.text = arrOtherTitle[1];
            self.seedingLable.text = arrOtherTitle[2];
            self.registerLable.text = arrOtherTitle[3];
    }
    
}

- (void)creatCollectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 30;
    layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionTitle = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 70, HKUIScreenWidth, 40) collectionViewLayout:layout];
    _collectionTitle.backgroundColor = [UIColor clearColor];
    //禁止collectionView 的滑动
    _collectionTitle.scrollEnabled = YES;
    _collectionTitle.showsHorizontalScrollIndicator = YES;
    _collectionTitle.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    [self addSubview:_collectionTitle];
    
    [_collectionTitle registerClass:[BTTitleScrollCollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];

    _collectionTitle.delegate = self;
    _collectionTitle.dataSource = self;
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _loadTitlArr.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BTTitleScrollCollectionViewCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    if (_loadTitlArr.count > 0) {
        [myCell.titleBtn setTitle:_loadTitlArr[indexPath.row] forState:UIControlStateNormal];
        myCell.delegate = self;
        myCell.indexPath = indexPath;

        if ([_loadTitlArr[indexPath.item] isEqualToString:self.titleName]) {
                myCell.titleBtn.selected = YES;
                myCell.titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                myCell.titleView.backgroundColor = BTColor(242, 117, 172);
        }else {
            myCell.titleBtn.selected = NO;
            myCell.titleBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            myCell.titleView.backgroundColor = [UIColor clearColor];
        }
    }
    return myCell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *title = _loadTitlArr[indexPath.row];
    return CGSizeMake(14.0 * title.length, 40);
}

////设置每个item垂直间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 30;
//}

- (void)didSelectedBtnWithIndexPath:(NSIndexPath *)indexPath withBtn:(UIButton *)titleBtn {
    NSLog(@"%ld",indexPath.row);
    self.titleName = _loadTitlArr[indexPath.row];
    [self.collectionTitle scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];//选中的Item居中方法
    if ([_delegate respondsToSelector:@selector(collectionWithButtonclickTag:)]) {
        [_delegate collectionWithButtonclickTag:indexPath];
    }
    [self.collectionTitle reloadData];
}


- (void)clickAction:(UIButton*)btn{
    if (btn.tag == 1) {
       
        NSLog(@"好物%ld",(long)btn.tag);
    }else if (btn.tag == 2){
        NSLog(@"点击%ld",(long)btn.tag);
    }else if (btn.tag == 3){
        NSLog(@"点击%ld",(long)btn.tag);
    }else if (btn.tag == 4){
        NSLog(@"点击%ld",(long)btn.tag);
    }
    
}
- (void)setBannerCategoryDic:(NSDictionary *)bannerCategoryDic{
    dispatch_queue_t queue1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 2.在并行队列里面添加异步任务
    dispatch_async(queue1, ^{
        // 多线程的入口
        @autoreleasepool {
        
            self.photoArray = [NSMutableArray array];
            self.titleArray = [NSMutableArray array];
            self.categoryTitlArr = [NSMutableArray array];
            NSMutableArray *bannerBottomArr = bannerCategoryDic[@"bannerBottom"];
            NSMutableArray *categoryArr = bannerCategoryDic[@"category"];
            
            for (BTHomeModel *bannerModel in bannerBottomArr) {
                [_photoArray addObject:bannerModel.photo];
                [_titleArray addObject:bannerModel.title];
            }
            
            for (BTHomeModel *categoryModel in categoryArr) {
                [_categoryTitlArr addObject:categoryModel.title];
            }
                [BTLog trace: TagUI Content:@"请求的下载数据成功"];
                [BTPreferences setOterHeadView:_photoArray];
                [BTPreferences setOtherHeadViewTitle:_titleArray];
                [BTPreferences setOtherHeadViewScrollTitle:_categoryTitlArr];
            if (_photoArray.count > 0) {
                [self.haoWuButton sd_setBackgroundImageWithURL:[NSURL URLWithString:_photoArray[0]] forState:UIControlStateNormal placeholderImage:nil];
                [self.searchButton sd_setBackgroundImageWithURL:[NSURL URLWithString:_photoArray[1]] forState:UIControlStateNormal placeholderImage:nil];
                [self.seedingButton sd_setBackgroundImageWithURL:[NSURL URLWithString:_photoArray[2]] forState:UIControlStateNormal placeholderImage:nil];
                [self.registerButton sd_setBackgroundImageWithURL:[NSURL URLWithString:_photoArray[3]] forState:UIControlStateNormal placeholderImage:nil];
                
                
                self.tagLable.text = _titleArray[0];
                self.searchLable.text = _titleArray[1];
                self.seedingLable.text = _titleArray[2];
                self.registerLable.text = _titleArray[3];
                [_loadTitlArr removeAllObjects];
                [_loadTitlArr addObject:@"最新"];
                [_loadTitlArr addObjectsFromArray:_categoryTitlArr];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [_collectionTitle reloadData];
                });
            }

        }
    });
}

- (void)setTitleScolleIndexPath:(NSIndexPath *)titleScolleIndexPath{
    _titleScolleIndexPath = titleScolleIndexPath;
    self.titleName = _loadTitlArr[_titleScolleIndexPath.row];
    [self.collectionTitle scrollToItemAtIndexPath:_titleScolleIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self.collectionTitle reloadData];
}
@end
