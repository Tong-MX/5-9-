//
//  BTMessageView.h
//  BTProject
//
//  Created by 明桐的Mac on 16/4/25.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTObjectTableViewCell.h"

@interface BTMessageCell : BTObjectTableViewCell
@property (nonatomic, strong)UIImageView *messageImage;
@property (nonatomic, strong)UILabel *messageComment;
@property (nonatomic, strong)UIImageView *postProductImage;
@property (nonatomic, strong)UIView *lineView;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Size:(CGSize)size ;
@end
