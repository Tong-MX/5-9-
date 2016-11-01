//
//  BTHomeTableViewCell.h
//  BTProject
//
//  Created by 明桐的Mac on 16/4/4.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTObjectTableViewCell.h"
#import "BTtopicModel.h"
@protocol BTHomeCellHeightDelegate<NSObject>
@end
@interface BTHomeTableViewCell : BTObjectTableViewCell
@property (nonatomic ,strong)NSMutableArray *topModel;
@property (nonatomic ,strong)UILabel *namelabel;
@property (nonatomic ,strong)UILabel *numberLabel;
@property (nonatomic ,strong)UIImageView *heartImageView;
- (CGFloat)anualLayoutSubviews;
@end
