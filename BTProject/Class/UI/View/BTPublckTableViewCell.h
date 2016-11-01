//
//  BTPublckTableViewCell.h
//  BTProject
//
//  Created by 明桐的Mac on 16/4/15.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol changeBtnDelegata <NSObject>
- (void)chageBtnSelectate:(UIButton*)click;
@end
@interface BTPublckTableViewCell : UITableViewCell
@property (nonatomic ,strong)UILabel *titleLabel;
@property (nonatomic ,strong)UIImageView *cellImage;
@property (nonatomic ,strong)UIImageView *imageName;
@property (nonatomic ,strong)UILabel *browseLabel;
@property (nonatomic ,strong)UILabel *postLabel;
@property (nonatomic ,strong)UIView *lineView;
@property (nonatomic ,strong)UIButton *changeBtn;
@property (nonatomic ,assign)id<changeBtnDelegata>delegate;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Size: (CGSize)size indexPax:(NSIndexPath*)indexPath;
@end
