//
//  BTNetWorkPublicGet.h
//  BTProject
//
//  Created by 明桐的Mac on 16/4/15.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//
/*"status": 1,
 "msg": "ok",
 "ts": 1460706838,
 "data":
 h1ttp://open3.bantangapp.com/community/post/communityHome?app_installtime=1459390844.975536&app_versions=5.3.4&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&device_token=007f7c84f330760c549384c4724b091b8982c19ec2fbb85ac6f74c937e299c41&os_versions=8.4&screensize=640&track_device_info=iPhone5%2C2&track_deviceid=DE7C57F4-6D0E-438F-97CA-AB60BDB89382&v=10
 http://open3.bantangapp.com/community/post/communityHome?app_installtime=1460709371.233100&app_versions=5.3.5&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&device_token=0&oauth_token=0&os_versions=9.2&page=0&pagesize=20&screensize=667.000000&track_device_info=iPhone5.1%2C2&track_deviceid=0&track_user_id=0&v=10

 rec_groups cell的数据
 "module_elements"热门推荐 arr[
                            {
                                 "id": "26",
                                 "title": "热门推荐",
                                 "elements":[
                                             {
                                             "id": "469",
                                             "title": "手机控",
                                             "sub_title": "15952人气",
                                             "type": "post_list_element",
                                             "topic_type": "",
                                             "photo": "http://7xiwnz.com2.z0.glb.qiniucdn.com/element1/201512/49575548.jpg?v=1450427393",
                                             "extend": "469",
                                             "index": 100
                                             }
                                            ]
 
                            }
 ]
 */
#import "BTNetProtoBase.h"

@interface BTNetWorkPublicGet : BTNetProtoBase
@property (nonatomic ,assign)NSInteger status;
@property (nonatomic ,strong)NSString  *msg;
@property (nonatomic ,strong)NSDictionary *data;
@property (nonatomic ,strong)NSMutableArray *recGroupsArr;


@property (nonatomic ,strong)NSMutableArray *moduleElementsArr;
@property (nonatomic ,strong)NSDictionary *moduleTitleDic;
@property (nonatomic ,strong)NSMutableArray *publickModEleArr;
@property (nonatomic ,strong)NSMutableArray *publickHeadTitelArr;
@property (nonatomic ,strong)NSMutableArray *recGroupsMutable;
@property (nonatomic ,strong)NSMutableArray *elementsMutable;
- (void)getHomelistWithOs_versions :(NSString*)os_versions ScreenSize:(CGFloat)screensize TRACK_device_info:(NSString*)track_device_info netReachabilityType:(BTNetProtoBaseBlock)netReachabilityType;
@end
