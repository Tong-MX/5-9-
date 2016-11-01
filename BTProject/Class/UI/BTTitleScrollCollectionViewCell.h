//
//  BTTitleScrollCollectionViewCell.h
//  BTProject
//
//  Created by 明桐的Mac on 16/3/31.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BTTitleScrollCollectionViewCellDelegate <NSObject>


- (void)didSelectedBtnWithIndexPath:(NSIndexPath *)indexPath withBtn:(UIButton *)titleBtn;

@end

@interface BTTitleScrollCollectionViewCell : UICollectionViewCell
@property (nonatomic ,strong)UIButton *titleBtn;
@property (nonatomic ,assign)NSInteger tagVlue;
@property (nonatomic ,strong)NSIndexPath *indexPath;
@property (nonatomic ,strong)UIView *titleView;

@property (nonatomic, weak) id<BTTitleScrollCollectionViewCellDelegate>      delegate;
@property (nonatomic ,strong)NSIndexPath *titleScolleIndexPath;
@end
