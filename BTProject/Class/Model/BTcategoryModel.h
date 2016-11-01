//
//  BTcategoryModel.h
//  BTProject
//
//  Created by 明桐的Mac on 16/3/28.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//
/*
 "id": "612",
 "title": "一周最热",
 "sub_title": "",
 "type": "topic_list",
 "photo": "",
 "extend": "2271,2292,2269,2321,2291,2343,2319,2337,2334,2338",
 "index": 143
 */

#import "BaseModel.h"

@interface BTcategoryModel : BaseModel
@property (nonatomic ,strong)NSString *id;
@property (nonatomic ,strong)NSString *title;
@property (nonatomic ,strong)NSString *sub_title;
@property (nonatomic ,strong)NSString *type;
@property (nonatomic ,strong)NSString *photo;
@property (nonatomic ,strong)NSString *extend;
@property (nonatomic ,assign)NSInteger index;
+ (instancetype)HomeWithDic:(NSDictionary *)dic;

@end
