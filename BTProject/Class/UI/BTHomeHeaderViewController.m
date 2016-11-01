//
//  BTHomeHeaderViewController.m
//  BTProject
//
//  Created by 明桐的Mac on 16/5/5.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTHomeHeaderViewController.h"
#import "BTHomeHeadCell.h"
#import "BTNetWorkTopSecondGet.h"
#import "BTtopicModel.h"
#import "BTSHoppingViewController.h"

static NSString *identerfy = @"cellID";

@interface BTHomeHeaderViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong)UITableView *homeHeadTableView;
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic ,strong)BTNetWorkTopSecondGet *netSecWork;
@end

@implementation BTHomeHeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarProperty];
    [self creatTalbleView];
    [self respotNetWorkSecondTopWihtIDS:_extendData];
}

- (void)viewWillAppear:(BOOL)animated {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initParameters {
    [super initParameters];
    self.dataSource = [NSMutableArray array];
    self.netSecWork = [[BTNetWorkTopSecondGet alloc] init];
}

#pragma mark 创建的导航栏

- (void)setNavigationBarProperty {
    [self.view bringSubviewToFront: self.navigationBar];
    [self setNavigationBarBgColor: BTColor(252, 99, 100) Alpha:1];
    
    [self setNavigationBarTitleText:_titleStr Color:UIColorC3 Font:UISystemFontT6 Bold:15];
    [self setNavigationBarLeftButtonBgImg:[UIImage imageNamed:@"top_back_icon"] TouchImg:nil Text:@""];
    [self alphaNav:1.f];
}

- (void)creatTalbleView{
    self.homeHeadTableView = [[UITableView alloc] initWithFrame:CGRectMake(BTZero, HKTopBarHeight, HKUIScreenWidth, HKUIScreenHeight - HKTopBarHeight) style:UITableViewStylePlain];
    _homeHeadTableView.backgroundColor = [UIColor clearColor];
    _homeHeadTableView.delegate = self;
    _homeHeadTableView.dataSource = self;
    _homeHeadTableView.scrollsToTop = YES;
    _homeHeadTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self initMJRefresh:_homeHeadTableView IsCreatFooterView:NO];
    [self.view addSubview:_homeHeadTableView];
}

#pragma mark talbeView代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 250;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BTHomeHeadCell *myCell = [tableView dequeueReusableCellWithIdentifier:identerfy];
    if (!myCell) {
        myCell = [[BTHomeHeadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identerfy Size:CGSizeMake(HKUIScreenWidth, 200)];
    }
    return myCell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    BTHomeHeadCell *myCell = (BTHomeHeadCell*)cell;
    myCell.model = _dataSource[indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //获取cell在当前tabeliew的高度
    CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
    CGRect cellRect = [tableView convertRect:rectInTableView toView:[tableView superview]];
    self.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.1];
    self.homeHeadTableView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:.1];
    BTSHoppingViewController *controller = [[BTSHoppingViewController alloc] init];
    controller.homePostIndexPath = indexPath;
    controller.homePostBackSoure = _dataSource;
    controller.cellRect = cellRect;
    controller.transFirImageArr = _transFirImageArr;
    [self pushContrllerWithType:@"cube" Subtype:kCATransitionFromBottom Duration:1.5f];
    [self.navigationController pushViewController:controller animated:NO];
    
}

- (void)refreshFinish {
    [self respotNetWorkSecondTopWihtIDS:self.extendData];
}
#pragma mark 网络请求数据

- (void)respotNetWorkSecondTopWihtIDS:(NSString*)ids {
    [self showWaitProgressAsyn:nil];
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    NSString *dev =  [BTResource doDevicePlatformWithIshiddenModel:NO];
    NSString *device_info = [NSString stringWithFormat:@"%@",dev];
    
    [_netSecWork getHomelistWithOs_versions:systemVersion
                                     ScreenSize:HKUIScreenHeight
                              TRACK_device_info:device_info
                                            IDS:ids
                                           PAGE:0
                                     UpDateTime:0
                            netReachabilityType:^(BTNetReachabilityType reachabilityType) {
                                
                                if (reachabilityType == BTNetReachabilityTypeOK) {
                                    if (BTOne == _netSecWork.status){
                                        for (BTtopicModel *model in _netSecWork.TopMutable) {
                                            [_dataSource  addObject:model];
                                        }
                                        
                                    }
                                    [self.homeHeadTableView reloadData];
                                    [self hiddenWaitProgressAsyn];
                                }else{
                                    [BTLog trace:BTHomeDetails Content:@"reachabilityType"];
                                }
                            }];
}
- (void)leftButtonAction {
    [super leftButtonAction];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
