//
//  BTNetWorkZCPost.m
//  BTProject
//
//  Created by 明桐的Mac on 16/5/7.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTNetWorkZCPost.h"
#import "BTPublikeZCModel.h"
#import "BTPublikeZCPostListMode.h"

@interface BTNetWorkZCPost ()
@property (nonatomic ,strong)NSDictionary *infor;
@end
@implementation BTNetWorkZCPost
- (void)postPublicZClistWithOs_versions :(NSString*)os_versions ScreenSize:(CGFloat)screensize TRACK_device_info:(NSString*)track_device_info GroupId:(NSInteger)groupId netReachabilityType:(BTNetProtoBaseBlock)netReachabilityType {
    //h1ttp://open3.bantangapp.com/community/group/info?app_installtime=1459390844.975536&app_versions=5.3.4&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&device_token=891ff5b7b38751c0144c082b6de788b3c04f57fcad4041f8bfa1a4b6efd5c7bf&group_id=4&os_versions=9.3&pagesize=10&screensize=750&track_device_info=iPhone8%2C1&track_deviceid=2BA5B241-3A06-447D-9F2D-9B48606FF850&type_id&v=10
    
    //h1ttp://open3.bantangapp.com/community/group/info?app_installtime=1462623038.166038&app_versions=5.3.5&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&device_token=0&group_id=0&os_versions=9.2&pagesize=10&screensize=667.000000&track_device_info=iPhone5.1%2C2&track_deviceid=DE7C57F4-6D0E-438F-97CA-AB60BDB89382&&type_id=1&v=10


    NSInteger pagesize = 10;
    NSInteger typeId = 1;
    CGFloat app_installtime = [self installTime];
    NSString *device = [self trackDeviceInfo:track_device_info];
    
    NSString *url = [NSString stringWithFormat:@"%@?app_installtime=%f&app_versions=%@&channel_name=%@&client_id=%@&client_secret=%@&device_token=%@&group_id=%ld&os_versions=%@&pagesize=%ld&screensize=%lf&track_device_info=%@&track_deviceid=%@&&type_id=%ld&v=%@",URL_POSTCOMMUNTIYZC,app_installtime,app_versions,channel_name,client_id,client_secret,device_token,groupId,os_versions,pagesize,screensize,device,track_deviceid,typeId,v];
    self.inforArr = [NSMutableArray array];
    self.postListArr = [NSMutableArray array];
    __weak BTNetWorkZCPost *weakSelf = self;
    [[BTNetEngine shareInstance] getDataFromUrlString:url dataBlock:^(id dic, BTNetReachabilityType reachabilityType) {
        NSDictionary *originalDictionaryData = (NSDictionary *)dic;
        weakSelf.status = [originalDictionaryData[@"status"] integerValue];
        if (weakSelf.status == 1) {
            weakSelf.msg = originalDictionaryData[@"msg"];
            weakSelf.data = originalDictionaryData[@"data"];
            weakSelf.infor = weakSelf.data[@"info"];
            BTPublikeZCModel *model = [BTPublikeZCModel publickZCModeCellWithDic:weakSelf.infor];
            [weakSelf.inforArr addObject:model];
            [weakSelf.data[@"post_list"]enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                BTPublikeZCPostListMode *listMode = [BTPublikeZCPostListMode publickZCPostListModeCellWithDic:obj];
                [weakSelf.postListArr addObject:listMode];                
            }];
        }
        netReachabilityType(reachabilityType);
    }];
}
@end
