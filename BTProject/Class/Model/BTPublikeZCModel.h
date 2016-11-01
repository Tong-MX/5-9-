//
//  BTPublikeZCModel.h
//  BTProject
//
//  Created by 明桐的Mac on 16/5/7.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//
/*"id": "4",
 "name": "穷三代的耳机中毒史",
 "pic1": "http://7xiwnz.com2.z0.glb.qiniucdn.com/post_group1/201512/55545699.jpg?v=1450426823",
 "pic2": "http://7xiwnz.com2.z0.glb.qiniucdn.com/post_group2/201512/56545598.jpg?v=1450426952",
 "pic3": "http://7xiwnz.com2.z0.glb.qiniucdn.com/post_group3/201512/99995351.jpg?v=1450172412",
 "create_time": "1457940648",
 "update_time": "1457940648",
 "author": {
 "user_id": "8",
 "nickname": "立马电动车",
 "avatar": "http://7te7t9.com2.z0.glb.qiniucdn.com/000/00/00/08.jpg?v=1440059105",
 "is_official": 0
 },
 "attention_users"
 "dynamic"
 
 */
#import "BaseModel.h"

@interface BTPublikeZCModel : BaseModel
@property (nonatomic ,copy)NSString *id;
@property (nonatomic ,copy)NSString *name;
@property (nonatomic ,copy)NSString *pic1;
@property (nonatomic ,copy)NSString *pic2;
@property (nonatomic ,copy)NSString *pic3;
@property (nonatomic ,copy)NSString *create_time;
@property (nonatomic ,copy)NSString *update_time;
@property (nonatomic ,strong)NSDictionary *author;
@property (nonatomic ,strong)NSArray *attention_users;
@property (nonatomic ,strong)NSDictionary *dynamic;
@property (nonatomic ,strong)NSString *desc;
@property (nonatomic ,strong)NSNumber *attention_type;
@property (nonatomic ,strong)NSString *share_url;
+ (instancetype)publickZCModeCellWithDic:(NSDictionary *)dic;
@end
