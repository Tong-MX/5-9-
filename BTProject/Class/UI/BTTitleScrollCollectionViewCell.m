//
//  BTTitleScrollCollectionViewCell.m
//  BTProject
//
//  Created by 明桐的Mac on 16/3/31.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTTitleScrollCollectionViewCell.h"

@implementation BTTitleScrollCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self.contentView addSubview:self.titleBtn];
        [self.contentView addSubview:self.titleView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleBtn.frame = CGRectMake(0, 0, self.width, self.height);
    if ([BTCommonUtil iphone6P]) {
        self.titleView.frame = CGRectMake(0, 35, self.width, 2);
    }else {
        self.titleView.frame = CGRectMake(0, 38, self.width, 2);
    }
}

- (UIButton *)titleBtn {
    
    if (!_titleBtn) {
    
        _titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];

        _titleBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_titleBtn setTitleColor: BTColor(133, 133, 133) forState:UIControlStateNormal];
        _titleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_titleBtn setTitleColor:UIColorC17 forState:UIControlStateSelected];

    }
    return _titleBtn;
}

- (UIView*)titleView {
    
    if (!_titleView) {
        self.titleView = [[UIView alloc] init];
    }
    return _titleView;
}
- (void)click:(UIButton*)btn{
    NSLog(@"%ld",self.indexPath.row);
    if ([self.delegate respondsToSelector:@selector(didSelectedBtnWithIndexPath:withBtn:)]) {
        
        [self.delegate didSelectedBtnWithIndexPath:self.indexPath withBtn:btn];
    }

}
- (void)setTitleScolleIndexPath:(NSIndexPath *)titleScolleIndexPath {
    _titleScolleIndexPath = titleScolleIndexPath;
    _indexPath = _titleScolleIndexPath;
}
@end
