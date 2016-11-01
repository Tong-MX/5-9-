//
//  BTPublickCollectionViewCell.h
//  BTProject
//
//  Created by 明桐的Mac on 16/4/15.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTPublickCollectionViewCell : UICollectionViewCell
@property (nonatomic ,strong)UIButton *titleOneBtn;
@property (nonatomic ,strong)UIButton *titleTwoBtn;
@property (nonatomic ,strong)NSMutableArray *dataSouce;
@property (nonatomic ,strong)UILabel *nameOneLabel;
@property (nonatomic ,strong)UILabel *nameTwoLabel;
@property (nonatomic ,strong)UILabel *popularityOneLabel;
@property (nonatomic ,strong)UILabel *popularityTwoLabel;
@end
