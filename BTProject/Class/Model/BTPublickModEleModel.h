//
//  BTPublickModEleModel.h
//  BTProject
//
//  Created by 明桐的Mac on 16/4/15.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//
/*
 "id": "26",
 "title": "热门推荐",
 "elements"
 */
#import "BaseModel.h"

@interface BTPublickModEleModel : BaseModel
@property (nonatomic ,copy)NSString *id;
@property (nonatomic ,copy)NSString *title;
@property (nonatomic ,strong)NSArray *elements;

+ (instancetype)publickModEleWithDic:(NSDictionary *)dic;
@end
