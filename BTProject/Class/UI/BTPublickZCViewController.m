//
//  BTPublickZCViewController.m
//  BTProject
//
//  Created by 明桐的Mac on 16/5/7.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTPublickZCViewController.h"
#import "BTNetWorkZCPost.h"
#import "BTPublikeZCModel.h"
#import "BTPublickZCCell.h"
#import "BTPublickZCHeaderView.h"
#import "BTPublikeZCPostListMode.h"

static NSString *identifier = @"cellID";

@interface BTPublickZCViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSInteger commtentHeight;
}
@property (nonatomic ,strong)BTNetWorkZCPost *netWorkPublicZC;
@property (nonatomic ,strong)NSMutableArray *inforArr;
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)BTPublickZCCell *myCell;
@property (nonatomic ,strong)BTPublickZCHeaderView *headView;
@property (nonatomic ,strong)NSMutableArray *postListArr;
@end

@implementation BTPublickZCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatTabelView];
    [self creatTableViewHeadView];
    [self setNavigationBarProperty];
    // Do any additional setup after loading the view.
}

- (void)initParameters {
    [super initParameters];
    self.netWorkPublicZC = [[BTNetWorkZCPost alloc] init];
    self.inforArr = [NSMutableArray array];
    self.postListArr = [NSMutableArray array];
    self.myCell = [[BTPublickZCCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier Size:CGSizeMake(HKUIScreenWidth, 200)];
}

#pragma mark 创建的导航栏

- (void)setNavigationBarProperty {
    [self.view bringSubviewToFront: self.navigationBar];
    [self setNavigationBarBgColor: BTColor(252, 99, 100) Alpha:1];
    [self setNavigationBarLeftButtonBgImg:[UIImage imageNamed:@"top_back_icon"] TouchImg:nil Text:@""];
    [self setNavigationBarTitleText:@"半塘" Color:UIColorC3 Font:UISystemFontT6 Bold:BlodDefine];
    [self setNavigationBarRightButtonBgImg:[UIImage imageNamed:@"community_add_friend"] TouchImg:nil Text:nil];
    [self hiddenRightButton:NO];
//    [self alphaNav:0.f];

}

#pragma mark 创建talbelView的头视图
- (void)creatTableViewHeadView {
    _headView = [[BTPublickZCHeaderView alloc] initWithFrame:CGRectMake(BTZero, BTZero, HKUIScreenWidth, 390)];
    _headView.userInteractionEnabled = YES;
    _tableView.tableHeaderView = _headView;
    
}

#pragma mark 创建talbeView

- (void)creatTabelView {
    CGRect rect = CGRectMake(BTZero, -20, HKControllerViewWidth, HKUIScreenHeight + 20);
    
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _tableView.backgroundColor =  BTColor(247, 247, 247);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.bounces = YES;
    _tableView.hidden = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview: _tableView];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _postListArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    _myCell.postListArr = _postListArr[indexPath.row];
    BTPublikeZCPostListMode *model = (BTPublikeZCPostListMode*)_postListArr[indexPath.row];
    NSMutableArray *commentsArr = [NSMutableArray array];
    [model.comments enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [commentsArr addObject:obj[@"username"]];
    }];
    if (commentsArr.count > 3) {
        commtentHeight = 3;
    }else if (commentsArr.count == 0){
        commtentHeight = 0;
    }else {
        commtentHeight = commentsArr.count;
    }
    return [_myCell layoutSuperSubviews] + (commtentHeight * 17) + 20 + 40;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.myCell = (BTPublickZCCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (!_myCell) {
        self.myCell = [[BTPublickZCCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier Size:CGSizeMake(HKUIScreenWidth, 200)];
    }
    return _myCell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _myCell.postListArr = _postListArr[indexPath.row];
}
- (void)setGroupID:(NSInteger)groupID {
    _groupID = groupID;
    [self NetWorkRespond];
}

- (void)NetWorkRespond {
    [self showWaitProgressAsyn:@""];
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    NSString *dev =  [BTResource doDevicePlatformWithIshiddenModel:NO];
    NSString *device_info = [NSString stringWithFormat:@"%@",dev];
    [_netWorkPublicZC postPublicZClistWithOs_versions:systemVersion ScreenSize:HKUIScreenHeight TRACK_device_info:device_info GroupId:self.groupID netReachabilityType:^(BTNetReachabilityType reachabilityType) {
        if (reachabilityType == BTNetReachabilityTypeOK) {
            if (_netWorkPublicZC.status == 1) {
                _headView.modelArr = _netWorkPublicZC.inforArr;
                
                for (BTPublikeZCPostListMode *model in _netWorkPublicZC.postListArr) {
                    [_postListArr addObject:model];
                }
                [self.tableView reloadData];
            }
            
            [self hiddenWaitProgressAsyn];
        }
    }];
}

- (void)backAction {
    [super backAction];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
