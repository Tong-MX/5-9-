//
//  BTHomeCollectionViewCell.h
//  BTProject
//
//  Created by 明桐的Mac on 16/4/1.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTObjectTableViewCell.h"
#import "BTtopicModel.h"
@protocol BTHomeDidSelectDataDelegate<NSObject>
- (void)btHomeTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath HomePostBackSoure:(id)homePostBackSoure CellRect:(CGRect)cellRect;
@end
@interface BTHomeCollectionViewCell : UICollectionViewCell
@property (nonatomic ,strong)UITableView *homeTableView;
@property (nonatomic ,strong)BTtopicModel *topSmodel;
@property (nonatomic ,strong)NSMutableArray *dataSource;
@property (nonatomic ,assign)CGFloat scolleViewSetY;
@property (nonatomic ,assign)BOOL isRecordRefresh;
@property (nonatomic ,assign)id<BTHomeDidSelectDataDelegate>delegate;
@end
