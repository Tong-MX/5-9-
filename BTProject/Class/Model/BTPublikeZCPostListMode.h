//
//  BTPublikeZCPostListMode.h
//  BTProject
//
//  Created by 明桐的Mac on 16/5/8.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//
/*"id": "112894",
 "content": "包装和做工都很不错，收纳盒有点意思，声音上偏流行风格，人声中性，略细，声音不刺激，听郭静，梁静茹，张信哲这样的很不错，声音粗犷深沉一些的像韩磊就比较一般了，这是刚开封初听的感觉",
 "author_id": "1919576",
 "relation_id": "165328",
 "share_url": "http://m.ibantang.com/post/detail/112894/",
 "is_recommend": "1",
 "create_time": "1457337146",
 "publish_time": "1457954027",
 "datetime": "1457954027",
 "datestr": "03-14 19:13",
 "mini_pic_url": "http://pic1.bantangapp.com/post/201603/07/579854987144_1919576_1.jpg!w200",
 "middle_pic_url": "http://pic1.bantangapp.com/post/201603/07/579854987144_1919576_1.jpg!w300",
 "tags":[]
 "author": {}
 "pics": []
 "dynamic": {}
  "product": []
 "comments": []
 */
#import "BaseModel.h"

@interface BTPublikeZCPostListMode : BaseModel
@property (nonatomic ,copy)NSString *id;
@property (nonatomic ,copy)NSString *content;
@property (nonatomic ,copy)NSString *author_id;
@property (nonatomic ,copy)NSString *relation_id;
@property (nonatomic ,copy)NSString *is_recommend;
@property (nonatomic ,copy)NSString *create_time;
@property (nonatomic ,copy)NSString *publish_time;
@property (nonatomic ,copy)NSString *datetime;
@property (nonatomic ,copy)NSString *datestr;
@property (nonatomic ,copy)NSString *mini_pic_url;
@property (nonatomic ,copy)NSString *middle_pic_url;
@property (nonatomic ,strong)NSArray *tags;
@property (nonatomic ,strong)NSDictionary *author;
@property (nonatomic ,strong)NSArray *pics;
@property (nonatomic ,strong)NSArray *product;
@property (nonatomic ,strong)NSDictionary *dynamic;
@property (nonatomic ,strong)NSString *share_url;
@property (nonatomic ,strong)NSArray *comments;
+ (instancetype)publickZCPostListModeCellWithDic:(NSDictionary *)dic;
@end

