//
//  BaseRequestListVC.h
//  BTProject
//
//  Created by 明桐的Mac on 16/3/23.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTTopBarViewController.h"
#import "RefreshHeaderView.h"
#import "MJRefreshFooterView.h"
#import "MBProgressHUD.h"
#import "BTProgressHUD.h"
@interface BaseRequestListVC : BTTopBarViewController<MJRefreshBaseViewDelegate>

@property (nonatomic, strong) RefreshHeaderView *header;
@property (nonatomic, strong) MJRefreshFooterView *footer;
@property (assign, nonatomic) int pageNum;
@property (assign, nonatomic) int pageSize;
@property (assign, nonatomic) int total; //总共多少条
@property (assign, nonatomic) int hasNumber;// 已有多少条
@property (nonatomic, strong) NSMutableArray *photos;//相机图片

//- (void)initMJRefresh: (UITableView*)scrollView;
- (void)initMJRefresh: (UITableView*)tableView IsCreatFooterView:(BOOL)iscreatFooterView;

- (void)noFooterLoad;

- (void)showWaitProgressAsyn:(NSString *)text;
- (void)hiddenWaitProgressAsyn;
- (void)requestFailure: (int)error showReloadView: (BOOL)show;
- (void)refreshFinish;
- (void)initAsynProgressHUD;

- (void)hiddenReloadView;
- (void)reloadUI;
@end
