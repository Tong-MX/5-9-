//
//  BTshoppingModel.h
//  BTProject
//
//  Created by 明桐的Mac on 16/4/30.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
/*{
 "id": "172512",
 "topic_id": "2695",
 "category": 3,
 "title": "发泄趣味人面球",
 "desc": "最近笑容不见了、压力好沉重，献给烦恼中的你！紧紧握住不放的手感，让你不知不觉忘了时间的流逝，轻软的材质，配合四种滑稽表情，随心情去捏揉，看到被蹂躏的小脸蛋，不好的心情烟灰云散，不玩的时候也是不错的摆设，让装饰带有趣味。",
 "price": "15.2",
 "url": "http://s.click.taobao.com/t?e=m%3D2%26s%3DNxJYfBo%2FCdBw4vFB6t2Z2ueEDrYVVa64XoO8tOebS%2BdRAdhuF14FMRIroiLeROEZt4hWD5k2kjMSCaKErieudzDk0PPeYwvvyUPcP7QvvKoJYf%2Fg8IP1YmPJLBziAmVvWeJ9HtN6q5JVvIW9BvrxNcFYPL%2BbxJbgL%2BjF7ADwwNz7DAab21jViaMvFjlHsztWqF5C3YBvjtQ9peD8rCcfzw%3D%3D&unid=bantangapp",
 "iscomments": false,
 "comments": "",
 "islike": false,
 "likes": "334",
 "item_id": "20296903321",
 "platform": "1",
 "pic": [
 {
 "p": "product1/17/25/c1ZcYVBc/w600",
 "w": 900,
 "h": 900
 },
 {
 "p": "product2/17/25/c1ZcYVBc/w600",
 "w": 900,
 "h": 900
 }
 ],
 "likes_list": [
 {
 "u": 589338,
 "a": "000/58/93/38.jpg"
 },
 {
 "u": 841412,
 "a": "000/84/14/12.jpg"
 },
 {
 "u": 1795172,
 "a": "001/79/51/72.jpg"
 },
 {
 "u": 1415581,
 "a": "001/41/55/81.jpg"
 },
 {
 "u": 13232,
 "a": "000/01/32/32.jpg"
 },
 {
 "u": 1241003,
 "a": "001/24/10/03.jpg"
 },
 {
 "u": 231291,
 "a": "000/23/12/91.jpg"
 },
 {
 "u": 1762690,
 "a": "001/76/26/90.jpg"
 },
 {
 "u": 1128651,
 "a": "001/12/86/51.jpg"
 },
 {
 "u": 1904213,
 "a": "001/90/42/13.jpg"
 }
 ]
 }
*/
#import "BaseModel.h"

@interface BTshoppingModel : BaseModel
@property (nonatomic ,strong)NSString *id;
@property (nonatomic ,strong)NSString *topic_id;
@property (nonatomic ,strong)NSString *category;
@property (nonatomic ,strong)NSString *title;
@property (nonatomic ,strong)NSString *desc;
@property (nonatomic ,strong)NSString *price;
@property (nonatomic ,strong)NSString *url;
@property (nonatomic ,strong)NSString *iscomments;
@property (nonatomic ,strong)NSString *comments;
@property (nonatomic ,strong)NSString *product_pic_host;
@property (nonatomic ,strong)NSString *user_avatr_host;
@property (nonatomic ,strong)NSString *islike;
@property (nonatomic ,strong)NSString *likes;
@property (nonatomic ,strong)NSString *item_id;
@property (nonatomic ,strong)NSString *platform;
@property (nonatomic ,strong)NSArray *likes_list;
@property (nonatomic ,strong)NSMutableArray *pic;
+ (instancetype)ShoppWithDic:(NSDictionary *)dic;
@end
