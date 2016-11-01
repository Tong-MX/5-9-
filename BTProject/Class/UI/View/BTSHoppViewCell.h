//
//  BTSHoppViewCell.h
//  BTProject
//
//  Created by 明桐的Mac on 16/4/29.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTSHoppingTableVIewCell.h"
#import "BTshoppingModel.h"
@protocol BTScrolleViewSetYDelegate <NSObject>
- (void)transletSetYData:(CGFloat)scrollViewSetY headerViewHeight:(CGFloat)headerHeight;
- (void)clickPhotoDelegate;
- (void)payBuyActionWithShopingModel:(BTshoppingModel*)shopingModel;
@end

@interface BTSHoppViewCell : UICollectionViewCell
@property (nonatomic, strong)UITableView *homeTableView;
@property (nonatomic, strong)NSString *desStr;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)UIImageView *snapShotView;
@property (nonatomic, assign)CGFloat headerViewHeigth;
@property (nonatomic, strong)NSMutableArray *productMutalbe;
@property (nonatomic, strong)UIView *headerOtherView;
@property (nonatomic, strong)UIView *headerView;
@property (nonatomic, assign)CGFloat scolleViewSetY;
@property (nonatomic, assign)id<BTScrolleViewSetYDelegate>delegateScrolle;

- (void)resumeNormolStata;
@end
