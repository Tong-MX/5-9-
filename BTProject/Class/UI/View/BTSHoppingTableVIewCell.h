//
//  BTSHoppingTableVIewCell.h
//  BTProject
//
//  Created by 明桐的Mac on 16/4/30.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTObjectTableViewCell.h"
@protocol BTShoppingPayClickActionDelegate <NSObject>
- (void)payBuyActionWithTagCell:(NSInteger)tagCell;
@end
@interface BTSHoppingTableVIewCell : BTObjectTableViewCell
@property (nonatomic, strong)id dataSoucreTable;//dataSoucre数据
@property (nonatomic, strong)NSMutableArray *imageGoodeArr;//贴图图片
@property (nonatomic, assign)id<BTShoppingPayClickActionDelegate>buyDelegate;
@property (nonatomic, strong)UIButton *buyBtn;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Size:(CGSize)size;
- (CGFloat)layoutSubviewsRepet;
@end
