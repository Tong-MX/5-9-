//
//  BaseRequestListVC.m
//  BTProject
//
//  Created by 明桐的Mac on 16/3/23.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BaseRequestListVC.h"
#import "AppDelegate.h"
#import "BTNetWorkReloadView.h"
#import "BTNetEngine.h"
#import "UIScrollView+PullToRefreshCoreText.h"
#define DefaultTextFont     [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:25]
#define UIShowWaitTIme 1
#define UIPageNumInit 1
@interface BaseRequestListVC()<BTNetWorkReloadViewDelegate>{
    BOOL waitRunning;
    int timeNumber;
}
@property (nonatomic, strong) BTNetWorkReloadView *reloadView;//网络出问题的时候显示的小地球
@property (strong) MBProgressHUD *progressHUD;
@property (strong) BTProgressHUD *asynProgressHUD;
@property (nonatomic, strong) UIScrollView *refrenSscrollView;
@end
@implementation BaseRequestListVC

- (void)dealloc {
//    _upLoadUI = nil;
//    _requestModel = nil;
    [_asynProgressHUD stopAnimation];
    _asynProgressHUD = nil;
    _reloadView = nil;
    
    [self hiddenWaitProgress];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initAsynProgressHUD];
    [self initReloadView];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    
    [self hiddenWaitProgressAsyn];
}

- (void)initReloadView {
    CGRect rect = CGRectMake(BTZero, HKTopBarHeight, HKControllerViewWidth, HKTopBarOutsidHeight);
    self.reloadView = [[BTNetWorkReloadView alloc] initWithFrame: rect];
    self.reloadView.delegate = self;
}

- (void)initMJRefresh: (UITableView*)tableView IsCreatFooterView:(BOOL)iscreatFooterView {
   
    // 上拉加载更多
        // 下拉刷新
        __weak typeof(tableView) weakTableView = tableView;
        __weak typeof(self) weakSelf = self;
        [tableView addPullToRefreshWithPullText:@"C'est La Vie" pullTextColor:[UIColor redColor] pullTextFont:DefaultTextFont refreshingText:@"Refreshing" refreshingTextColor:[UIColor redColor] refreshingTextFont:DefaultTextFont action:^{
            [weakSelf loadItemsWithTableView:weakTableView];
        }];
    //判断是否有下拉加载的
    if (iscreatFooterView) {
        self.footer = [[MJRefreshFooterView alloc] init];
        self.footer.delegate = self;
        self.footer.scrollView = tableView;
    }
}

- (void)loadItemsWithTableView:(UITableView*)tableView {
    __weak typeof(self) weakSelf = self;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, .5 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [tableView finishLoading];
        [weakSelf refreshFinish];
    });
}

#pragma mark 刷新下拉刷新的方法
- (void)refreshFinish {
    
}
- (void)noFooterLoad {
    [self performSelectorOnMainThread:@selector(hiddenFooterThread) withObject:nil waitUntilDone:NO];
}

- (void)netWorkHiddenFooter {
    [self performSelectorOnMainThread:@selector(netWorkhiddenFooterThread) withObject:nil waitUntilDone:NO];
}

- (void)netWorkhiddenFooterThread {
    [self.footer endRefreshing];
}

- (void)hiddenFooterThread {
    [self.footer endRefreshing];
    
    [self noUpLoad];
}

- (BOOL)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView {
    
    if (![BTCommonUtil netWork]) {
        [self showComplete: NSLocalizedString(@"noNetWorkMsg", nil) Time: UIShowWaitTIme];
        
        if (self.pageNum == UIPageNumInit) {
            [self showReloadView: nil];
        }
        
        [self netWorkHiddenFooter];
        
        return NO;
    }
    
    return YES;
}
- (void)showComplete: (NSString *)msg Time: (CGFloat)time {
    [[AppDelegate appDelegate] showComplete: msg Time: time];
}

- (void)showReloadView:(NSString *)text {
    
    [self.view addSubview: self.reloadView];
//    [self.view bringSubviewToFront: self.reloadView];
}

- (void)noUpLoad {
    [self showComplete: @"点击从新加载网络" Time: UIShowWaitTIme];
}

#define UIProgressHUD 10001
- (void)showWaitProgress:(NSString *)text {
    if (_progressHUD == nil) {
        _progressHUD = [[MBProgressHUD alloc] initWithView: self.view];
        _progressHUD.color = UIColorC20;
        [self.view addSubview:self.progressHUD];
        [self.progressHUD setTag: UIProgressHUD];
        [self.view bringSubviewToFront:self.progressHUD];
        self.progressHUD.labelText = text;
        [self.progressHUD show:YES];
        _progressHUD.userInteractionEnabled = YES;
        [self waitStartTime];
    }
}
- (void)initAsynProgressHUD {
    CGRect rect = CGRectMake(BTZero, HKTopBarHeight, HKControllerViewWidth, HKTopBarOutsidHeight);
    self.asynProgressHUD = [[BTProgressHUD alloc] initWithFrame: rect];
    
    [self hiddenWaitProgressAsyn];
    [self.view addSubview: _asynProgressHUD];
    
}
- (void)showWaitProgressAsyn:(NSString *)text {
    self.asynProgressHUD.hidden = NO;
    [self.asynProgressHUD startTime];
    
    [self.view addSubview: _asynProgressHUD];
    self.view.userInteractionEnabled = NO;
}

- (void)setBgViewColor: (UIColor*)color {
    [self.asynProgressHUD setBgViewColor: color];
}

- (void)hiddenWaitProgressAsyn {
    self.asynProgressHUD.hidden = YES;
    [self.asynProgressHUD stopAnimation];
//    [self.asynProgressHUD removeFromSuperview];
    self.view.userInteractionEnabled = YES;
}

- (void)hiddenWaitProgress {
    if (self.progressHUD){
        [self.progressHUD removeFromSuperview];
        _progressHUD = nil;
        
        [self waiTStopTime];
    }
}
- (void)waitStartTime
{
    waitRunning = YES;
   	[self performSelectorOnMainThread:@selector(waitRunTime) withObject:nil waitUntilDone: NO];
}

#define UIShowWaitTimeMax 75
- (void)waitRunTime {
    if (waitRunning == NO) {
        [self waiTStopTime];
    } else {
        timeNumber++;
        [NSTimer scheduledTimerWithTimeInterval: 1 target: self selector: @selector(waitRunTime) userInfo: nil repeats: NO];
        
        if (timeNumber >= UIShowWaitTimeMax) {
            [self waiTStopTime];
            [self hiddenWaitProgress];
        }
    }
}

- (void)waiTStopTime
{
    waitRunning = NO;
    timeNumber = BTZero;
}

#pragma show : 网路错误是否显示小地球
- (void)requestFailure: (int)error showReloadView: (BOOL)show {
    if (error == BTNetReachabilityTypeNotReachable) {
        [self showComplete: NSLocalizedString(@"noNetWorkMsg", nil) Time: UIShowWaitTIme];

        if(show) {
            [self showReloadView: nil];
        }
        
    } else if (error == BTNetReachabilityTypeTimeOut) {
        [self showComplete: NSLocalizedString(@"noNetWorkMsg", nil) Time: UIShowWaitTIme];
        
        if(show) {
            [self showReloadView: nil];
        }
        
    } else if (error == BTNetReachabilityTypeUrlWrong){
        [BTLog trace: @"网络" Content: @"网络返回错误"];
        [self showComplete: NSLocalizedString(@"noNetWorkMsg", nil) Time: UIShowWaitTIme];
        
        if(show) {
            [self showReloadView: nil];
        }
    }
}

- (CGFloat)labelHeightForString:(NSString*)string labelWidth:(float)width andFont:(UIFont*)font {
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: font}];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return rect.size.height;
}

- (void)setPhotos:(NSMutableArray *)photos {
    _photos = photos;
}

- (void)hiddenReloadView {
    [self.reloadView removeFromSuperview];
    self.reloadView.hidden = YES;
}

- (void)reloadUI {
    [self hiddenReloadView];
}

@end
