//
//  BTNetEngine.h
//  BTProject
//
//  Created by 明桐的Mac on 16/3/24.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef enum {
    BTNetReachabilityTypeOK,//有网
    BTNetReachabilityTypeNotReachable,//无网络
    BTNetReachabilityTypeTimeOut,//网络超时
    BTNetReachabilityTypeUrlWrong,//网络连接中断
    
} BTNetReachabilityType;

typedef void (^BTNetEngineBlock)(id dic,BTNetReachabilityType reachabilityType);

@interface BTNetEngine : NSObject
+ (BTNetEngine *)shareInstance;
//get json
- (void)getDataFromUrlString:(NSString *) aUrlString dataBlock:(BTNetEngineBlock )aBlock;
- (void)getHtmlDataFromUrlString:(NSString *) aUrlString dataBlock:(BTNetEngineBlock )aBlock;
//post
- (void)postDataFromUrlString:(NSString *) aUrlString body:(NSDictionary *)parameters dataBlock:(BTNetEngineBlock )aBlock;
//delete
- (void)deleteDataFromUrlString:(NSString *) aUrlString body:(NSDictionary *)parameters dataBlock:(BTNetEngineBlock )aBlock;
//put
- (void)putDataFromUrlString:(NSString *) aUrlString body:(NSDictionary *)parameters dataBlock:(BTNetEngineBlock )aBlock;

@end
