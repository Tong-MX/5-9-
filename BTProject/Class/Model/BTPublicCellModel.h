//
//  BTPublicCellModel.h
//  BTProject
//
//  Created by 明桐的Mac on 16/4/16.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//
/*
 "id": "10",
 "name": "把屋子变成『家』",
 "pic1": "http://7xiwnz.com2.z0.glb.qiniucdn.com/post_group1/201602/55101555.jpg?v=1456210135",
 "pic2": "http://7xiwnz.com2.z0.glb.qiniucdn.com/post_group2/201602/55101559.jpg?v=1456210135",
 "pic3": "http://7xiwnz.com2.z0.glb.qiniucdn.com/post_group3/201512/49575452.jpg?v=1450437425",
 "create_time": "1459335940",
 "update_time": "1459335940",
 "author": {},
 "attention_users": [],
 "dynamic": {
 "views": 327161,
 "attentions": 7877,
 "posts": 322
*/

#import "BaseModel.h"

@interface BTPublicCellModel : BaseModel
@property (nonatomic ,copy)NSString *id;
@property (nonatomic ,copy)NSString *name;
@property (nonatomic ,copy)NSString *pic1;
@property (nonatomic ,copy)NSString *pic2;
@property (nonatomic ,copy)NSString *pic3;
@property (nonatomic ,copy)NSString *create_time;
@property (nonatomic ,copy)NSString *update_time;
@property (nonatomic ,strong)NSDictionary *author;
@property (nonatomic ,copy)NSString *attention_users;
@property (nonatomic ,strong)NSDictionary *dynamic;
@property (nonatomic ,strong)NSString *desc;
@property (nonatomic ,strong)NSString *attention_type;
+ (instancetype)publickModeCellWithDic:(NSDictionary *)dic;
@end
