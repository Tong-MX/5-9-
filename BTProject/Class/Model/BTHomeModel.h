//
//  HomeModel.h
//  BTProject
//
//  Created by 明桐的Mac on 16/3/23.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//"id": "682",
/*
 "id": "463",
 "title": "好物",
 "sub_title": "",
 "type": "goods",
 "photo": "http://7xiwnz.com2.z0.glb.qiniucdn.com/element1/201512/10048575.jpg?v=1450328061",
 "extend": "",
 "index": 5*/

#import "BaseModel.h"

@interface BTHomeModel : BaseModel
@property (nonatomic ,strong)NSString *id;
@property (nonatomic ,strong)NSString *title;
@property (nonatomic ,strong)NSString *sub_title;
@property (nonatomic ,strong)NSString *type;
@property (nonatomic ,strong)NSString *photo;
@property (nonatomic ,strong)NSString *extend;
@property (nonatomic ,assign)NSInteger index;
@property (nonatomic ,strong)NSString *topic_type;

+ (instancetype)HomeWithDic:(NSDictionary *)dic;
@end
