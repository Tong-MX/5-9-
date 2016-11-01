//
//  BTPublickZCCell.h
//  BTProject
//
//  Created by 明桐的Mac on 16/5/7.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTObjectTableViewCell.h"

@interface BTPublickZCCell : BTObjectTableViewCell
@property (nonatomic ,strong)NSMutableArray *postListArr;
- (CGFloat)layoutSuperSubviews;
@end
