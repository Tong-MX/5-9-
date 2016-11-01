//
//  BTNetEngine.m
//  BTProject
//
//  Created by 明桐的Mac on 16/3/24.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTNetEngine.h"

static BTNetEngine *singleModel = nil;
@implementation BTNetEngine

+ (BTNetEngine *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (nil == singleModel) {
            singleModel = [[BTNetEngine alloc]init];
        }
    });
    return singleModel;
}

#pragma mark get json
- (void)getDataFromUrlString:(NSString *) aUrlString dataBlock:(BTNetEngineBlock )aBlock{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //[HKLog trace: [NSString stringWithFormat: @"url:%@", aUrlString] Content: [NSString stringWithFormat: @"ssid = %@\ncommid = %@\nuid = %@", [HKPreferences getCommonSessionId], [HKPreferences geKummtCommonSessionId], [HKPreferences getUserId]]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [self addHeader:manager];
    
    [manager GET:aUrlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        aBlock(responseObject,BTNetReachabilityTypeOK);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        //[HKLog trace:nil Content:[NSString stringWithFormat:@"返回值：%@",(NSDictionary *)responseObject]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        MTLog(@"Error:%@", error);
        if (error.code == -1009) {//无网络
            MTLog(@"%@",error.localizedDescription);
            aBlock(nil,BTNetReachabilityTypeNotReachable);
            
        }else if (error.code == -1001){//网络超时
            MTLog(@"%@",error.localizedDescription);
            aBlock(nil,BTNetReachabilityTypeTimeOut);
            
        }else{
            aBlock(nil,BTNetReachabilityTypeUrlWrong);
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    }];
}

#pragma mark - get html
- (void)getHtmlDataFromUrlString:(NSString *) aUrlString dataBlock:(BTNetEngineBlock )aBlock{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [self addHeader:manager];
    
    [manager GET:aUrlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        aBlock(responseObject,BTNetReachabilityTypeOK);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        MTLog(@"Error:%@", error);
        if (error.code == -1009) {//无网络
            MTLog(@"%@",error.localizedDescription);
            aBlock(nil,BTNetReachabilityTypeNotReachable);
            
        }else if (error.code == -1001){//网络超时
            MTLog(@"%@",error.localizedDescription);
            aBlock(nil,BTNetReachabilityTypeTimeOut);
            
        }else{
            aBlock(nil,BTNetReachabilityTypeUrlWrong);
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    }];
}


#pragma mark post
- (void)postDataFromUrlString:(NSString *) aUrlString body:(NSDictionary *)parameters dataBlock:(BTNetEngineBlock )aBlock{
    
    //[HKLog trace: [NSString stringWithFormat: @"url:%@\n参数：%@",aUrlString,parameters] Content: [NSString stringWithFormat: @"ssid = %@\ncommid = %@\nuid = %@", [HKPreferences getCommonSessionId], [HKPreferences geKummtCommonSessionId], [HKPreferences getUserId]]];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [self addHeader:manager];
    
    [manager POST:aUrlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        aBlock(responseObject,BTNetReachabilityTypeOK);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        //        [HKLog trace:nil Content:[NSString stringWithFormat:@"返回值：%@",(NSDictionary *)responseObject]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        MTLog(@"Error:%@", error);
        if (error.code == -1009) {//无网络
            MTLog(@"%@",error.localizedDescription);
            aBlock(nil,BTNetReachabilityTypeNotReachable);
            
        }else if (error.code == -1001){//网络超时
            MTLog(@"%@",error.localizedDescription);
            aBlock(nil,BTNetReachabilityTypeTimeOut);
            
        }else{
            aBlock(nil,BTNetReachabilityTypeUrlWrong);
        }
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
    
}


#pragma mark delete
- (void)deleteDataFromUrlString:(NSString *) aUrlString body:(NSDictionary *)parameters dataBlock:(BTNetEngineBlock )aBlock{
    // [HKLog trace: [NSString stringWithFormat: @"url:%@\n参数：%@",aUrlString,parameters] Content: [NSString stringWithFormat: @"ssid = %@\ncommid = %@\nuid = %@", [HKPreferences getCommonSessionId], [HKPreferences geKummtCommonSessionId], [HKPreferences getUserId]]];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [self addHeader:manager];
    
    [manager DELETE:aUrlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        aBlock(responseObject,BTNetReachabilityTypeOK);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //        [HKLog trace:nil Content:[NSString stringWithFormat:@"返回值：%@",(NSDictionary *)responseObject]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        MTLog(@"Error:%@", error);
        if (error.code == -1009) {//无网络
            MTLog(@"%@",error.localizedDescription);
            aBlock(nil,BTNetReachabilityTypeNotReachable);
            
        }else if (error.code == -1001){//网络超时
            MTLog(@"%@",error.localizedDescription);
            aBlock(nil,BTNetReachabilityTypeTimeOut);
            
        }else{
            aBlock(nil,BTNetReachabilityTypeUrlWrong);
        }
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
    
}

#pragma mark put //---此协议未使用
- (void)putDataFromUrlString:(NSString *) aUrlString body:(NSDictionary *)parameters dataBlock:(BTNetEngineBlock )aBlock{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [self addHeader:manager];
    
    [manager PUT:aUrlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        aBlock(responseObject,BTNetReachabilityTypeOK);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        MTLog(@"Error:%@", error);
        if (error.code == -1009) {//无网络
            MTLog(@"%@",error.localizedDescription);
            aBlock(nil,BTNetReachabilityTypeNotReachable);
            
        }else if (error.code == -1001){//网络超时
            MTLog(@"%@",error.localizedDescription);
            aBlock(nil,BTNetReachabilityTypeTimeOut);
            
        }else{
            aBlock(nil,BTNetReachabilityTypeUrlWrong);
        }
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    }];
}

- (void)addHeader: (AFHTTPRequestOperationManager *)manager {
    if (!manager) {
        return;
    }
    
//    NSString *udid = [IMFBase getOpenUDID];
//    if (udid.length > 0) {
//        [manager.requestSerializer setValue:udid forHTTPHeaderField:@"Appsession"];
//    }
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    if (version.length > 0) {
        [manager.requestSerializer setValue:version forHTTPHeaderField:@"Version"];
    }
    
    NSString * appName = @"PCBABY_KLMM_IOS";
    
    if (appName.length > 0) {
        [manager.requestSerializer setValue:appName forHTTPHeaderField:@"App"];
    }
}

@end
