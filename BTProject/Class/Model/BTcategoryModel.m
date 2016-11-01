//
//  BTcategoryModel.m
//  BTProject
//
//  Created by 明桐的Mac on 16/3/28.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTcategoryModel.h"

@implementation BTcategoryModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self == [super initWithDic:dic]) {
        
        
    }
    return self;
}

+ (instancetype)HomeWithDic:(NSDictionary *)dic{
    return  [[self alloc]initWithDic:dic];
    
}

@end
