//
//  BTNetWorkTopOhterGet.m
//  BTProject
//
//  Created by 明桐的Mac on 16/4/8.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTNetWorkTopOhterGet.h"
#import "BTtopicModel.h"
@interface BTNetWorkTopOhterGet()
@property (nonatomic,strong)NSDictionary *data;
@property (nonatomic,strong)NSMutableArray *topicArr;
@end
@implementation BTNetWorkTopOhterGet
- (void)getTopHomelistWithOs_versions :(NSString*)os_versions ScreenSize:(CGFloat)screensize TRACK_device_info:(NSString*)track_device_info Scene:(NSInteger)scene netReachabilityType:(BTNetProtoBaseBlock)netReachabilityType{
    
    NSInteger page = 0;
    NSInteger pageSize = 20;
    
    //iPhone Simulator
    NSDate *now = [NSDate date];
    CGFloat app_installtime = [now timeIntervalSince1970];
    
    if ([track_device_info isEqualToString:@"iPhone Simulator"]) {
        
        track_device_info = @"iPhone5.1";
    }
    track_device_info = [NSString stringWithFormat:@"%@%@",track_device_info,Device_info];
//    http://open3.bantangapp.com/topic/list?app_installtime=1459390844.975536&app_versions=5.3.4&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&device_token=007f7c84f330760c549384c4724b091b8982c19ec2fbb85ac6f74c937e299c41&os_versions=8.4&page=0&pagesize=20&scene=16&screensize=640&track_device_info=iPhone5%2C2&track_deviceid=DE7C57F4-6D0E-438F-97CA-AB60BDB89382&v=10
    NSString *url = [NSString stringWithFormat:@"%@?app_installtime=%f&app_versions=%@&channel_name=%@&client_id=%@&client_secret=%@&device_token=%@&os_versions=%@&page=%ld&pagesize=%ld&scene=%ldscreensize=%f&track_device_info=%@&track_deviceid=%@&v=%@",URL_GETOP,app_installtime,app_versions,channel_name,client_id,client_secret,device_token,os_versions,(long)page,(long)pageSize,(long)scene,screensize,track_device_info,track_deviceid,v];
    
    __weak BTNetWorkTopOhterGet *weakSelf = self;
    
    [[BTNetEngine shareInstance] getDataFromUrlString:url dataBlock:^(id dic, BTNetReachabilityType reachabilityType) {
        
        NSDictionary *originalDictionaryData = (NSDictionary *)dic;
        
        weakSelf.status = [originalDictionaryData[@"status"] integerValue];
        if (weakSelf.status == 1) {
            
            weakSelf.msg = originalDictionaryData[@"msg"];
            weakSelf.data = originalDictionaryData[@"data"];
            weakSelf.topicArr = weakSelf.data[@"topic"];
            
            weakSelf.TopMutable = [NSMutableArray array];
            [weakSelf.topicArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSDictionary *topDic = obj;
                BTtopicModel *topModel = [BTtopicModel TopWithDic:topDic];
                
                [weakSelf.TopMutable addObject:topModel];
            }];
        }
        
        netReachabilityType(reachabilityType);
    }];
}
@end
