//
//  BTtopicModel.h
//  BTProject
//
//  Created by 明桐的Mac on 16/3/28.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//
/*"id": "2469",
 "title": "「鸡汤」其实都是从生活中学来的",
 "type": "",
 "pic": "http://bt.img.17gwx.com/topic/0/24/cFVYbQ/620x330",
 "is_show_like": true,
 "islike": false,
 "likes": "9237",
 "update_time": "1459069201"
 */
#import "BaseModel.h"

@interface BTtopicModel : BaseModel
@property (nonatomic ,strong)NSString *id;
@property (nonatomic ,strong)NSString *title;
@property (nonatomic ,strong)NSString *type;
@property (nonatomic ,strong)NSString *pic;
@property (nonatomic ,strong)NSString *is_show_like;
@property (nonatomic ,strong)NSString *islike;
@property (nonatomic ,strong)NSString *likes;
@property (nonatomic ,assign)NSDictionary *user;
@property (nonatomic ,assign)NSTimeInterval update_time;
+ (instancetype)TopWithDic:(NSDictionary *)dic;

@end
