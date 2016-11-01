//
//  BTPublikeZCModel.m
//  BTProject
//
//  Created by 明桐的Mac on 16/5/7.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//
//
#import "BTPublikeZCModel.h"

@implementation BTPublikeZCModel
- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self == [super initWithDic:dic]) {
        
    }
    return self;
}
+ (instancetype)publickZCModeCellWithDic:(NSDictionary *)dic {
    return  [[self alloc]initWithDic:dic];
}
@end
