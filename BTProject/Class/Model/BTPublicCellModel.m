//
//  BTPublicCellModel.m
//  BTProject
//
//  Created by 明桐的Mac on 16/4/16.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTPublicCellModel.h"

@implementation BTPublicCellModel
- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self == [super initWithDic:dic]) {
        
    }
    return self;
}

+ (instancetype)publickModeCellWithDic:(NSDictionary *)dic {
    return  [[self alloc]initWithDic:dic];
    
}

@end
