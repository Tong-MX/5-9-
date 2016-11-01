//
//  MessageViewController.m
//  BTProject
//
//  Created by 明桐的Mac on 16/3/19.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTMessageViewController.h"
#import "BTMessageCell.h"

@interface BTMessageViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)BTMessageCell *myCell;
@property (nonatomic ,strong)NSArray *imageMutalbe;
@property (nonatomic ,strong)NSArray *messageMutalbe;
@end

@implementation BTMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BTColor(247, 247, 247);
    [self creatTitleNav];
    [self creatTabelView];
    // Do any additional setup after loading the view.
}
#pragma mark 创建导航栏

- (void)creatTitleNav {
    [self setNavigationBarBgColor: BTColor(252, 99, 100) Alpha:1];
    [self setNavigationBarTitleText:@"消息" Color:UIColorC3 Font:UISystemFontT6 Bold:BlodDefine];
}

#pragma mark 初始化

- (void)initParameters {
    _imageMutalbe = @[@"icon_message_user",@"icon_message_comment",@"icon_message_like",@"icon_message_reward",@"icon_message_notifaction"];
    _messageMutalbe = @[@"新的粉丝",@"新的评论",@"新的喜欢",@"新的奖励",@"新的通知"];
}

#pragma mark 创建talbeView

- (void)creatTabelView {
    CGRect rect = CGRectMake(BTZero, HKTopBarHeight, HKControllerViewWidth, HKTopBarOutsidHeight);
    
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
    return _imageMutalbe.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

   self.myCell = [[BTMessageCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil Size:CGSizeMake(tableView.frame.size.width, 100)];
    _myCell.selectionStyle = UITableViewCellSelectionStyleNone;
    _myCell.backgroundColor = [UIColor clearColor];
    return _myCell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    _myCell.messageImage.image = [UIImage imageNamed:_imageMutalbe[indexPath.row]];
    _myCell.messageComment.text = _messageMutalbe[indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
@end
