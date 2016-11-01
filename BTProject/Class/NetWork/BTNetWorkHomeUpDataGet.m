//
//  BTNetWorkHomeUpDataGet.m
//  BTProject
//
//  Created by 明桐的Mac on 16/4/10.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTNetWorkHomeUpDataGet.h"
#import "BTtopicModel.h"
@interface BTNetWorkHomeUpDataGet()
@property (nonatomic,strong)NSDictionary *data;
@property (nonatomic,strong)NSMutableArray *topicArr;
@end
@implementation BTNetWorkHomeUpDataGet
- (void)getHomelistWithOs_versions :(NSString*)os_versions ScreenSize:(CGFloat)screensize TRACK_device_info:(NSString*)track_device_info Page:(NSInteger)page UPData :(CGFloat)updataTime netReachabilityType:(BTNetProtoBaseBlock)netReachabilityType{
    
    NSInteger pageSize = 20;
    
    //iPhone Simulator
    NSDate *now = [NSDate date];
    CGFloat app_installtime = [now timeIntervalSince1970];
    
    if ([track_device_info isEqualToString:@"iPhone Simulator"]) {
        
        track_device_info = @"iPhone5.1";
    }
    //    track_device_info = @"";
    track_device_info = [NSString stringWithFormat:@"%@%@",track_device_info,Device_info];
//    updataTime = app_installtime - 48 * 60 *60;
    NSString *url = [NSString stringWithFormat:@"%@?app_installtime=%f&app_versions=%@&channel_name=%@&client_id=%@&client_secret=%@&device_token=%@&os_versions=%@&page=%ld&pagesize=%ld&screensize=%f&track_device_info=%@&track_deviceid=%@&update_time=%f&v=%@",URL_GETRecommend,app_installtime,app_versions,channel_name,client_id,client_secret,device_token,os_versions,(long)page,(long)pageSize,screensize,track_device_info,track_deviceid,updataTime,v];
    
    __weak BTNetWorkHomeUpDataGet *weakSelf = self;
    
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
