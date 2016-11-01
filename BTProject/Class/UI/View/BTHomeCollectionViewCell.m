//
//  BTHomeCollectionViewCell.m
//  BTProject
//
//  Created by 明桐的Mac on 16/4/1.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTHomeCollectionViewCell.h"
#import "BTHomeTableViewCell.h"
#import "BTNetWorkTopOhterGet.h"
#import "MJRefreshFooterView.h"
#import "BTHomeModel.h"
static NSString *cellIdetify = @"cell";
@interface BTHomeCollectionViewCell()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,BTHomeCellHeightDelegate>{
    
    CGSize tableSize;
    
}
@property (nonatomic ,strong) UIView *homeHeadView;
@property (nonatomic ,strong) NSMutableArray *oneTopArr;
@property (nonatomic ,strong) NSMutableArray *secTopArr;
@property (nonatomic ,strong) NSMutableArray *thirdTopArr;
@property (nonatomic ,strong) BTHomeTableViewCell *myCell;
//@property (nonatomic, strong) MJRefreshHeaderView *header;
@property (nonatomic, strong) MJRefreshFooterView *footer;
@property (nonatomic, strong) NSMutableArray *cellArr;
@property (nonatomic, strong) NSMutableArray *array;
@end
@implementation BTHomeCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self initParameters];
        [self creatTalbleView];
        self.cellArr = [NSMutableArray array];
        self.array = [NSMutableArray array];
    }
    return self;
}

- (void)initParameters{
    
//    self.dataSource = [NSMutableArray array];
    self.oneTopArr = [NSMutableArray array];
    self.secTopArr = [NSMutableArray array];
    self.thirdTopArr = [NSMutableArray array];
    _myCell = [[BTHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetify Size:CGSizeMake(HKUIScreenWidth, 250)];
    
}
- (void)creatTalbleView{
    self.homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(BTZero, BTZero, HKUIScreenWidth, HKUIScreenHeight-9) style:UITableViewStylePlain];
    _homeTableView.backgroundColor = [UIColor clearColor];
    _homeTableView.tableHeaderView = [self homeHearView];
    _homeTableView.delegate = self;
    _homeTableView.dataSource = self;
    _homeTableView.scrollsToTop = YES;
    _homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView addSubview:_homeTableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return BTOne;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([_dataSource[0] isKindOfClass:[BTHomeModel class]]) {
        BTHomeModel *model = (BTHomeModel*)_dataSource[indexPath.row];
        if ([model.type isEqualToString:@"webview"]) {
            return [_myCell anualLayoutSubviews] - [BTCommonUtil setHeightPX:4];
        }
    }
    return [_myCell anualLayoutSubviews] + [BTCommonUtil setHeightPX:40];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   self.myCell = (BTHomeTableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdetify];
    if (!_myCell) {
        self.myCell = [[BTHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetify Size:CGSizeMake(HKUIScreenWidth, 250)];
    }
    _myCell.backgroundColor = [UIColor clearColor];
    
    return _myCell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _myCell.topModel = _dataSource[indexPath.row];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.homeTableView deselectRowAtIndexPath:indexPath animated:NO];
    //获取cell在当前tabeliew的高度
    CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
    CGRect rect = [tableView convertRect:rectInTableView toView:[tableView superview]];

    if (_delegate && [_delegate respondsToSelector:@selector(btHomeTableView:didSelectRowAtIndexPath:HomePostBackSoure:CellRect:)]) {
        [_delegate btHomeTableView:tableView didSelectRowAtIndexPath:indexPath HomePostBackSoure:_dataSource CellRect:rect];
    }
}
#pragma mark 创建头视图

- (UIView*)homeHearView{
    self.homeHeadView = [[UIView alloc] initWithFrame:CGRectMake(BTZero, BTZero, HKUIScreenWidth, [BTCommonUtil setHeightPX:646])];
    self.homeHeadView.backgroundColor = [UIColor clearColor];
    return _homeHeadView;
}

- (void)setDataSource:(NSMutableArray *)dataSource{
    _dataSource = dataSource;
    if (_dataSource.count > 0) {
        [self.array removeAllObjects];
        for (int i = 0; i < _dataSource.count; i++) {
            UICollectionViewCell *viewCell = [[UICollectionViewCell alloc] initWithFrame:CGRectMake(0, 250 , HKUIScreenWidth, 200)];
            [_array addObject:viewCell];
        }
    }
    [_homeTableView reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y == 0) {
        return;
    }else {
        if (self.isRecordRefresh) {
            self.isRecordRefresh = NO;
            return;
        }else {
            self.scolleViewSetY = scrollView.contentOffset.y;
        }
    }
}
@end
