//
//  BTshoppingModel.m
//  BTProject
//
//  Created by 明桐的Mac on 16/4/30.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTshoppingModel.h"

@implementation BTshoppingModel
- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self == [super initWithDic:dic]) {
        
        
    }
    return self;
}

+ (instancetype)ShoppWithDic:(NSDictionary *)dic {
    return [[self alloc] initWithDic:dic];
}
@end
