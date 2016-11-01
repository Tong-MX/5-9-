//
//  NetWorkHomeGet.m
//  BTProject
//
//  Created by 明桐的Mac on 16/3/23.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTNetWorkHomeGet.h"
#import "BTNetEngine.h"
#import "BTHomeModel.h"
#import "BTBannerbottomModel.h"
#import "BTcategoryModel.h"
#import "BTtopicModel.h"
@implementation BTNetWorkHomeGet

- (void)getHomelistWithOs_versions :(NSString*)os_versions ScreenSize:(CGFloat)screensize TRACK_device_info:(NSString*)track_device_info netReachabilityType:(BTNetProtoBaseBlock)netReachabilityType {
    NSInteger page = 0;
    NSInteger pageSize = 20;

    //iPhone Simulator
    NSDate *now = [NSDate date];
    CGFloat app_installtime = [now timeIntervalSince1970];
    
    if ([track_device_info isEqualToString:@"iPhone Simulator"]) {
        
        track_device_info = @"iPhone5.1";
    }
    track_device_info = [NSString stringWithFormat:@"%@%@",track_device_info,Device_info];

    NSString *url = [NSString stringWithFormat:@"%@?app_installtime=%f&app_versions=%@&channel_name=%@&client_id=%@&client_secret=%@&device_token=%@&oauth_token=%@&os_versions=%@&page=%ld&pagesize=%ld&screensize=%f&track_device_info=%@&track_deviceid=%@&track_user_id=%@&v=%@",URL_GETRecommend,app_installtime,app_versions,channel_name,client_id,client_secret,device_token,oauth_token,os_versions,(long)page,(long)pageSize,screensize,track_device_info,track_deviceid,track_user_id,v];

    __weak BTNetWorkHomeGet *weakSelf = self;
    [[BTNetEngine shareInstance] getDataFromUrlString:url dataBlock:^(id dic, BTNetReachabilityType reachabilityType) {
        
        NSDictionary *originalDictionaryData = (NSDictionary *)dic;
        
        weakSelf.status = [originalDictionaryData[@"status"] integerValue];
        if (weakSelf.status == 1) {
            
            weakSelf.msg = originalDictionaryData[@"msg"];
            weakSelf.data = originalDictionaryData[@"data"];
            
            weakSelf.banner = weakSelf.data[@"banner"];
            weakSelf.banner_bottom_element = weakSelf.data[@"banner_bottom_element"];
            weakSelf.category_element = weakSelf.data[@"category_element"];
            weakSelf.firstpage = weakSelf.data[@"firstpage_element"];
            weakSelf.topic = weakSelf.data[@"topic"];

            weakSelf.bannerArray = [NSMutableArray array];
            weakSelf.category_elementArray = [NSMutableArray array];
            weakSelf.topicArray = [NSMutableArray array];
            weakSelf.banner_bottom_elementArray = [NSMutableArray array];
            weakSelf.firstpageArray = [NSMutableArray array];
            
            for (int i = 0; i < weakSelf.topic.count; i++) {
                
                if (weakSelf.banner.count > i) {
                    
                    NSDictionary *bannerDic = weakSelf.banner[i];
                    
                    BTHomeModel *homeMdel = [BTHomeModel HomeWithDic:bannerDic];
                    [weakSelf.bannerArray addObject:homeMdel];
                    
                }
                
                if (weakSelf.banner_bottom_element.count > i) {
                    
                    NSDictionary *banner_bottom_elementDic = weakSelf.banner_bottom_element[i];
                    
                    BTHomeModel *banner_bottomModel = [BTHomeModel HomeWithDic:banner_bottom_elementDic];
                    
                    [weakSelf.banner_bottom_elementArray addObject:banner_bottomModel];
                    
                }
                if (weakSelf.category_element.count > i) {
                    
                    NSDictionary *category_elementDic = weakSelf.category_element[i];
                    BTHomeModel *categoryModel = [BTHomeModel HomeWithDic:category_elementDic];
                    [weakSelf.category_elementArray addObject:categoryModel
                     ];
                }

                if (weakSelf.topic.count > i) {
                    
                    NSDictionary *topicDic = weakSelf.topic[i];
                    BTtopicModel *topicModel = [BTtopicModel TopWithDic:topicDic];
                    [weakSelf.topicArray addObject:topicModel];
                }
                if (weakSelf.firstpage.count > i) {
                    
                    NSDictionary *firstPageDic = weakSelf.firstpage[i];
                    BTHomeModel *firstPageModel = [BTHomeModel HomeWithDic:firstPageDic];
                    [weakSelf.firstpageArray addObject:firstPageModel];
                }
                
            }
            
        }
        netReachabilityType(reachabilityType);
    }];
    
    
}
@end
