//
//  AppDelegate.m
//  BTProject
//
//  Created by 明桐的Mac on 16/3/16.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "AppDelegate.h"
#import "BTTabarController.h"
#import "BTAdfaViewController.h"
#import "MBProgressHUD.h"
#import "AFHTTPRequestOperationManager.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开发平台
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信
#import "WXApi.h"

#import "WeiboSDK.h"
@interface AppDelegate ()
@property (nonatomic, strong) NSData *deviceTokenData;
@property (strong) MBProgressHUD *appProgressHUD;
@property (strong, nonatomic) AFHTTPRequestOperationManager *manager;
@property (nonatomic, strong)BTTabarController *controller;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if (HKDebug == 1) {
        [self getPushNotification: application];
        [self initRequestData];
        [self checkNetStatus];
        [self delNotification];
    }else {
        if ([BTCommonUtil deviceID] > RES_dev_iphone_4) {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
            [BTPreferences setJLSaveWithIsSave:NO];
            [self checkNetStatus];
            self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            BTAdfaViewController *controller = [[BTAdfaViewController alloc] init];
            self.nvigationController = [[BaseNavigationController alloc] init];
            controller.adfaBlock = ^(){
                [self performSelector:@selector(delNotification) withObject:@"me" afterDelay:1.f];
            };
            self.window.rootViewController = controller;
            self.window.backgroundColor = [UIColor whiteColor];
            [self.window makeKeyAndVisible];
            
            [self getPushNotification: application];
            [self initRequestData];
            [self checkNetStatus];
            //    [NSThread sleepForTimeInterval:1.0];//线程睡眠1秒
            //    [self shareSDKCreat];
        }else {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"此程序只支持iPhone4以上设备感觉升级自己的iPhone吧"] delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    

    return YES;
}

- (void)delNotification {
    BTTabarController *controller = [[BTTabarController alloc] init];
    self.nvigationController = [[BaseNavigationController alloc] init];
    self.nvigationController.navigationBarHidden = YES;
    [self.nvigationController pushViewController: controller animated: NO];
    
    self.window.rootViewController = _nvigationController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}
- (void)shareSDKCreat {
    [ShareSDK registerApp:ShareSDKKey
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeMail),
                            @(SSDKPlatformTypeSMS),
                            @(SSDKPlatformTypeCopy),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),
                            @(SSDKPlatformTypeRenren),
                            @(SSDKPlatformTypeGooglePlus)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"2415883628"
                                           appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                         redirectUri:@"http://www.sharesdk.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx85655969a0936898"
                                       appSecret:@"64020361b8ec4c99936c0e3999a9f249"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1101065682"
                                  appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                    authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
     }];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [BTPreferences setJLSaveWithIsSave:NO];
}
#define HKSysIos8 8.0
- (void)getPushNotification: (UIApplication *)application {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= HKSysIos8) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    
    application.applicationIconBadgeNumber = 0;
}
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    self.deviceTokenData = deviceToken;

    NSLog(@"%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@"" withString:@""]);

}

+ (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication]delegate];
}

- (void)showComplete: (NSString *)msg Time: (CGFloat)time {
    if (_appProgressHUD == nil) {
        _appProgressHUD = [[MBProgressHUD alloc] initWithView: self.window];
//        _appProgressHUD.color = UIColorC4;
        _appProgressHUD.minSize = CGSizeMake(HKUIScreenWidth/2-20, 30);
        _appProgressHUD.xOffset = 1.2;
        _appProgressHUD.yOffset = 1.2;
        _appProgressHUD.margin = 10;
        _appProgressHUD.cornerRadius = 20;
        _appProgressHUD.mode = MBProgressHUDModeCustomView;
        _appProgressHUD.labelFont = UISystemFontT8;

        
        [self.window addSubview: _appProgressHUD];
        [_appProgressHUD setTag: 100];
        [self.window bringSubviewToFront: _appProgressHUD];
    }
    _appProgressHUD.labelText = msg;
    [_appProgressHUD show: YES];
    [_appProgressHUD hide: YES afterDelay: time];
}

- (void)initRequestData {
    
    NSURL *baseURL = [NSURL URLWithString:URL_NET_REACHABILITY];
    self.manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];

}
- (void)checkNetStatus{
    [self.manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        [BTCommonUtil setNetWorkStatus: (NetworkStatus)status];
        
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                //[self needUpNetData];
//                [self recordDataOpration];
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                //[self needUpNetData];
                [self recordDataOpration];
//                [self backLogin];
                break;
            }
            case AFNetworkReachabilityStatusNotReachable:{
                
                break;
            }
            case AFNetworkReachabilityStatusUnknown:{
                
                break;
            }
            default:{
                
            }
        }
    }];
    
    [self.manager.reachabilityManager startMonitoring];
}

- (void)recordDataOpration {
//    [[HKDataApi shareInstance] deleteRecord];
//    [[HKDataApi shareInstance] backupRecord];
//    [[HKDataApi shareInstance] uploadFile];
}
@end
