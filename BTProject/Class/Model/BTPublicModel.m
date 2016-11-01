//
//  BTPublicModel.m
//  BTProject
//
//  Created by 明桐的Mac on 16/4/15.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//
#import "BTPublicModel.h"

@implementation BTPublicModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self == [super initWithDic:dic]) {
        
        
    }
    return self;
}

+ (instancetype)publickWithDic:(NSDictionary *)dic{
    return  [[self alloc]initWithDic:dic];
    
}

@end
