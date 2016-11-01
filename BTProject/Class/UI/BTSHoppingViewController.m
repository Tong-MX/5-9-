//
//  BTSHoppingViewController.m
//  BTProject
//
//  Created by 明桐的Mac on 16/4/27.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTSHoppingViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "BTHomeModel.h"
#import "BTtopicModel.h"
#import "BTSHoppViewCell.h"
#import "AppDelegate.h"
#import "BTShoppingGet.h"
#import "BTSHopingHeaderView.h"
#import "BTTransferImageViewController.h"
#import "BTWebViewController.h"
#define DurationTime 0.7

@interface BTSHoppingViewController()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,BTScrolleViewSetYDelegate> {

    CGFloat alphaFloat;//导航栏的隐藏的透明度
    BOOL deleted;
    BOOL isFistRefresh; //刷新头视图数据
    CGFloat recodeData; //记录滑动的数据
    CGFloat scrolFloat;//滑动记录
    BOOL fistScrolled;
    CGFloat scrollData;//是否是当前滑动
    BOOL fistRefernceDataed;//第一次进入控制器时候
    CGFloat initScrollData;//初始时候collection的位置
}
@property (nonatomic, strong)AppDelegate *delegateApp;
@property (nonatomic, strong)UIImageView *snapShotView;
@property (nonatomic, strong)NSURL *modelUrl;
@property (nonatomic, strong)NSString *modelID;
@property (nonatomic, strong)BTShoppingGet *netWork;
@property (nonatomic, strong)UIButton *backBtn;
@property (nonatomic, strong)UIButton *colletBtn;
@property (nonatomic, strong)UIButton *shareBtn;
@property (nonatomic, strong)BTSHopingHeaderView *headerView;
@property (nonatomic, strong)UICollectionView *shopCollection;
@property (nonatomic, strong)BTSHoppViewCell *myCell;
@property (nonatomic, strong)NSIndexPath *recodeIndexpath;
@property (nonatomic, strong)NSMutableArray *modelUrlArr;
@property (nonatomic, strong)NSMutableArray *modelIDArr;
@property (nonatomic, strong)UIImageView *bactImage;
@property (nonatomic, strong)UIButton *communityBtn;
@end
@implementation BTSHoppingViewController

- (void)dealloc{
    self.snapShotView = nil;
    self.netWork = nil;
    self.shopCollection = nil;
    self.headerView = nil;
    self.shareBtn = nil;
    self.colletBtn = nil;
}

#pragma mark set方法传入数据

- (void)setHomePostIndexPath:(NSIndexPath *)homePostIndexPath {
    _homePostIndexPath = homePostIndexPath;
    fistRefernceDataed = YES;
}

- (void)setHomePostBackSoure:(NSMutableArray*)homePostBackSoure {
    self.modelUrlArr = [NSMutableArray array];
    self.modelIDArr = [NSMutableArray array];
    _homePostBackSoure = homePostBackSoure;
    if (homePostBackSoure != nil) {
        [homePostBackSoure enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[BTHomeModel class]]) {
                BTHomeModel *model = (BTHomeModel*)obj;
                [self.modelUrlArr addObject:[NSURL URLWithString:model.photo]];
                [self.modelIDArr addObject:model.id];
            }else if ([obj isKindOfClass:[BTtopicModel class]]) {
                BTtopicModel *model = (BTtopicModel*)obj;
                [self.modelUrlArr addObject:[NSURL URLWithString:model.pic]];
                [self.modelIDArr addObject:model.id];
            }
        }];
    }
    
    //创建头视图图片
    self.snapShotView = [[UIImageView alloc]init];
    _snapShotView.contentMode = UIViewContentModeScaleAspectFill;
    _snapShotView.clipsToBounds = YES;
    _snapShotView.userInteractionEnabled = YES;
    
}

// 传入相片

- (void)setTransFirImageArr:(NSMutableArray *)transFirImageArr {
    _transFirImageArr = transFirImageArr;
}

- (void)viewDidLoad {
    [self creatHomeUI];
    [super viewDidLoad];
    [self repostNetWorkWithModelID:_modelIDArr[_homePostIndexPath.row]];
    [self pushAnimation];
}

- (void)viewWillAppear:(BOOL)animated {
    self.view.alpha = 1;
}

- (void)initParameters {
    [super initParameters];
    self.netWork = [[BTShoppingGet alloc] init];
    deleted = NO;
    isFistRefresh = NO;
    fistScrolled = NO;
    scrollData = 0;
    recodeData = HKUIScreenWidth;
}

#pragma mark 将要消失的时候

- (void)viewWillDisappear:(BOOL)animated {

}

#pragma mark 创建的导航栏

- (void)setNavigationBarProperty {
    [self.view bringSubviewToFront: self.navigationBar];
    [self setNavigationBarBgColor: BTColor(252, 99, 100) Alpha:1];
    [self setNavigationBarTitleText:@"购物清单" Color:UIColorC3 Font:UISystemFontT6 Bold:BlodDefine];
    [self hiddenRightButton:NO];
    [self alphaNav:0.f];
    
    //创建返回按钮
    self.backBtn  = [BTCommonUtil createButtonFrame:CGRectMake(5, 20, 40, 40) Target:self BgColor:[UIColor clearColor] Title:nil TitleColor:nil BgImg:nil action:@selector(backAction:) Tag:0];
    self.backBtn.userInteractionEnabled = YES;
    _backBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.bactImage= [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 10, 20.5)];
    _bactImage.image = [UIImage imageNamed:@"top_back_icon"];
    //创建收藏按钮
    self.colletBtn = [BTCommonUtil createButtonFrame:CGRectMake(HKUIScreenWidth - 65 - 25, self.backBtn.top + 10, 25, 24) Target:self BgColor:nil Title:nil TitleColor:nil BgImg:[UIImage imageNamed:@"topic_collect_icon"] action:@selector(collectAction) Tag:0];
    [self.colletBtn setImage:[UIImage imageNamed:@"topic_collected_icon"] forState:UIControlStateSelected];
    self.shareBtn = [BTCommonUtil createButtonFrame:CGRectMake(self.colletBtn.left + self.colletBtn.width + 20, self.colletBtn.top, 25, 24) Target:self BgColor:nil Title:nil TitleColor:nil BgImg:[UIImage imageNamed:@"share_item_icon"] action:@selector(ShareAction) Tag:0];
    
    self.communityBtn = [BTCommonUtil createButtonFrame:CGRectMake(HKUIScreenWidth - 43 - 15, HKUIScreenHeight - 43 - 15, 43, 43) Target:self BgColor:nil Title:nil TitleColor:nil BgImg:[UIImage imageNamed:@"btn_topic_community"] action:@selector(communityAction) Tag:0];

    [self.view addSubview:_backBtn];
    [_backBtn addSubview:_bactImage];
    [self.view addSubview:_colletBtn];
    [self.view addSubview:_shareBtn];
    [self.view addSubview:_communityBtn];
}

#pragma mark 创建collectionView视图为主视图

- (void)creatHomeUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake(HKUIScreenWidth, HKUIScreenHeight);
    self.shopCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(BTZero, -20, HKUIScreenWidth,HKUIScreenHeight + 20) collectionViewLayout:layout];
    self.shopCollection.bounces = YES;
    self.shopCollection.scrollsToTop = NO;
    self.shopCollection.backgroundColor = [UIColor clearColor];
    self.shopCollection.delegate = self;
    self.shopCollection.showsVerticalScrollIndicator = YES;
    self.shopCollection.pagingEnabled = YES;
    [self.view addSubview:_shopCollection];
    
    [_shopCollection registerClass:[BTSHoppViewCell class] forCellWithReuseIdentifier:@"cellID"];
    _shopCollection.delegate = self;
    _shopCollection.dataSource = self;
}

#pragma mark collectionDelegate方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _homePostBackSoure.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

#pragma mark 创建cell的方法

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    self.myCell = (BTSHoppViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    self.myCell.delegateScrolle = self;
    self.recodeIndexpath = indexPath;
    if (!deleted) {
        self.myCell.alpha = 0;
        self.myCell.headerView.alpha = 0;
    }
    return _myCell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (fistRefernceDataed) {
        initScrollData = self.shopCollection.contentOffset.x;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark push动画方法

-(void)pushAnimation {
    CGRect rect = _cellRect;
    _snapShotView.frame = rect;
    _snapShotView.height = 200;
    _snapShotView.alpha = .1;
    self.delegateApp = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [_snapShotView sd_setImageWithURL:_modelUrlArr[_homePostIndexPath.row] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self.delegateApp.window addSubview:_snapShotView];
        [UIView animateWithDuration:DurationTime delay:0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
            _snapShotView.frame = CGRectMake(0, 0, HKUIScreenWidth, 200);
            _snapShotView.alpha = 1;
            self.view.backgroundColor = [UIColor whiteColor];
            
        } completion:^(BOOL finished) {
            [self showWaitProgressAsyn:@""];
            self.myCell.homeTableView.tableHeaderView.backgroundColor = [UIColor clearColor];
            [self setNavigationBarProperty];
            self.myCell.homeTableView.top = HKUIScreenHeight;
            [self performSelector:@selector(waitShaowProgress) withObject:@"wait" afterDelay:.5];

        }];

    }];
}

- (void)waitShaowProgress {
    self.myCell.snapShotView.hidden = YES;
    [self creatScrolViewTablViewUI];
    [self.shopCollection scrollToItemAtIndexPath:self.homePostIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    _recodeIndexpath = self.homePostIndexPath;
}
#pragma mark 返回点击事件

- (void)backAction:(UIButton*)btn {
    MTLog(@"返回成功");
    if (alphaFloat  != 1 && alphaFloat > 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [UIView animateWithDuration:.3 delay:0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
            [self.view addSubview:self.snapShotView];
            self.myCell.snapShotView.hidden = YES;
            self.headerView.top = _snapShotView.height - 20;
            self.myCell.homeTableView.top = -20;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.2 delay:0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
                _backBtn.alpha = .1;
                _shareBtn.alpha = .1;
                _colletBtn.alpha = .1;
                self.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.8];
                self.myCell.homeTableView.alpha = .8;
                self.myCell.homeTableView.top = HKUIScreenHeight;
                //延迟执行方法
                [self performSelector:@selector(delNotification:) withObject:@"name" afterDelay:.1f];
            } completion:^(BOOL finished) {
            }];
        }];
    }
    
}

#pragma mark 延迟方法

-(void)delNotification:(NSString*)name {
    [UIView animateWithDuration:.3 animations:^{
        CATransition *transition = [CATransition animation];
        transition.duration = .5f;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionReveal;
        transition.subtype = kCATransitionFromBottom;
        transition.delegate = self;
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        self.snapShotView.top = 0;
        [self popChildViewControllerFromCenter];
    }];
}

#pragma mark 创建滑动的ui

- (void)creatScrolViewTablViewUI {
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.myCell.homeTableView.top = -10;
        self.myCell.headerOtherView.top = 200 - 5;
    } completion:^(BOOL finished) {
        [self hiddenWaitProgressAsyn];
        self.myCell.homeTableView.top = BTZero;
        self.myCell.headerOtherView.top = 200;
        self.myCell.snapShotView.hidden = NO;
        [self.delegateApp.window removeFromSuperview];
        [self.snapShotView removeFromSuperview];
    }];
}



#pragma mark 相机点击方法

- (void)communityAction {
    BTTransferImageViewController *transFirImage = [[BTTransferImageViewController alloc] init];
    if (_transFirImageArr.count != 0) {
        transFirImage.dataSouce = _transFirImageArr;
        [self.navigationController presentViewController:transFirImage animated:YES completion:nil];
    }
}

#pragma mark 网络请求

- (void)repostNetWorkWithModelID:(NSString*)modelID {
    [self showWaitProgressAsyn:@""];
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    NSString *dev =  [BTResource doDevicePlatformWithIshiddenModel:NO];
    NSString *device_info = [NSString stringWithFormat:@"%@",dev];
    [_netWork getShoppingListWithOs_versions:systemVersion ScreenSize:HKUIScreenHeight TRACK_device_info:device_info SID:modelID netReachabilityType:^(BTNetReachabilityType reachabilityType) {
        if (reachabilityType == BTNetReachabilityTypeOK) {
            if (BTOne == _netWork.status) {
                _myCell.productMutalbe = _netWork.productMtable;
                _myCell.titleLabel.text = _netWork.titleStr;
                _myCell.desStr = _netWork.descStr;
                [_myCell.snapShotView sd_setImageWithURL:[NSURL URLWithString:_netWork.picUrl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    [UIView animateWithDuration:.3 animations:^{
                        self.myCell.snapShotView.alpha = 1;
                        self.myCell.headerView.alpha = 1;
                        self.myCell.alpha = 1;
                        self.myCell.alpha = 1;
                    }];
                }];

                if (isFistRefresh) {
                    [self.snapShotView sd_setImageWithURL:[NSURL URLWithString:_netWork.picUrl] placeholderImage:nil];
                }
                isFistRefresh = YES;
                deleted = YES;
                
                [self hiddenWaitProgressAsyn];
                [BTLog trace:@"SHopping页" Content:@"请求成功"];
            }
        }else {
            [BTLog trace:@"SHopping页" Content:@"请求失败"];
            [self showWaitProgressAsyn:@""];
            [self repostNetWorkWithModelID:_modelIDArr[self.recodeIndexpath.row]];
        }
    }];
}


#pragma mark 收藏点击事件

- (void)collectAction {
    _colletBtn.selected = !_colletBtn.selected;
    
}

#pragma  mark 分享点击事件

- (void)ShareAction {
    
}

#pragma mark pop返回方法

- (void)popChildViewControllerFromCenter
{
    //    [self dismissViewControllerAnimated:YES completion:^{
    //
    //    }];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
#warning 难点
    //不是第一个页面点击进来时候判断
    if (fistRefernceDataed) {
        fistRefernceDataed = NO;
        scrollData = initScrollData;
        fistScrolled = YES;
        if (initScrollData == scrollView.contentOffset.x) {
            scrollData = scrollView.contentOffset.x;
            return;
        }
    }
    //为上下滑动做判断
    if (scrollData == scrollView.contentOffset.x) {
        return;
    }
    scrolFloat = scrollView.contentOffset.x;
    recodeData = scrolFloat - (HKUIScreenWidth * (_recodeIndexpath.row - 1));
    if (scrolFloat == 0 && fistScrolled) {
        scrolFloat = HKUIScreenWidth;
        if (scrolFloat > recodeData - 10) {
            [self alphaNav:0];
            [self.myCell resumeNormolStata];
            self.myCell.homeTableView.contentOffset = CGPointMake(BTZero, BTZero);
            [self showWaitProgressAsyn:@""];
            [self performSelector:@selector(respotNotification) withObject:@"respot" afterDelay:.3f];
        }
        fistScrolled = NO;
    }else if (scrolFloat != 0){
        if (scrolFloat > recodeData - 10) {
            [self alphaNav:0];
            [self.myCell resumeNormolStata];
            self.myCell.homeTableView.contentOffset = CGPointMake(BTZero, BTZero);
            [self showWaitProgressAsyn:@""];
            [self performSelector:@selector(respotNotification) withObject:@"respot" afterDelay:.3f];
            
        }
        fistScrolled = YES;
    }
    scrollData = scrollView.contentOffset.x;
}
#pragma mark scrollView代理方法

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.contentOffset.x < -HKUIScreenWidth/5) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
   
    
}

- (void)respotNotification {
    [self repostNetWorkWithModelID:_modelIDArr[self.recodeIndexpath.row]];
    deleted = YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView  {
    deleted = NO;//判断是否清空滑动数据
}


#pragma mark 头视图滑动代理方法

- (void)transletSetYData:(CGFloat)scrollViewSetY headerViewHeight:(CGFloat)headerHeight{
    if (scrollViewSetY > 20) {
        alphaFloat = scrollViewSetY / (headerHeight - 115);
        [self alphaNav:alphaFloat];
    }else if (scrollViewSetY <= 20){
        alphaFloat = scrollViewSetY / (headerHeight - 115);
        [self alphaNav:alphaFloat];
    }
}

- (void)clickPhotoDelegate {
    [self communityAction];
}

- (void)payBuyActionWithShopingModel:(BTshoppingModel *)shopingModel {
    if (shopingModel) {
        BTshoppingModel *model = (BTshoppingModel*)shopingModel;
        MTLog(@"%@",model.id);
        
        BTWebViewController *controller = [[BTWebViewController alloc] init];
        controller.url = model.url;
        controller.titleStr = @"宝贝详情";
        [self pushContrllerWithType:@"suckEffect" Subtype:kCATransitionFromLeft Duration:1.5f];
        [self.navigationController pushViewController:controller animated:YES];
    }
}
@end
