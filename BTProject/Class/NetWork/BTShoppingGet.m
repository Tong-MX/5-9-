//
//  BTShoppingGet.m
//  BTProject
//
//  Created by 明桐的Mac on 16/4/30.
//  Copyright © 2016年 小谩的Mac. All rights reserved.

#import "BTShoppingGet.h"
#import "BTshoppingModel.h"
@implementation BTShoppingGet

- (void)getShoppingListWithOs_versions :(NSString*)os_versions ScreenSize:(CGFloat)screensize TRACK_device_info:(NSString*)track_device_info SID:(NSString*)sid netReachabilityType:(BTNetProtoBaseBlock)netReachabilityType {
    NSDate *now = [NSDate date];
    CGFloat app_installtime = [now timeIntervalSince1970];
    
    if ([track_device_info isEqualToString:@"iPhone Simulator"]) {
        
        track_device_info = @"iPhone5.1";
    }
    track_device_info = [NSString stringWithFormat:@"%@%@",track_device_info,Device_info];
//h1ttp://open3.bantangapp.com/topic/newInfo?app_installtime=1459390844.975536&app_versions=5.3.4&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&device_token=007f7c84f330760c549384c4724b091b8982c19ec2fbb85ac6f74c937e299c41&id=2752&os_versions=8.4&screensize=640&statistics_uv=1&track_device_info=iPhone5%2C2&track_deviceid=DE7C57F4-6D0E-438F-97CA-AB60BDB89382&v=10
//h1ttp://open3.bantangapp.com/topic/newInfo?app_installtime=1462006755.045139&app_versions=5.3.5&channel_name=appStore&client_id=bt_app_ios&client_secret=9c1e6634ce1c5098e056628cd66a17a5&device_token=0&id=2754&os_versions=9.2&screensize=667.000000&statistics_uv=1&track_device_info=iPhone5.1%2C2&track_deviceid=DE7C57F4-6D0E-438F-97CA-AB60BDB89382&v=10

    NSString *url = [NSString stringWithFormat:@"%@?app_installtime=%f&app_versions=%@&channel_name=%@&client_id=%@&client_secret=%@&device_token=%@&id=%ld&os_versions=%@&screensize=%f&statistics_uv=%d&track_device_info=%@&track_deviceid=%@&v=%@",URL_GETSHOPIING,app_installtime,app_versions,channel_name,client_id,client_secret,device_token,[sid integerValue],os_versions,screensize,statistics_uv,track_device_info,track_deviceid,v];
    _productMtable = [NSMutableArray array];
    __weak BTShoppingGet *weakSelf = self;
    [[BTNetEngine shareInstance] getDataFromUrlString:url dataBlock:^(id dic, BTNetReachabilityType reachabilityType) {
        NSDictionary *originalDictionaryData = (NSDictionary *)dic;
        
        weakSelf.status = [originalDictionaryData[@"status"] integerValue];
        if (weakSelf.status == 1) {
            weakSelf.msg = originalDictionaryData[@"msg"];
            weakSelf.data = originalDictionaryData[@"data"];
            weakSelf.titleStr = weakSelf.data[@"title"];
            weakSelf.descStr = weakSelf.data[@"desc"];
            weakSelf.picUrl = weakSelf.data[@"pic"];
            weakSelf.productArr = weakSelf.data[@"product"];
            [weakSelf.productArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                BTshoppingModel *model = [BTshoppingModel ShoppWithDic:obj];
                [_productMtable addObject:model];
            }];
            
        }
        netReachabilityType(reachabilityType);
    }];
}
@end
