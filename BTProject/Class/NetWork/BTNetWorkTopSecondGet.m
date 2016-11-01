//
//  BTNetWorkTopSecondGet.m
//  BTProject
//
//  Created by 明桐的Mac on 16/4/4.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTNetWorkTopSecondGet.h"
#import "BTtopicModel.h"
@interface BTNetWorkTopSecondGet()
@property (nonatomic,strong)NSDictionary *data;
@property (nonatomic,strong)NSMutableArray *topicArr;

@end
@implementation BTNetWorkTopSecondGet
- (void)getHomelistWithOs_versions :(NSString*)os_versions ScreenSize:(CGFloat)screensize TRACK_device_info:(NSString*)track_device_info IDS:(NSString *)ids PAGE:(NSInteger)page UpDateTime:(NSInteger)updateTime netReachabilityType:(BTNetProtoBaseBlock)netReachabilityType {
    
    NSInteger pageSize = 20;
    //iPhone Simulator
    NSDate *now = [NSDate date];
    CGFloat app_installtime = [now timeIntervalSince1970];
    
    if ([track_device_info isEqualToString:@"iPhone Simulator"]) {
        
        track_device_info = @"iPhone5.1";
    }
    //    track_device_info = @"";
    track_device_info = [NSString stringWithFormat:@"%@%@",track_device_info,Device_info];
//    h1ttp://open3.bantangapp.com/topic/list?app_installtime=1459390844.975536&app_versions=5.3.4&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&device_token=007f7c84f330760c549384c4724b091b8982c19ec2fbb85ac6f74c937e299c41&ids=2407%2C2555%2C2416%2C2472%2C2463%2C2511%2C2311%2C2526%2C2456%2C2436%2C2448&os_versions=8.4&page=0&pagesize=20&screensize=640&track_device_info=iPhone5%2C2&track_deviceid=DE7C57F4-6D0E-438F-97CA-AB60BDB89382&v=10
     
    
//http://open3.bantangapp.com/topic/list?app_installtime=1460476961.007892&app_versions=5.3.5&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&device_token=0&ids=2407%2C2285%2C2416%2C2472%2C2433%2C2511%2C2526%2C2311%2C2456%2C2439&os_versions=9.2&page=0&pagesize=20&screensize=667.000000&track_device_info=iPhone5.1%2C2&track_deviceid=0&v=10
    
//http://open3.bantangapp.com/topic/list?app_installtime=1459390844.975536&app_versions=5.3.4&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&device_token=007f7c84f330760c549384c4724b091b8982c19ec2fbb85ac6f74c937e299c41&ids=2533%2C2487%2C2469%2C1428%2C1736%2C1645%2C1993%2C1833%2C1743%2C1881%2C1657%2C1806%2C2154%2C1413%2C1706%2C1793%2C1564%2C1246%2C2001%2C2091%2C1560%2C1959%2C1594&os_versions=8.4&page=1&pagesize=20&screensize=640&track_device_info=iPhone5%2C2&track_deviceid=DE7C57F4-6D0E-438F-97CA-AB60BDB89382&update_time=1449478802&v=10
//    http://open3.bantangapp.com/topic/list?app_installtime=1459390844.975536&app_versions=5.3.4&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&device_token=007f7c84f330760c549384c4724b091b8982c19ec2fbb85ac6f74c937e299c41&ids=2533%2C2487%2C2469%2C1428%2C1736%2C1645%2C1993%2C1833%2C1743%2C1881%2C1657%2C1806%2C2154%2C1413%2C1706%2C1793%2C1564%2C1246%2C2001%2C2091%2C1560%2C1959%2C1594&os_versions=8.4&page=1&pagesize=20&screensize=640&track_device_info=iPhone5%2C2&track_deviceid=DE7C57F4-6D0E-438F-97CA-AB60BDB89382&update_time=1449478802&v=10
    NSString *url = [NSString stringWithFormat:@"%@?app_installtime=%f&app_versions=%@&channel_name=%@&client_id=%@&client_secret=%@&device_token=%@&ids=%@&os_versions=%@&page=%ld&pagesize=%ld&screensize=%f&track_device_info=%@&track_deviceid=%@&update_time=%ld&v=%@",URL_GETOP,app_installtime,app_versions,channel_name,client_id,client_secret,device_token,ids,os_versions,(long)page,(long)pageSize,screensize,track_device_info,track_deviceid,updateTime,v];
    
    __weak BTNetWorkTopSecondGet *weakSelf = self;
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
