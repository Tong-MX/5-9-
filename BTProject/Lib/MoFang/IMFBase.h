/*
 * Document please see: http://www.imofan.com/docs/doc_ios_guide.jsp
 */
#import <Foundation/Foundation.h>

@interface IMFBase : NSObject

#pragma mark -
#pragma mark Test only, do not use in product environment
+(void)setCollectorServer:(NSString *)collectorServer;

#pragma mark -
#pragma mark Config mofang
+(void)setLogEnabled:(BOOL)logEnabled;
+(void)setSendWiFiOnly:(BOOL)sendWiFiOnly;
+(void)setCrashReportEnabled:(BOOL)crashReportEnabled;
+(void)setOnlineConfigEnabled:(BOOL)onlineConfigEnabled;
+(void)setOnlineUpdateEnabled:(BOOL)onlineUpdateEnabled;


#pragma mark -
#pragma mark Startup mofang
+(void)startWithAppKey:(NSString *)appKey;
+(void)startWithAppKey:(NSString *)appKey channel:(NSString *)channel;

#pragma mark -
#pragma mark get OPENUDID & TOKEN
+(NSString *)getOpenUDID;
+(NSString *)getPushToken;
+(NSString *)getDevId;

#pragma mark -
#pragma mark User define event
+(void)event:(NSString *)eventKey;
+(void)event:(NSString *)eventKey tag:(NSString *)tag;


#pragma mark -
#pragma mark Page and path analyze
+(void)enterPage:(NSString *)pageName;


#pragma mark -
#pragma mark Get online config
+(id)getOnlineConfig;
+(id)getOnlineConfig:(NSString *)key;


#pragma mark -
#pragma mark User feedback
+(BOOL)submitFeedback:(NSString *)content userInfo:(NSString *)userInfo;
+(NSArray *)getFeedbacks;


#pragma mark -
#pragma mark Base push
+(void)setNotificationToken:(NSData *)deviceToken;
+(void)openAppWithPushNotificationFlag:(NSString *)flag;

#pragma mark - 网速测试
+ (void)connectionUrl:(NSString *)url httpCode:(NSInteger)httpCode response:(NSURLResponse *)response;
+ (void)connectionDidFinishLoading:(NSString *)url contentSize:(NSUInteger)contentSize;
+ (void)connectionUrl:(NSString *)url didFailWithError:(NSError *)error contentSize:(NSUInteger)contentSize;

#pragma mark - 应用状态更改
+ (BOOL)appInPublish;
+ (void)setAppVersion:(NSString *)appVersion isPublish:(BOOL)isPublish;

@end
