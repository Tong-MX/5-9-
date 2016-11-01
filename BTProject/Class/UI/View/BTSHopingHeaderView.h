//
//  BTSHopingHeaderView.h
//  BTProject
//
//  Created by 明桐的Mac on 16/5/2.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTObjectView.h"
typedef void (^SHopingHeaderBlock) (CGRect rectHeaderView);
@interface BTSHopingHeaderView : BTObjectView
@property (nonatomic, strong)NSString *desStr;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, copy)SHopingHeaderBlock block;
@end
