//
//  BTObjectTableViewCell.m
//  BTProject
//
//  Created by 明桐的Mac on 16/4/2.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTObjectTableViewCell.h"

@implementation BTObjectTableViewCell


- (void)dealloc {
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initParameter];
        [self initSize];
    }
    
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Size: (CGSize)size
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGRect rect = self.frame;
        rect.size = size;
        self.frame = rect;
        
        [self initParameter];
        [self initSize];
    }
    
    return self;
}

- (void)initParameter {
    self.backgroundColor = [UIColor clearColor];
}

- (void)initSize {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)afresh {
    [self setNeedsDisplay];
}

- (void)afreshRect: (CGRect)rect {
    self.frame = rect;
}
@end
