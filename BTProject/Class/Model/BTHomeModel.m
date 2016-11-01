//
//  HomeModel.m
//  BTProject
//
//  Created by 明桐的Mac on 16/3/23.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTHomeModel.h"

@implementation BTHomeModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self == [super initWithDic:dic]) {
        
        
    }
    return self;
}

+ (instancetype)HomeWithDic:(NSDictionary *)dic{
    return  [[self alloc]initWithDic:dic];
    
}

@end
