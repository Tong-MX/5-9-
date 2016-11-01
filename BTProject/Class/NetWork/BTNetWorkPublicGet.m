//
//  BTNetWorkPublicGet.m
//  BTProject
//
//  Created by 明桐的Mac on 16/4/15.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTNetWorkPublicGet.h"
#import "BTPublicModel.h"
#import "BTPublickModEleModel.h"
#import "BTPublicCellModel.h"
@interface BTNetWorkPublicGet ()
@property (nonatomic ,strong)NSMutableArray *elementsArr;
@end
@implementation BTNetWorkPublicGet

- (void)getHomelistWithOs_versions :(NSString*)os_versions ScreenSize:(CGFloat)screensize TRACK_device_info:(NSString*)track_device_info netReachabilityType:(BTNetProtoBaseBlock)netReachabilityType {
    //iPhone Simulator
    NSDate *now = [NSDate date];
    CGFloat app_installtime = [now timeIntervalSince1970];
    
    if ([track_device_info isEqualToString:@"iPhone Simulator"]) {
        
        track_device_info = @"iPhone5.1";
    }
    //    track_device_info = @"";
    track_device_info = [NSString stringWithFormat:@"%@%@",track_device_info,Device_info];
    
    NSString *url = [NSString stringWithFormat:@"%@?app_installtime=%f&app_versions=%@&channel_name=%@&client_id=%@&client_secret=%@&os_versions=%@&screensize=%lf&track_device_info=%@&track_deviceid=%@&v=%@",URL_GETPCOMMUNTIY,app_installtime,app_versions,channel_name,client_id,client_secret,os_versions,screensize,track_device_info,track_deviceid,v];
    
    self.publickModEleArr = [NSMutableArray array];
    self.elementsMutable = [NSMutableArray array];
    self.elementsArr = [NSMutableArray array];
    self.recGroupsArr = [NSMutableArray array];
    self.recGroupsMutable = [NSMutableArray array];
    __weak BTNetWorkPublicGet *weakSelf = self;
    [[BTNetEngine shareInstance] getDataFromUrlString:url dataBlock:^(id dic, BTNetReachabilityType reachabilityType) {
        
        NSDictionary *originalDictionaryData = (NSDictionary *)dic;
        weakSelf.status = [originalDictionaryData[@"status"] integerValue];
        if (weakSelf.status == 1) {
            
            weakSelf.msg = originalDictionaryData[@"msg"];
            weakSelf.data = originalDictionaryData[@"data"];
            
            weakSelf.moduleElementsArr =  weakSelf.data[@"module_elements"];
            weakSelf.recGroupsArr = weakSelf.data[@"rec_groups"];
            [weakSelf.moduleElementsArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                BTPublickModEleModel *model = [BTPublickModEleModel publickModEleWithDic:obj];
                [weakSelf.publickModEleArr addObject:model];
            }];
            
            [weakSelf.recGroupsArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                BTPublicCellModel *model = [BTPublicCellModel publickModeCellWithDic:obj];
                [weakSelf.recGroupsMutable addObject:model];
            }];
        }
        netReachabilityType(reachabilityType);
    }];

}

@end
