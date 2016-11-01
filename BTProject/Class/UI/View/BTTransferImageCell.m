//
//  BTTransferImageCell.m
//  BTProject
//
//  Created by 明桐的Mac on 16/4/26.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTTransferImageCell.h"

@implementation BTTransferImageCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI {
    self.cellImageVIew = [[UIImageView alloc] init];
    self.cellImageVIew.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_cellImageVIew];
}

- (void)layoutSubviews {
    self.cellImageVIew.frame = CGRectMake(0, 0, (HKUIScreenWidth - 2*4) / 3, (HKUIScreenWidth - 2*4) / 3);
}
@end
