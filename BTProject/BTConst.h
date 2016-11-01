//
//  BTConst.h
//  BTProject
//
//  Created by 明桐的Mac on 16/3/22.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#ifndef BTConst_h
#define BTConst_h

#define HKDebug 1
#define HKSvn @"11705"
#define HKNotifyIsShowADFI @"HKNotifyIsShowADFI"  //是否显示idfa广告
#define HKNotifySaveImgToPhoto @"HKNotifySaveImgToPhoto" //保存图片到本地
#define HKSoftwateVersion [@"v1.5." stringByAppendingString: HKSvn]//软件版本
#define HKHarowareVersion @"v1.0"  //硬件版本
#define ShareSDKKey @"122f2bfe54aa0"
#define ShareSDKSecret @"60b6a4c1acd5578f20764d56324ec265"
#define ShareMessageKey @"122f3c7fa2226"
#define ShareMessageSecret @"7a228ce38266762a5cf60b4fb330a7e6"
#define HKDevice_5_h 568
#define HKDevice_h 480
#define HKDevice_6_h

#define HKDevice_6p_h 736.0

#define BTHomeDetails @"主页详情"

#ifdef DEBUG
#define MTLog(...) NSLog(__VA_ARGS__)
#else
#define MTLog(...)
#endif
#endif 

/* BTConst_h */
typedef enum {
    
    BTHomeVC,//首页Id
    BTMassingVC//信息也ID
    
}BTUIControllerID;
