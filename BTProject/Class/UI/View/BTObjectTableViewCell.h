//
//  BTObjectTableViewCell.h
//  BTProject
//
//  Created by 明桐的Mac on 16/4/2.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTObjectTableViewCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Size: (CGSize)size;

- (void)initParameter;
- (void)initSize;

- (void)afresh;
- (void)afreshRect: (CGRect)rect;
@end
