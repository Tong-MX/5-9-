//
//  IMFExt.h
//  IMFSDK1.0
//
//  Created by 陈 小虎 on 12-7-31.
//  Copyright (c) 2012年 太平洋网络. All rights reserved.
//

@interface IMFExt

+ (void) setExtendServerURL:(NSString *)extendServerURL;

+ (void) setNotificationReceiveTime:(NSString *)receiveTime;
+ (void) setNotificationReceiveType:(UIRemoteNotificationType)receiveType;

+ (void) setNotificationExtendField:(NSString *)name 
                          withValue:(NSString *)value;

/*
 本功能已经取消
 + (void) extendEvent:(NSString *)eventKey 
 object:(NSString *)object 
 step:(NSString *)step 
 duration:(NSTimeInterval)duration;
 */

+ (void) action:(NSString *)actionKey
         target:(NSString *)target;

+ (void) action:(NSString *)actionKey
         target:(NSString *)target
       duration:(NSTimeInterval)seconds;

/*
 发送自定义消息到扩展服务器
 没有限制的数据结构，根须自己实际需要使用，服务端要自己处理收到的JSON消息
 headers设置需要发送到基本信息，数组中给出信息名称，SDK会自动填充值，
 名称可包括：
 mac_addr, resolution, model, install_date, channel, sdk_ver, app_ver,
 os_ver, carrier, jailbroken, country, timezone, language, apns
 */

+ (void) sendMessage:(NSDictionary *)body
             headers:(NSArray *)headers;

@end
