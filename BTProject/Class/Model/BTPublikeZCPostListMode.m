//
//  BTPublikeZCPostListMode.m
//  BTProject
//
//  Created by 明桐的Mac on 16/5/8.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTPublikeZCPostListMode.h"

@implementation BTPublikeZCPostListMode
- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self == [super initWithDic:dic]) {
        
    }
    return self;
}
+ (instancetype)publickZCPostListModeCellWithDic:(NSDictionary *)dic {
    return  [[self alloc]initWithDic:dic];
}
@end
