//
//  BTNetProtoBase.h
//  BTProject
//
//  Created by 明桐的Mac on 16/3/23.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTNetEngine.h"

typedef void (^BTNetProtoBaseBlock)(BTNetReachabilityType reachabilityType);//netReachabilityType
typedef void (^BTNetSuccessBlock)();
typedef void (^BTNetFailBlock)();
@interface BTNetProtoBase : NSObject

+(BTNetProtoBase *)shareInstance;

#pragma mark 日期转化
- (NSString *)convertTimeIntervalToString:(float)timeInterval FormatterStr:(NSString *)formatterStr;
- (float)convertStringToTimeInterval:(NSString *)dateString FormatterStr:(NSString *)formatterStr;

#pragma mark 去html格式,返回二维数组，0存字符串，1存图片url
- (NSArray *)parseHTMLStrWithStr:(NSString *)str;

//返回时间
- (CGFloat)installTime;
//计算型号
- (NSString*)trackDeviceInfo:(NSString*)trackDeviceInfo;
@end
