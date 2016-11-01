//
//  BTPublicModel.h
//  BTProject
//
//  Created by 明桐的Mac on 16/4/15.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//
/*
 "id": "469",
 "title": "手机控",
 "sub_title": "15952人气",
 "type": "post_list_element",
 "topic_type": "",
 "photo": "http://7xiwnz.com2.z0.glb.qiniucdn.com/element1/201512/49575548.jpg?v=1450427393",
 "extend": "469",
 "index": 100
 */

#import "BaseModel.h"

@interface BTPublicModel : BaseModel
@property (nonatomic ,assign)NSString *id;
@property (nonatomic ,strong)NSString *title;
@property (nonatomic ,strong)NSString *sub_title;
@property (nonatomic ,strong)NSString *type;
@property (nonatomic ,strong)NSString *photo;
@property (nonatomic ,strong)NSString *extend;
@property (nonatomic ,assign)NSInteger index;
@property (nonatomic ,strong)NSString *topic_type;

+ (instancetype)publickWithDic:(NSDictionary *)dic;
@end
