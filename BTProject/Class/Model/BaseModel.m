//
//  BaseModel.m
//  BTProject
//
//  Created by 明桐的Mac on 16/3/23.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self == [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
        
    }
    return self;
    
}
@end
