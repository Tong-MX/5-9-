
//  HomeViewController.m
//  BTProject
//
//  Created by 明桐的Mac on 16/3/19.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//
#define TagUI @"主页"
#import "BTHomeViewController.h"
#import "BTNetWorkHomeGet.h"
#import "BTHomeModel.h"
#import "BTHomeHeadView.h"
#import "BTHeadOtherView.h"
#import "BTDownMoreLoadFile.h"
#import "BTBannerbottomModel.h"
#import "BTtopicModel.h"
#import "BTHomeCollectionViewCell.h"
#import "BTNetWorkTopSecondGet.h"
#import "BTNetWorkTopOhterGet.h"
#import "BTNetWorkHomeUpDataGet.h"
#import "BTTransferImageViewController.h"
#import "BTSHoppingViewController.h"
#import "BTHomeHeaderViewController.h"
#import "BTWebViewController.h"
#import "BTJLView.h"

#define UIPageNumInit 1
#define UIPageSizeInit 10

@interface BTHomeViewController ()<UIScrollViewDelegate ,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,MJRefreshBaseViewDelegate,BTHomeHeadWithButtonClickDelegate,BTHomeDidSelectDataDelegate> {
    CGFloat alphaFloat;//导航栏的隐藏的透明度
    CGFloat scrollX;//记录全局数据为了使左右滑动时候页面保持正常状态
    CGFloat scrollY;//记录y的坐标
    BOOL isButtomRefresh;//是否下拉加载
    BOOL isRecordRefresh;//是否创建上拉刷新
    CGFloat angle;
}

@property (nonatomic ,strong)UICollectionView *homeCollection;
//@property (nonatomic ,strong)UIScrollView *collectionScrollView;
@property (nonatomic ,strong)BTNetWorkHomeGet *network;
@property (nonatomic ,strong)BTNetWorkTopSecondGet *netSecWork;
@property (nonatomic ,strong)BTNetWorkHomeUpDataGet *homeUpData;
@property (nonatomic ,strong)BTHomeHeadView *homeHeadView;
@property (nonatomic ,strong)BTJLView *jLView;
@property (nonatomic ,strong)NSMutableArray *banerMutable;
@property (nonatomic ,strong)NSMutableArray *banerExtendMtutabel;
@property (nonatomic ,strong)NSMutableArray *banerTitleMtutabel;
@property (nonatomic ,strong)NSMutableArray *banerTypeMtutabel;
@property (nonatomic ,strong)NSMutableArray *bannerBottomMutable;
@property (nonatomic ,strong)NSMutableArray *categoryMutable;//一周最热的横向数组
@property (nonatomic ,strong)NSMutableArray *topMutable;//主页的所有图片数组
@property (nonatomic ,strong)NSMutableArray *firstpageMutable;
@property (nonatomic ,strong)NSMutableArray *secondMutable;
@property (nonatomic ,strong)NSMutableArray *thirdMutalbe;
@property (nonatomic ,strong)NSMutableArray *twoDimension;
@property (nonatomic ,strong)BTHomeCollectionViewCell *myCell;
@property (nonatomic ,strong)BTNetWorkTopOhterGet *topOtherGet;
@property (nonatomic ,strong)NSMutableArray *topOtherOneArr;
@property (nonatomic ,strong)NSMutableArray *topOtherSecArr;
@property (nonatomic ,strong)NSMutableArray *topOtherThird;
@property (nonatomic ,strong)NSMutableArray *topOtherFourth;
@property (nonatomic ,strong)NSMutableArray *topOtherFiveth;
@property (nonatomic ,strong)NSMutableArray *topOtherSixth;
@property (nonatomic ,strong)NSMutableArray *topOtherSventh;
@property (nonatomic ,strong)NSMutableArray *topOtherEeighth;
@property (nonatomic ,strong)NSMutableArray *topOtherNieth;
@property (nonatomic ,strong)NSMutableArray *topOtherTenth;
@property (nonatomic ,strong)NSMutableArray *topOtherEleventh;
@property (nonatomic ,strong)NSMutableArray *topOtherTwelfth;
@property (nonatomic ,strong)NSMutableArray *topOtherThirteenth;
@property (nonatomic ,strong)NSIndexPath    *buttonIndexPath;//点击标题按钮index

@property (nonatomic, assign)CGFloat        recommedOffset;
@end

@implementation BTHomeViewController

- (void)dealloc{
    [self.myCell removeObserver:self forKeyPath:@"scolleViewSetY"];
}

- (void)viewDidLoad {
    [self creatHomeUI];//创建滑动视图为主视图
    [super viewDidLoad];
    [self respotNetWork];//请求第一个视图的网络请求
    self.view.backgroundColor = [UIColor clearColor];
    [self homeHearView];//创建头视图
    [self setNavigationBarProperty];//修改导航栏
    [self creatJLUIWithXFloat:(HKUIScreenWidth - 24)/2 YFloat:(HKUIScreenHeight - 49 - 35)/2];
}


- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
    self.view.alpha = 1;
    if (![BTPreferences saveJL]) {
        _jLView.frontView.width = 80;
        _jLView.frontView.height = 80;
        _jLView.frontView.layer.cornerRadius = 80/2;
        self.jLView.unReadLabel.font = [UIFont systemFontOfSize:14.0];
        self.jLView.unReadLabel.frame = CGRectMake(self.jLView.width/2, self.jLView.height/2, self.jLView.width, self.jLView.height);
        [self performSelector:@selector(delNotification:) withObject:@"name" afterDelay:2.f];
    }else {
        [self jLAnmationMove];
    }
}

-(void)delNotification:(NSString*)name {
    if (self.jLView != nil) {
        if (![BTPreferences saveJL]) {
            [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                [self jLAnmationMove];
                _jLView.alpha = 0;
            } completion:^(BOOL finished) {
                [BTPreferences setJLSaveWithIsSave:YES];
                [self creatJLUIWithXFloat:35 YFloat:(HKUIScreenHeight - 49 - 35)];
                _jLView.frontView.layer.cornerRadius = 40/2;
                _jLView.alpha = 1;
            }];
        }else {
            [self jLAnmationMove];
        }
    }
}

- (void)jLAnmationMove {
    self.jLView.left = 25;
    self.jLView.top = HKUIScreenHeight - 49 - 55;
    _jLView.unReadLabel.alpha = 1;
    _jLView.frontView.width = 40;
    _jLView.frontView.height = 40;
    _jLView.frontView.backgroundColor = BTColor(252, 99, 100);
    [self.jLView addBubbleAnimation];
}
#pragma mark 初始化方法

- (void)initParameters{
    [super initParameters];
    isRecordRefresh  = NO;
    //主控制器
    self.controllerId = BTHomeVC;
    
    self.banerMutable = [NSMutableArray array];
    self.bannerBottomMutable = [NSMutableArray array];
    self.categoryMutable = [NSMutableArray array];
    self.topMutable = [NSMutableArray array];
    self.firstpageMutable = [NSMutableArray array];
    self.secondMutable = [NSMutableArray array];
    self.banerExtendMtutabel = [NSMutableArray array];
    self.banerTitleMtutabel = [NSMutableArray array];
    self.banerTypeMtutabel = [NSMutableArray array];
    
    self.twoDimension = [NSMutableArray array];//二维数组
    self.network = [[BTNetWorkHomeGet alloc] init];
    self.netSecWork = [[BTNetWorkTopSecondGet alloc] init];
    self.topOtherGet = [[BTNetWorkTopOhterGet alloc] init];
    self.homeUpData = [[BTNetWorkHomeUpDataGet alloc] init];
    
    //创建的top数组为了提前装到二维数组里做初始化
    self.secondMutable = [NSMutableArray array];
    self.thirdMutalbe = [NSMutableArray array];
    self.topOtherOneArr = [NSMutableArray array];
    self.topOtherSecArr = [NSMutableArray array];
    self.topOtherThird = [NSMutableArray array];
    self.topOtherFourth = [NSMutableArray array];
    self.topOtherFiveth = [NSMutableArray array];
    self.topOtherSixth = [NSMutableArray array];
    self.topOtherSventh = [NSMutableArray array];
    self.topOtherEeighth = [NSMutableArray array];
    self.topOtherNieth = [NSMutableArray array];
    self.topOtherTenth = [NSMutableArray array];
    self.topOtherEleventh = [NSMutableArray array];
    self.topOtherTwelfth = [NSMutableArray array];
    self.topOtherThirteenth = [NSMutableArray array];
}

- (void)initSize{
    
    
}

- (void)creatJLUIWithXFloat:(CGFloat)xfloat YFloat:(CGFloat)yfloat {
    angle = 1;//选择角度
    self.jLView = [[BTJLView alloc] initWithCenterPoint:CGPointMake(xfloat, yfloat) bubleRadius:20 addToSuperView:self.view];
    self.jLView.userInteractionEnabled = YES;
    self.jLView.decayCoefficent = .2;
    self.jLView.values = @[@1.0,@1.5,@1.0];
    self.jLView.unReadLabel.text = @"我的简历";
    self.jLView.unReadLabel.font = [UIFont systemFontOfSize:12.0];
    self.jLView.unReadLabel.numberOfLines = 2;
    self.jLView.bubbleColor = BTColor(252, 99, 100);
    if ([BTPreferences saveJL]) {
//        [self startAnimationWithTimeInterval:.5];
    }
    __weak BTHomeViewController *weekSelf = self;
    __weak BTJLView *weekJLview = self.jLView;
    self.jLView.cleanMessageBlock = ^(){
        NSString *url = [[NSBundle mainBundle] pathForResource:@"iOS开发李明桐简历" ofType:@".doc"];
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionOverrideInheritedDuration animations:^{
            weekJLview.left = HKUIScreenWidth/2 - 15;
            weekJLview.top = (HKUIScreenHeight - 49)/2;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:1 animations:^{
                weekJLview.unReadLabel.alpha = 0;
                weekJLview.left = BTZero;
                weekJLview.top = BTZero;
                weekJLview.frontView.width = HKUIScreenWidth;
                weekJLview.frontView.height = HKUIScreenHeight;
                weekJLview.frontView.backgroundColor = [UIColor whiteColor];
//                weekJLview.frontView.backgroundColor = [UIColor colorWithRed:arc4random() % 10 * 0.1 green:arc4random() % 10 * 0.1 blue:arc4random() % 10 * 0.1 alpha:1];
            } completion:^(BOOL finished) {
                BTWebViewController *webview = [[BTWebViewController alloc] init];
                webview.titleStr = @"感谢预览";
                webview.url = url;
                webview.type = 1;
                [weekSelf.navigationController pushViewController:webview animated:NO];
            }];
        }];
    };
}

- (void)startAnimationWithTimeInterval:(NSTimeInterval)timeInterval
{
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
    [UIView animateWithDuration:.4 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.jLView.unReadLabel.transform = endAngle;
    } completion:^(BOOL finished) {
        angle += 10; [self startAnimationWithTimeInterval:.4];
    }];
    
}

#pragma mark 创建的导航栏

- (void)setNavigationBarProperty {
    [self.view bringSubviewToFront: self.navigationBar];
    [self setNavigationBarBgColor: BTColor(252, 99, 100) Alpha:1];
    
    [self setNavigationBarTitleText:@"半塘" Color:UIColorC3 Font:UISystemFontT6 Bold:BlodDefine];
    [self setNavigationBarLeftButtonBgImg:[UIImage imageNamed:@"b_1_q065"] TouchImg:nil Text:@""];
    [self setNavigationBarRightButtonBgImg:[UIImage imageNamed:@"sing_bar_icon"] TouchImg:nil Text:nil];
    [self hiddenRightButton:NO];
    [self alphaNav:0.f];
}

#pragma mark 创建头视图

- (void)homeHearView{
    
    self.homeHeadView = [[BTHomeHeadView alloc] initWithFrame:CGRectMake(BTZero, BTZero, HKUIScreenWidth, [BTCommonUtil setHeightPX:676])];
    self.homeHeadView.delegate = self;
    self.homeHeadView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_homeHeadView];
}

#pragma mark 创建collectionView视图为主视图

- (void)creatHomeUI{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.homeCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(BTZero, BTZero, HKUIScreenWidth,HKUIScreenHeight) collectionViewLayout:layout];
    self.homeCollection.bounces = NO;
    self.homeCollection.scrollsToTop = NO;
    self.homeCollection.backgroundColor = [UIColor clearColor];
    self.homeCollection.delegate = self;
    self.homeCollection.showsVerticalScrollIndicator = YES;
    self.homeCollection.pagingEnabled = YES;
    self.homeCollection.contentSize = CGSizeMake(HKUIScreenWidth*4, HKUIScreenHeight);
    [self.view addSubview:_homeCollection];
    
    [_homeCollection registerClass:[BTHomeCollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    _homeCollection.delegate = self;
    _homeCollection.dataSource = self;
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section

{   //cell竖行个数因为是横向滑动的
    return _twoDimension.count;
}

//定义展示的Section的个数竖行多少个
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
//    return categoryElementCount;
    return 1;
}

#pragma mark collectionViewCell

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
     _myCell = (BTHomeCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    [self initMJRefresh: _myCell.homeTableView IsCreatFooterView:YES];//初始化刷新加载
    _myCell.delegate = self;
    return _myCell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    BTHomeCollectionViewCell *myCell = (BTHomeCollectionViewCell *)cell;
    _buttonIndexPath = indexPath;
    if (_buttonIndexPath.row != 0 || _buttonIndexPath.row != 1 || _buttonIndexPath.row != 2) {
        [self loadTableViewTopDataWithIndeaxPax:indexPath];
    }
    myCell.dataSource = _twoDimension[indexPath.row];
    //监听头视图的滑动
    [_myCell addObserver:self forKeyPath:@"scolleViewSetY" options:NSKeyValueObservingOptionNew context:nil];
    //如果是下拉刷新就不刷新了直接返回这样tableView不会重新布局UI界面问题
    if (isRecordRefresh) {
        isRecordRefresh = NO;
        //scrollY必须默认为0否则在滑动下一个tableView就是为记录的会有所偏差
        scrollY = BTZero;
        return;
    }
    //判断是否是下拉加载更多是加载更多的话头视图就不滑动最上方
    if (!isButtomRefresh) {
        //左右滑动时候使tableView的视图保持回到停留位置
        myCell.homeTableView.contentOffset = CGPointMake(0, scrollY);
        //目前只针对iPhone6来适配 || scrollX == 0
        if (scrollY >= 240) {
            myCell.homeTableView.contentOffset = CGPointMake(0, 240);
        }
    }else {
        [self.footer endRefreshing];
        isButtomRefresh = NO;
        return;
    }
}

#pragma mark 做提前的网络加载和点击的时候的网络加载

- (void)loadTableViewTopDataWithIndeaxPax: (NSIndexPath*)indexPath{
    //滑动到第一cell加载的是第4个数据 或者点击第四个数据直接做请求
    if ((indexPath.row == 1 || _buttonIndexPath.row == 3) && _topOtherOneArr.count == 0) {
        //3 10 13 15 17 1 6 5 14 4
        [self respotNetWorkOtherWithScene:16 IndexPax:indexPath MutableArry:_topOtherOneArr];
    }else if ((indexPath.row == 2 || _buttonIndexPath.row == 4 )&& _topOtherSecArr.count == 0){
        [self respotNetWorkOtherWithScene:8 IndexPax:indexPath MutableArry:_topOtherSecArr];
    }else if ((indexPath.row == 3 || _buttonIndexPath.row == 5) && _topOtherThird.count == 0){
        [self respotNetWorkOtherWithScene:3 IndexPax:indexPath MutableArry:_topOtherThird];
    }else if ((indexPath.row == 4 || _buttonIndexPath.row == 6) && _topOtherFourth.count == 0){
        [self respotNetWorkOtherWithScene:10 IndexPax:indexPath MutableArry:_topOtherFourth];
    }else if ((indexPath.row == 5 || _buttonIndexPath.row == 7) && _topOtherFiveth.count == 0){
        [self respotNetWorkOtherWithScene:13 IndexPax:indexPath MutableArry:_topOtherFiveth];
    }else if ((indexPath.row == 6 || _buttonIndexPath.row == 8) && _topOtherSixth.count == 0){
        [self respotNetWorkOtherWithScene:15 IndexPax:indexPath MutableArry:_topOtherSixth];
    }else if ((indexPath.row == 7 || _buttonIndexPath.row == 9) && _topOtherSventh.count == 0){
        [self respotNetWorkOtherWithScene:17 IndexPax:indexPath MutableArry:_topOtherSventh];
    }else if ((indexPath.row == 8 || _buttonIndexPath.row == 10) && _topOtherEeighth.count == 0){
        [self respotNetWorkOtherWithScene:1 IndexPax:indexPath MutableArry:_topOtherEeighth];
    }else if ((indexPath.row == 9 || _buttonIndexPath.row == 11) && _topOtherNieth.count == 0){
        [self respotNetWorkOtherWithScene:6 IndexPax:indexPath MutableArry:_topOtherNieth];
    }else if ((indexPath.row == 10 || _buttonIndexPath.row == 12) && _topOtherTenth.count == 0){
        [self respotNetWorkOtherWithScene:5 IndexPax:indexPath MutableArry:_topOtherTenth];
    }else if ((indexPath.row == 11 || _buttonIndexPath.row == 13) && _topOtherEleventh.count == 0){
        [self respotNetWorkOtherWithScene:14 IndexPax:indexPath MutableArry:_topOtherEleventh];
    }else if ((indexPath.row == 12 || _buttonIndexPath.row == 14) && _topOtherTwelfth.count == 0){
        [self respotNetWorkOtherWithScene:9 IndexPax:indexPath MutableArry:_topOtherTwelfth];
    }else if ((indexPath.row == 13 || _buttonIndexPath.row == 15) && _topOtherThirteenth.count == 0){
        [self respotNetWorkOtherWithScene:4 IndexPax:indexPath MutableArry:_topOtherThirteenth];
    }
}
//item的距离
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(BTZero, BTZero,BTZero,BTZero);
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(HKUIScreenWidth, HKUIScreenHeight);
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return BTZero;
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return BTZero;
}

#pragma mark 点击左侧按钮

- (void)backAction {
    [BTLog trace: BTHomeDetails Content:@"点击左侧按钮"];
    [[SDImageCache sharedImageCache]cleanDisk];
    [[SDImageCache sharedImageCache]clearDisk];
}

#pragma mark 滑动视图的代理方法实时调用

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    scrollX = scrollView.contentOffset.x;
}

#pragma mark 滑动结束的scroll的代理方法

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _homeHeadView.titleScolleIndexPath = _buttonIndexPath;
}

#pragma mark tableView的代理取出点击效果

- (void)btHomeTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath HomePostBackSoure:(id)homePostBackSoure CellRect:(CGRect)cellRect{
    self.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.1];
    self.homeCollection.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.1];
    
    BTSHoppingViewController *controller = [[BTSHoppingViewController alloc] init];
    controller.homePostIndexPath = indexPath;
    controller.homePostBackSoure = homePostBackSoure;
    controller.cellRect = cellRect;
    controller.transFirImageArr = _transFirImageArr;
    controller.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.5];
    [self pushContrllerWithType:@"rippleEffect" Subtype:kCATransitionFromLeft Duration:3.f];
    [self.navigationController pushViewController:controller animated:NO];
    
}

#pragma mark 点击滑动头视图的代理方法

- (void)homeHeadWithExtendData:(NSString *)extendData TitleStr:(NSString *)titleStr clickTag:(NSInteger)clickTag {
    if ([_banerTypeMtutabel[clickTag - 1] isEqualToString:@"webview"]) {
        BTWebViewController *controller = [[BTWebViewController alloc] init];
        controller.url = extendData;
        controller.titleStr = titleStr;
        [self pushContrllerWithType:@"suckEffect" Subtype:kCATransitionFromLeft Duration:1.5f];
        [self.navigationController pushViewController:controller animated:YES];
    }else {
        BTHomeHeaderViewController *controller = [[BTHomeHeaderViewController alloc] init];
        controller.extendData = extendData;
        controller.titleStr = titleStr;
        controller.transFirImageArr = self.transFirImageArr;
        [self pushContrllerWithType:@"suckEffect" Subtype:kCATransitionFromLeft Duration:1.5f];
        [self.navigationController pushViewController:controller animated:YES];
    }
   
}

#pragma mark 上拉刷新

- (void)refreshFinish {
    [super refreshFinish];
    isRecordRefresh = YES;
    if (_buttonIndexPath.row == 0) {
        [self respotNetWork];
    }else if (_buttonIndexPath.row == 1) {
        [self respotNetWorkSecondTopWihtIDS:IDSTop2];
    }else if (_buttonIndexPath.row == 2) {
        [self respotNetWorkSecondTopWihtIDS:IDSTop3];
    }
    //刷新以后tableView恢复第一单元格
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:BTZero inSection:BTZero];
    [_homeCollection scrollToItemAtIndexPath: indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    _homeHeadView.titleScolleIndexPath = indexPath;
//    _myCell.isRecordRefresh = YES;//是刷新的话停止调用kvo方法系统性能和出现重复调用的bug
    [UIView animateWithDuration:.2 animations:^{
        if (isRecordRefresh) {
            self.homeHeadView.frame = CGRectMake(BTZero, BTZero, HKUIScreenWidth, [BTCommonUtil setHeightPX:676]);
        }
    }];
    
}

#pragma mark 下拉加载

- (BOOL)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([super refreshViewBeginRefreshing: refreshView]) {
        if (self.footer == refreshView) {
            if ([_twoDimension[_buttonIndexPath.row] count] <= _topMutable.count) {
                self.pageNum++;
                if (_buttonIndexPath.row == 0) {
                    [self respotNetWorkWithPage:self.pageNum UpdateTime:1461142801];
                    isButtomRefresh = YES;
                }
            }else if ([_twoDimension[_buttonIndexPath.row] count] <= _secondMutable.count) {
                if (_buttonIndexPath.row == 1){
                    [self respotNetWorkSecondTopWihtIDS:IDSTopLoad];
                }
            }else if ([_twoDimension[_buttonIndexPath.row] count] <= _thirdMutalbe.count) {
                if (_buttonIndexPath.row == 2){
                    [self respotNetWorkSecondTopWihtIDS:IDSTopThirdLoad];
                }
            }
        }
        
    }
    return YES;
}

#pragma mark kvo方法监听头视图

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
        if ([keyPath isEqualToString:@"scolleViewSetY"]){
            NSNumber *turnNum = [change objectForKey:@"new"];
            float turnValue =  [turnNum floatValue];
            if (turnValue > 20) {
                alphaFloat = turnValue / ((self.homeHeadView.height - 100));
                scrollY = turnValue;
                [self alphaNav:alphaFloat];
                if (alphaFloat >= 1) {
                    if ([BTCommonUtil deviceID] == RES_dev_iphone_6p) {
                        turnValue = 272;
                    }else if ([BTCommonUtil deviceID] == RES_dev_iphone_6) {
                        turnValue = 240;
                    }else if ([BTCommonUtil deviceID] == RES_dev_iphone_5) {
                        turnValue = 187.5;
                    }
                }
            }else if (turnValue <= 20){
                scrollY = turnValue;
                alphaFloat = turnValue / ((self.homeHeadView.height - 100));
                [self alphaNav:alphaFloat];
            }
            self.homeHeadView.frame = CGRectMake(BTZero, -turnValue, HKUIScreenWidth, [BTCommonUtil setHeightPX:676]);
        }
}

#pragma mark homeHeadView的代理方法点击使collection滑动的
- (void)homeHeadWithButtonTag:(NSIndexPath*)tagIndexPath {
    _buttonIndexPath = tagIndexPath;
    [_homeCollection scrollToItemAtIndexPath: tagIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    _myCell.dataSource = _twoDimension[_buttonIndexPath.row];
    [_homeCollection reloadData];
}

#pragma mark 创建所有的二维数组为点击标题做准备
- (void)creatAllTopTwoDimension {
    [_twoDimension addObject:_topMutable];
    [_twoDimension addObject:_secondMutable];
    [_twoDimension addObject:_thirdMutalbe];
    [_twoDimension addObject:_topOtherOneArr];
    [_twoDimension addObject:_topOtherSecArr];
    [_twoDimension addObject:_topOtherThird];
    [_twoDimension addObject:_topOtherFourth];
    [_twoDimension addObject:_topOtherFiveth];
    [_twoDimension addObject:_topOtherSixth];
    [_twoDimension addObject:_topOtherSventh];
    [_twoDimension addObject:_topOtherEeighth];
    [_twoDimension addObject:_topOtherNieth];
    [_twoDimension addObject:_topOtherTenth];
    [_twoDimension addObject:_topOtherEleventh];
    [_twoDimension addObject:_topOtherTwelfth];
    [_twoDimension addObject:_topOtherThirteenth];
}

//----------------------网络请求的所有数据------------------------

//- (void)reloadUI {
//    [self respotNetWork];
//}

#pragma mark 网络请求

- (void)respotNetWork{
    [self showWaitProgressAsyn:nil];
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    NSString *dev =  [BTResource doDevicePlatformWithIshiddenModel:NO];
    NSString *device_info = [NSString stringWithFormat:@"%@",dev];
    if (_twoDimension.count == 0) {
        [_twoDimension removeAllObjects];
        [self creatAllTopTwoDimension];
    }
    [_network getHomelistWithOs_versions:systemVersion
                              ScreenSize:HKUIScreenHeight
                       TRACK_device_info:device_info
                     netReachabilityType:^(BTNetReachabilityType reachabilityType) {
        
        if (reachabilityType == BTNetReachabilityTypeOK) {
            if (BTOne == _network.status) {
                if (_network.bannerArray.count > 0) {
                    
                    dispatch_queue_t queue1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                    // 2.在并行队列里面添加异步任务
                    dispatch_async(queue1, ^{
                        // 多线程的入口
                        @autoreleasepool {
                            NSLog(@"异步线程程里面刷新数据操作");
                            //主页第一个表视图的图片
                            [_topMutable removeAllObjects];
                            for(BTHomeModel *firstModel in _network.firstpageArray){
                                [_topMutable addObject:firstModel];
                            }
                            //top的图片
                            for (BTtopicModel *topModel in _network.topicArray) {
                                //耗费时间较长
                                [_topMutable addObject:topModel];
                            }
                             [self requestOtherTop];//异步请求第二和第三个网络图片影响主线程
                            [_banerMutable removeAllObjects];
                            [_bannerBottomMutable removeAllObjects];
                            [_categoryMutable removeAllObjects];
                            for (BTHomeModel *homeModel in _network.bannerArray) {
                                [_banerMutable addObject:homeModel.photo];
                                [_banerExtendMtutabel addObject:homeModel.extend];
                                [_banerTitleMtutabel addObject:homeModel.title];
                                [_banerTypeMtutabel addObject:homeModel.type];
                            }
                            //头滑动式图的图片
                            NSDictionary *banerAndExtendDic = [NSDictionary dictionaryWithObjectsAndKeys:_banerMutable,@"banerMutable",_banerExtendMtutabel,@"banerExtendMtutabel",_banerTitleMtutabel,@"banerTitleMtutabel",nil];
                            [_bannerBottomMutable addObjectsFromArray:_network.banner_bottom_elementArray];
                            //一周最热的滑动视图
                            [_categoryMutable addObjectsFromArray: _network.category_elementArray];
                            NSDictionary *bannerCategoryDic = [NSDictionary dictionaryWithObjectsAndKeys:_bannerBottomMutable,@"bannerBottom",_categoryMutable,@"category",nil];
                            if (self.homeHeadView) {
                                self.homeHeadView.headScrolleDic = banerAndExtendDic;
                                self.homeHeadView.bannerCategoryDic = bannerCategoryDic;
                            }else {
                                [self showWaitProgressAsyn:@""];
                                [self respotNetWork];
                                return;
                            }
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                // 执行主线程里面刷新UI的操作
                                NSLog(@"主线程里面刷新UI的操作");
                                if (!isRecordRefresh) {
                                    [[BTDownMoreLoadFile shareDownMoreLoadFile] downMoreLoadFile:_banerMutable success:^(id obj) {
                                        [BTLog trace: TagUI Content:@"请求的下载数据成功"];
                                        [BTPreferences setHomeHeadScrolleView:obj];
                                    } failed:^{
                                        [BTLog trace: TagUI Content:@"请求的下载数据失败"];
                                    }];
                                }
                                
                                [_homeCollection reloadData];
                                [self.footer endRefreshing];
                                [self hiddenWaitProgressAsyn];
                           
                            });
                        }
                        
                    });
                    
                }
            }
        }else{
            [self hiddenWaitProgressAsyn];
            [self requestFailure: reachabilityType showReloadView: YES];
            [BTLog trace: TagUI Content: [NSString stringWithFormat: @"网络请求失败错误码 ＝ %d从新请求", reachabilityType]];
        }
    }];
}

#pragma mark 异步请求第二和第三个网络图片影响主线程

- (void)requestOtherTop{
    [self respotNetWorkSecondTopWihtIDS:IDSTop2];
    [self respotNetWorkSecondTopWihtIDS:IDSTop3];
}

#pragma mark 第二个top网络请求需要ids

- (void)respotNetWorkSecondTopWihtIDS:(NSString*)ids {
//    [self showWaitProgressAsyn:nil];
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    NSString *dev =  [BTResource doDevicePlatformWithIshiddenModel:NO];
    NSString *device_info = [NSString stringWithFormat:@"%@",dev];
    if ([ids isEqualToString:IDSTop2]) {
        [_netSecWork getHomelistWithOs_versions:systemVersion
                                     ScreenSize:HKUIScreenHeight
                                    TRACK_device_info:device_info
                                    IDS:ids
                                    PAGE:0
                                    UpDateTime:0
                                    netReachabilityType:^(BTNetReachabilityType reachabilityType) {
                                        
            if (reachabilityType == BTNetReachabilityTypeOK) {
                if (BTOne == _netSecWork.status){
                    for (BTtopicModel *topModel in _netSecWork.TopMutable) {
                        [self.secondMutable addObject:topModel];
                    }
                    [self.footer endRefreshing];
                }
            }else{
                [BTLog trace:BTHomeDetails Content:@"reachabilityType"];
            }
        }];
    }else if ([ids isEqualToString:IDSTop3]){
        [_netSecWork getHomelistWithOs_versions:systemVersion
                                     ScreenSize:HKUIScreenHeight
                                     TRACK_device_info:device_info
                                     IDS:ids
                                     PAGE:0
                                     UpDateTime:0
                                     netReachabilityType:^(BTNetReachabilityType reachabilityType) {
                                         
            if (reachabilityType == BTNetReachabilityTypeOK) {
                if (BTOne == _netSecWork.status){
                    for (BTtopicModel *topModel in _netSecWork.TopMutable) {
                        [self.thirdMutalbe addObject:topModel];
                    }
                }
                [_homeCollection reloadData];
            }else{
                [BTLog trace:BTHomeDetails Content:@"reachabilityType"];
            }
        }];
    } else if ([ids isEqualToString:IDSTopLoad]) {
        [_netSecWork getHomelistWithOs_versions:systemVersion
                                     ScreenSize:HKUIScreenHeight
                                     TRACK_device_info:device_info
                                     IDS:ids
                                     PAGE:0
                                     UpDateTime:0
                                     netReachabilityType:^(BTNetReachabilityType reachabilityType) {
                                         
            if (reachabilityType == BTNetReachabilityTypeOK) {
                if (BTOne == _netSecWork.status){
                    for (BTtopicModel *topModel in _netSecWork.TopMutable) {
                        [self.topOtherSecArr addObject:topModel];
                    }
                }
                [_secondMutable addObject:_topOtherSecArr];
                [_homeCollection reloadData];
            }else{
                [BTLog trace:BTHomeDetails Content:@"reachabilityType"];
            }
        }];
    }else if ([ids isEqualToString:IDSTopThirdLoad]) {
        [_netSecWork getHomelistWithOs_versions:systemVersion
                                     ScreenSize:HKUIScreenHeight
                              TRACK_device_info:device_info
                                            IDS:ids
                                           PAGE:1
                                     UpDateTime:0
                            netReachabilityType:^(BTNetReachabilityType reachabilityType) {
                                
                                if (reachabilityType == BTNetReachabilityTypeOK) {
                                    if (BTOne == _netSecWork.status){
                                        for (BTtopicModel *topModel in _netSecWork.TopMutable) {
                                            [self.topOtherSecArr addObject:topModel];
                                        }
                                    }
                                    [self.topOtherSecArr removeAllObjects];
                                    [_thirdMutalbe addObject:_topOtherSecArr];
                                    [_homeCollection reloadData];
                                }else{
                                    [BTLog trace:BTHomeDetails Content:@"reachabilityType"];
                                }
                            }];
    }
    isButtomRefresh = YES;
}
#pragma mark 其他的Top的网络请求传入的scene
- (void)respotNetWorkOtherWithScene :(NSInteger)scene IndexPax:(NSIndexPath*)indexPax MutableArry:(NSMutableArray*)mutableArry{
    [self dispasMethdWithScene:scene MutalbeArry:mutableArry];
}

#pragma mark 异步网络请求
- (void)dispasMethdWithScene:(NSInteger)scene MutalbeArry:(NSMutableArray*)mutableArry{
    [self showWaitProgressAsyn:@""];
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    NSString *dev =  [BTResource doDevicePlatformWithIshiddenModel:NO];
    NSString *device_info = [NSString stringWithFormat:@"%@",dev];
    NSMutableArray *tempArr = [NSMutableArray array];
    [_topOtherGet getTopHomelistWithOs_versions:systemVersion ScreenSize:HKUIScreenHeight TRACK_device_info:device_info Scene:scene netReachabilityType:^(BTNetReachabilityType reachabilityType) {
        if (reachabilityType == BTNetReachabilityTypeOK) {
            [tempArr removeAllObjects];
            if (BTOne == _topOtherGet.status){
                for (BTtopicModel *topModel in _topOtherGet.TopMutable) {
                    [tempArr addObject:topModel];
                }
            }
            [mutableArry addObjectsFromArray:tempArr];
            [_homeCollection reloadData];
            [self.footer endRefreshing];
            [self hiddenWaitProgressAsyn];
            
        }else{
            [BTLog trace:BTHomeDetails Content:@"reachabilityType"];
        }
    }];
    
}

#pragma mark 下拉加载的网络请求topone页面
- (void)respotNetWorkWithPage:(NSInteger)page UpdateTime:(CGFloat)updataTime{
    page++;
    if (page == 3) {
        [self.footer endRefreshing];
        return;
    }
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    NSString *dev =  [BTResource doDevicePlatformWithIshiddenModel:NO];
    NSString *device_info = [NSString stringWithFormat:@"%@",dev];
    NSMutableArray *upDataArr = [NSMutableArray array];
    [_homeUpData getHomelistWithOs_versions:systemVersion ScreenSize:HKUIScreenHeight TRACK_device_info:device_info Page:page UPData:updataTime netReachabilityType:^(BTNetReachabilityType reachabilityType) {
        
        if (reachabilityType == BTNetReachabilityTypeOK) {
            if (BTOne == _homeUpData.status){
                for (BTtopicModel *topModel in _homeUpData.TopMutable) {
                    [upDataArr addObject:topModel];
                }
            }
            [_topMutable addObjectsFromArray:upDataArr];
//            [_homeCollection reloadData];
            [_myCell.homeTableView reloadData];
            [self.footer endRefreshing];
            
        }else{
            [BTLog trace:BTHomeDetails Content:@"reachabilityType"];
        }
        isButtomRefresh = YES;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
