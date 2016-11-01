//
//  Public ViewController.m
//  BTProject
//
//  Created by 明桐的Mac on 16/3/19.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTPublicViewController.h"
#import "BTPublicModel.h"
#import "BTNetWorkPublicGet.h"
#import "BTPublickModEleModel.h"
#import "BTPublickHeadView.h"
#import "BTPublckTableViewCell.h"
#import "BTPublicCellModel.h"
#import "BTRegisterController.h"
#import "BTPublickZCViewController.h"
#define TagUI @"公共主页"
@interface BTPublicViewController ()<UITableViewDataSource,UITableViewDelegate,changeBtnDelegata> {
}
@property (nonatomic ,strong)BTNetWorkPublicGet *netWorkPublic;
@property (nonatomic ,strong)NSMutableArray *upDataArr;
@property (nonatomic ,strong)NSMutableArray *publickHeadTitelArr;
@property (nonatomic ,strong)NSMutableArray *elementsMutable;
@property (nonatomic ,strong)NSMutableArray *elementsArr;
@property (nonatomic ,strong)NSMutableArray *recGroupsArr;
@property (nonatomic ,strong)NSMutableArray *groupID;
@property (nonatomic ,strong)NSMutableArray *pic3Arr;
@property (nonatomic ,strong)NSMutableArray *browseArr;
@property (nonatomic ,strong)NSMutableArray *postsArr;
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)BTPublickHeadView *headView;
@property (nonatomic ,strong)BTPublckTableViewCell *cell;
@end

@implementation BTPublicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigationBarProperty];
    [self creatTabelView];
    [self creatTableViewHeadView];
    [self NetWorkRespond];
}

#pragma mark 初始化
- (void)initParameters {
    _netWorkPublic = [[BTNetWorkPublicGet alloc] init];
    _publickHeadTitelArr = [NSMutableArray array];
    _elementsArr = [NSMutableArray array];
    _elementsMutable = [NSMutableArray array];
    _pic3Arr = [NSMutableArray array];
    _browseArr = [NSMutableArray array];
    _postsArr = [NSMutableArray array];
    _groupID = [NSMutableArray array];
}

#pragma mark 创建的导航栏
- (void)setNavigationBarProperty {
    [self setNavigationBarBgColor: BTColor(252, 99, 100) Alpha:1];
    [self setNavigationBarLeftButtonBgImg:[UIImage imageNamed:@"b_1_q065"] TouchImg:nil Text:@""];
    [self setNavigationBarRightButtonBgImg:[UIImage imageNamed:@"community_add_friend"] TouchImg:nil Text:nil];
    [self hiddenRightButton:NO];
    [self hiddenTitleTwoBtnWithBtnFirst:@"广场" BtnSec:@"关注" TitleImge:[UIImage imageNamed:@"top_bar_bg"]];
}

#pragma mark 创建talbeView

- (void)creatTabelView {
    CGRect rect = CGRectMake(BTZero, HKTopBarHeight, HKControllerViewWidth, HKTopBarOutsidHeight - 49);
    
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _tableView.backgroundColor =  BTColor(247, 247, 247);
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.bounces = YES;
    _tableView.hidden = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self initMJRefresh:_tableView IsCreatFooterView:NO];
    [self.view addSubview: _tableView];
}

#pragma mark 创建talbelView的头视图
- (void)creatTableViewHeadView {
    _headView = [[BTPublickHeadView alloc] initWithFrame:CGRectMake(BTZero, self.navigationBar.height, HKUIScreenWidth, [BTCommonUtil setHeightPX:540])];
    _tableView.tableHeaderView = _headView;
}

#pragma mark 点击广场关注的代理方法
- (void)titleTwoBtnAction:(UIButton *)btn {
    NSLog(@"%ld",btn.tag);
    if (btn.tag == 1) {
        BTRegisterController *registerVc = [[BTRegisterController alloc] init];
        [self.navigationController presentViewController:registerVc animated:YES completion:nil];
    }
}

#define UITableSections 1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return UITableSections;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [BTCommonUtil setHeightPX:185 *2];
    }else if (indexPath.row == 4) {
        return [BTCommonUtil setHeightPX:165 *2];
    }
    return [BTCommonUtil setHeightPX:140 *2];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _recGroupsArr.count/2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdetify = @"cell";
    _cell = [tableView dequeueReusableCellWithIdentifier:cellIdetify];
    if(!_cell) {
        _cell.selectionStyle = UITableViewCellSelectionStyleNone;
        _cell = [[BTPublckTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: cellIdetify Size: CGSizeMake(tableView.frame.size.width, 100)indexPax:indexPath];
    }
    return _cell;
}

#pragma mark 将要做布局时候的talbel方法
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [UIView animateWithDuration:.3 animations:^{
     if (indexPath.row == 0) {
         //创建cell里的图片和名字的赋值 因为需要处理种草小分队的复用所以不再cell做处理会出现复用问题
         _cell.titleLabel.text = @"种草小分队";
         _cell.lineView.frame = CGRectMake(0, 0, HKUIScreenWidth, 10);
         _cell.cellImage.frame = CGRectMake(10, _cell.titleLabel.height + _cell.titleLabel.orightY, HKUIScreenWidth - 20, [BTCommonUtil setHeightPX:260]);
         _cell.imageName.frame = CGRectMake(_cell.cellImage.width/2 - [BTCommonUtil setHeightPX:312.5]/2, _cell.cellImage.height/2 - (_cell.cellImage.height/5), [BTCommonUtil setHeightPX:312.5], _cell.cellImage.height/3.4);
         _cell.browseLabel.frame = CGRectMake(_cell.imageName.orightX, _cell.imageName.orightY + _cell.imageName.height + 5, _cell.imageName.width/2, 10);
         _cell.postLabel.frame = CGRectMake(_cell.browseLabel.orightX + _cell.browseLabel.width + 5, _cell.browseLabel.orightY, _cell.browseLabel.width, _cell.browseLabel.height);
         _cell.browseLabel.text = [NSString stringWithFormat:@"%@%@",_browseArr[indexPath.row],@"浏览"];
         _cell.postLabel.text = [NSString stringWithFormat:@"%@%@",_postsArr[indexPath.row],@"帖子"];
         [_cell.cellImage sd_setImageWithURL:_recGroupsArr[indexPath.row] placeholderImage:nil];
         [_cell.imageName sd_setImageWithURL:_pic3Arr[indexPath.row] placeholderImage:nil];
     }else {
         _cell.titleLabel.text = @"";
         _cell.lineView.frame = CGRectMake(0, 140, HKUIScreenWidth, 0);
         _cell.cellImage.frame = CGRectMake(10, 0, HKUIScreenWidth - 20, [BTCommonUtil setHeightPX:260]);
         _cell.imageName.frame = CGRectMake(_cell.cellImage.width/2 - [BTCommonUtil setHeightPX:312.5]/2, _cell.cellImage.height/2 - (_cell.cellImage.height/5), [BTCommonUtil setHeightPX:312.5], _cell.cellImage.height/3.4);
         _cell.browseLabel.frame = CGRectMake(_cell.imageName.orightX, _cell.imageName.orightY + _cell.imageName.height + 5, _cell.imageName.width/2, 10);
         _cell.postLabel.frame = CGRectMake(_cell.browseLabel.orightX + _cell.browseLabel.width + 5, _cell.browseLabel.orightY, _cell.browseLabel.width, _cell.browseLabel.height);
         _cell.browseLabel.text = [NSString stringWithFormat:@"%@%@",_browseArr[indexPath.row],@"浏览"];
         _cell.postLabel.text = [NSString stringWithFormat:@"%@%@",_postsArr[indexPath.row],@"帖子"];
         [_cell.cellImage sd_setImageWithURL:_recGroupsArr[indexPath.row] placeholderImage:nil];
         [_cell.imageName sd_setImageWithURL:_pic3Arr[indexPath.row] placeholderImage:nil];
         
         if (indexPath.row == 4) {
             _cell.delegate = self;
             _cell.changeBtn.frame = CGRectMake(_cell.cellImage.width/2 - 30, _cell.cellImage.orightY + _cell.cellImage.height + 10, 71, 15);
             [_cell.changeBtn setImage:[UIImage imageNamed:@"commu_home_recom_change_icon" ]forState:UIControlStateNormal];
         }
     }
 }];
    
}

#pragma mark 上拉刷新

- (void)refreshFinish {
    [super refreshFinish];
    [self chageBtnSelectate:nil];
}
#pragma mark 换一换的点击事件处理使数组元素进行交互
- (void)chageBtnSelectate:(UIButton *)click {
    for (int i = 0; i < _recGroupsArr.count/2; i++) {
    [_recGroupsArr exchangeObjectAtIndex:i withObjectAtIndex:_recGroupsArr.count - (i+1)];
        [_pic3Arr exchangeObjectAtIndex:i withObjectAtIndex:_pic3Arr.count- (i+1)];
        [_browseArr exchangeObjectAtIndex:i withObjectAtIndex:_browseArr.count- (i+1)];
        [_postsArr exchangeObjectAtIndex:i withObjectAtIndex:_postsArr.count- (i+1)];
        [_groupID exchangeObjectAtIndex:i withObjectAtIndex:_groupID.count - (i+1)];
    }
    [_tableView reloadData];
}

#pragma mark 点击事件

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BTPublickZCViewController *controller = [[BTPublickZCViewController alloc] init];
    controller.groupID = [self.groupID[indexPath.row] integerValue];
    [self.navigationController pushViewController:controller animated:YES];
}
#pragma mark 网络请求部分

- (void)NetWorkRespond {
    [self showWaitProgressAsyn:@""];
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    NSString *dev =  [BTResource doDevicePlatformWithIshiddenModel:NO];
    NSString *device_info = [NSString stringWithFormat:@"%@",dev];
    self.upDataArr = [NSMutableArray array];
    self.recGroupsArr = [NSMutableArray array];
    [_netWorkPublic getHomelistWithOs_versions:systemVersion ScreenSize:HKUIScreenHeight TRACK_device_info:device_info netReachabilityType:^(BTNetReachabilityType reachabilityType) {
        if (reachabilityType == BTNetReachabilityTypeOK) {
            if (_netWorkPublic.status == 1) {
                for (BTPublickModEleModel *model in _netWorkPublic.publickModEleArr) {
                    [_upDataArr addObject:model];
                    [_elementsMutable addObject:model.elements];
                }
                [_elementsMutable enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [_publickHeadTitelArr addObject:obj];
                }];
                
                for (BTPublicCellModel *model in _netWorkPublic.recGroupsMutable) {
                    [_groupID addObject:model.id];
                    [_recGroupsArr addObject:model.pic2];
                    [_pic3Arr addObject:model.pic3];
                    [_browseArr addObject:model.dynamic[@"views"]];
                    [_postsArr addObject:model.dynamic[@"posts"]];
                }
                
                NSDictionary *elementDic = [NSDictionary dictionaryWithObjectsAndKeys:_upDataArr,@"upDataArr",_publickHeadTitelArr,@"publickHeadTitelArr",nil];
                _headView.upDataDic = elementDic;
                [_tableView reloadData];
                [self hiddenWaitProgressAsyn];
            }
        }else{
            [self hiddenWaitProgressAsyn];
            [self requestFailure: reachabilityType showReloadView: NO];
            [BTLog trace: TagUI Content: [NSString stringWithFormat: @"网络请求失败错误码 ＝ %d", reachabilityType]];
        }
    }];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
