//
//  BTResource.m
//  BTProject
//
//  Created by 明桐的Mac on 16/3/18.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTResource.h"
#import "sys/sysctl.h"
#define BasicTag @"ios设备信息"
@implementation BTResource

static CGFloat HKUScal = 1.20;

static int devId;
static CGSize devSize;
static NSString *devName;
static int recordStatus = -1;
static CGSize moreButtonSize;
static CGSize fdkSize;
static CGFloat fontSizeT1 = 125;
static CGFloat fontSizeT2 = 70;
static CGFloat fontSizeT3 = 60;
static CGFloat fontSizeT4 = 36;
static CGFloat fontSizeT5 = 30;
static CGFloat fontSizeT6 = 22.5;
static CGFloat fontSizeT7 = 20;
static CGFloat fontSizeT8 = 17.5;
static CGFloat fontSizeT9 = 16;
static CGFloat fontSizeT10 = 14;
static CGFloat fontSizeT11 = 12;
static CGFloat fontSizeT12 = 9;
static CGFloat fontSizeT13 = 11;

static CGFloat fontSizeT14 = 70;
static CGFloat fontSizeT14_1 = 57;
static CGFloat fontSizeT15 = 15;

static CGFloat fontSizeT16 = 40;

static CGFloat topStatusBarHeight = 20;
static CGFloat navigationBarHeight = 44;
static CGFloat scaleDownButtonSizeH = 40;
static CGFloat scaleDownButtonSizeW = 120;
#define kBottomBarHeight kScreenHeight_8

//main
static CGFloat mainHeadImgSize = 60;
static CGFloat mainTableTopMoveDis = 140;// 主界面上面滑动的时候滑到什么位置，上面不动
//main

//圈子，问答
static CGFloat circleSecondTopViewH = 90; //圈子二级界面顶端信息view的高
static CGFloat circleSecondAdvertViewH = 60;//圈子二级界面广告的高度
static CGFloat circleSecondViewToleftDis = 5;//圈子二级界面里面的view距离左侧边框的距离
static CGFloat circleSecondViewBorderWidth = 1.5;
static CGFloat circleSecondViewCornerRadius = 6;
static CGFloat topicListHeadImgSize = 50;
//圈子，问答

static CGFloat redRemindViewSize = 10;

+ (void)initDevId: (int)_devId DevSize: (CGSize)_devSize {
    devId = _devId;
    devSize = _devSize;
    
    if ([BTCommonUtil iphone6P]) {
        HKUScal = 1.06;
    }
    
    [BTLog trace: BasicTag Content: [NSString stringWithFormat: @"设备id号=%d", devId]];
    
    switch (devId) {
        case RES_dev_iphone_4:
        {
            mainHeadImgSize = 45;
            fontSizeT2 = 60;
            redRemindViewSize = 10;
        }
            break;
        case RES_dev_iphone_5:
        {
            mainHeadImgSize = 55;
            fontSizeT2 = 60;
        }
            break;
        case RES_dev_iphone_6:
        {
            
        }
            break;
        case RES_dev_iphone_6p:
        {
            
        }
            break;
        case RES_dev_ipad:
        {
            HKUScal = 0.6;
        }
            break;
        case RES_dev_ipad_mini:
        {
            
        }
            break;
        default: {
            [BTLog trace: BasicTag Content: @"没找到匹配的苹果设备"];
        }
            break;
    }
    
    if ([BTCommonUtil deviceID] == RES_dev_iphone_6 || [BTCommonUtil deviceID] == RES_dev_iphone_6p) {
        fontSizeT2 = 70;
    } else if ([BTCommonUtil deviceID] == RES_dev_iphone_5 || [BTCommonUtil deviceID] == RES_dev_iphone_4) {
        redRemindViewSize = 8;
    }
}

+ (int)devId {
    return devId;
}

+ (CGSize)devSize {
    return devSize;
}

+ (void)setDeviceName: (NSString*)_devName {
    devName = [[NSString alloc] initWithString: _devName];
}

+ (NSString*)deviceName {
    return devName;
}

+ (CGFloat)topStatusBarHeight {
    return topStatusBarHeight;
}

+ (void)setTopStatusBarHeight: (CGFloat)_topStatusBarHeight {
    topStatusBarHeight = _topStatusBarHeight;
}

+ (CGFloat)navigationBarHeight {
    return navigationBarHeight;
}

+ (void)setNavigationBarHeight: (CGFloat)_navigationBarHeight {
    navigationBarHeight = _navigationBarHeight;
}

+ (CGFloat)topBarHeight {
    return navigationBarHeight + topStatusBarHeight;
}

+ (CGFloat)bottomBarHeight {
    return kBottomBarHeight;
}

+ (CGFloat)scaleDownButtonSizeH {
    return scaleDownButtonSizeH;
}

+ (CGFloat)scaleDownButtonSizeW {
    return scaleDownButtonSizeW;
}

+ (CGFloat)fontSizeT1 {
    return fontSizeT1 / HKUScal;
}

+ (CGFloat)fontSizeT2 {
    return fontSizeT2 / HKUScal;
}

+ (CGFloat)fontSizeT3 {
    return fontSizeT3 / HKUScal;
}

+ (CGFloat)fontSizeT4 {
    return fontSizeT4 / HKUScal;
}

+ (CGFloat)fontSizeT5 {
    return fontSizeT5 / HKUScal;
}

+ (CGFloat)fontSizeT6 {
    return fontSizeT6 / HKUScal;
}

+ (CGFloat)fontSizeT7 {
    return fontSizeT7 / HKUScal;
}

+ (CGFloat)fontSizeT8 {
    return fontSizeT8 / HKUScal;
}

+ (CGFloat)fontSizeT9 {
    return fontSizeT9 / HKUScal;
}

+ (CGFloat)fontSizeT10 {
    return fontSizeT10 / HKUScal;
}

+ (CGFloat)fontSizeT11 {
    return fontSizeT11 / HKUScal;
}

+ (CGFloat)fontSizeT12 {
    return fontSizeT12 / HKUScal;
}

+ (CGFloat)fontSizeT13 {
    return fontSizeT13 / HKUScal;
}

+ (CGFloat)fontSizeT14 {
    return fontSizeT14 / HKUScal;
}

+ (CGFloat)fontSizeT14_1 {
    return fontSizeT14_1 / HKUScal;
}

+ (CGFloat)fontSizeT15 {
    return fontSizeT15 / HKUScal;
}

+ (CGFloat)fontSizeT16 {
    return fontSizeT16 / HKUScal;
}

+ (CGFloat)scaleCenterWorH {
    CGFloat f = UISystemFontCommonH * TNinth * THalfTime;
    
    return f;
}

+ (CGFloat)mainCommonCellOneHeight {
    CGFloat f = UISystemFontT8H + [BTResource mainCellUpDis] * TOneAndHalf;
    
    return f;
}

+ (UIFont*)mainContentFont {
    return UISystemFontT9;
}

+ (CGFloat)mainCellUpDis {
    return [self mainCenterDis];
}

+ (CGFloat)mainBigDiameter {
    return UISystemFontT6H;
}


+ (CGFloat)mainDiaryImgSize {
    CGFloat leftDis = [BTResource mainCardLeftDis];
    CGFloat fristX = [BTResource mainBigDiameter] + leftDis + leftDis * THalfTime;
    CGFloat showViewW = HKUIScreenWidth - fristX * TTwoTime;
    
    return (showViewW - UISystemFontCommonH * TTwoTime) * TOneThird;
}

+ (CGFloat)mainAdvertImgSize {
    CGFloat f = [self mainDiaryImgSize];
    
    return f + f * TOneThird;
}

//返回的是主界面cell里面的内容距离line的宽度或者高度
+ (CGFloat)mainCenterDis {
    
    return [self mainCardLeftDis];
}

+ (CGFloat)mainHeadImgSize {
    return mainHeadImgSize;
}

//主界面list 距离最左边的距离
+ (CGFloat)mainListLeftDis {
    return [BTResource navigationBarHeight] * THalfTime;
}

//主界面list 距离最右边边的距离
+ (CGFloat)mainListRightDis {
    return [self mainListLeftDis] * TTwoTime;
}

+ (double)iosVersion {
    double version = [[UIDevice currentDevice].systemVersion doubleValue];//判定系统版本。
    
    return version;
}

+ (void)setRecordStatus: (int)_recordStatus {
    recordStatus = _recordStatus;
}

+ (int)recordStatus {
    return recordStatus;
}

+ (CGSize)moreButtonSize {
    return moreButtonSize;
}

+ (CGSize)fdkSize {
    return fdkSize;
}

+ (CGFloat)mainTableTopMoveDis {
    return mainTableTopMoveDis;
}

//圈子，问答

+ (CGFloat)circleSecondTopViewH {
    return circleSecondTopViewH;
}

+ (CGFloat)circleSecondAdvertViewH {
    return circleSecondAdvertViewH;
}

+ (CGFloat)circleSecondViewToleftDis {
    return circleSecondViewToleftDis;
}

+ (CGFloat)circleSecondViewBorderWidth {
    return circleSecondViewBorderWidth;
}

+ (CGFloat)circleSecondViewCornerRadius {
    return circleSecondViewCornerRadius;
}

+ (CGFloat)topicListHeadImgSize {
    return topicListHeadImgSize;
}
//圈子，问答

+ (CGFloat)mainCardLeftDis {
    return [BTCommonUtil getFontHeight: UISystemFontT9];
}

+ (CGFloat)mainInViewLeftDis {
    return [BTCommonUtil getFontHeight: UISystemFontT5];
}

+ (CGFloat)mainCardDis {
    return [BTCommonUtil getFontHeight: UISystemFontT7];
}

+ (CGFloat)mainSmlCardH {
    return UISystemFontT10H * TThreeAndHalf;
}

+ (CGFloat)mainCardTitleImgH {
    return UISystemFontT10H * TOneAndHalf;
}

+ (CGFloat)mainCardStartX {
    
    return [BTCommonUtil getFontHeight: UISystemFontT9];
    //[HKResource mainBigDiameter] + [HKResource mainCardLeftDis] * THalfTime
}

+ (CGFloat)mainPushKnowledgeOpenH {
    return [self mainSmlCardH] + [self mainSmlCardH] * TFifth;
}

//more
+ (CGFloat)moreVCLeftDIs {
    return UISystemFontT10H;
}

+ (CGFloat)moreViewToViewDis {
    return UISystemFontT10H * TThreeTime;
}

+ (CGFloat)moreViewHeadImgSize {
    return HKUIScreenWidth * TFifth;
}

+ (CGFloat)moreLeftSContentOffset {
    return [BTResource topBarHeight] + HKUIScreenWidth * 0.055;
}

+ (CGFloat)redRemindViewSize {
    return redRemindViewSize;
}
#pragma mark 识别设备是什么设备
+ (NSString*) doDevicePlatformWithIshiddenModel:(BOOL)ishiddenModel{
    
    size_t size;
    
    int nR = sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    
    char *machine = (char *)malloc(size);
    
    nR = sysctlbyname("hw.machine", machine, &size, NULL, 0);
    
    NSString *name = [[UIDevice currentDevice] name];
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    
    free(machine);
    
    
    if (ishiddenModel) {
        
        if ([platform isEqualToString:@"iPhone1,1"]) {
            
            platform = @"iPhone";
            
        } else if ([platform isEqualToString:@"iPhone1,2"]) {
            
            platform = @"iPhone 3G";
            
        } else if ([platform isEqualToString:@"iPhone2,1"]) {
            
            platform = @"iPhone 3GS";
            
        } else if ([platform isEqualToString:@"iPhone3,1"]||[platform isEqualToString:@"iPhone3,2"]||[platform isEqualToString:@"iPhone3,3"]) {
            
            platform = @"iPhone 4";
            
        } else if ([platform isEqualToString:@"iPhone4,1"]) {
            
            platform = @"iPhone 4S";
            
        } else if ([platform isEqualToString:@"iPhone5,1"]||[platform isEqualToString:@"iPhone5,2"]) {
            
            platform = @"iPhone 5";
            
        }else if ([platform isEqualToString:@"iPhone5,3"]||[platform isEqualToString:@"iPhone5,4"]) {
            
            platform = @"iPhone 5C";
            
        }else if ([platform isEqualToString:@"iPhone6,2"]||[platform isEqualToString:@"iPhone6,1"]) {
            
            platform = @"iPhone 5S";
            
        }else if ([platform isEqualToString:@"iPhone8,2"]||[platform isEqualToString:@"iPhone8,1"]){
            
            
            platform = @"iPhone 6s";
            
        }else if ([platform isEqualToString:@"iPod4,1"]) {
            
            platform = @"iPod touch 4";
            
        }else if ([platform isEqualToString:@"iPod5,1"]) {
            
            platform = @"iPod touch 5";
            
        }else if ([platform isEqualToString:@"iPod3,1"]) {
            
            platform = @"iPod touch 3";
            
        }else if ([platform isEqualToString:@"iPod2,1"]) {
            
            platform = @"iPod touch 2";
            
        }else if ([platform isEqualToString:@"iPod1,1"]) {
            
            platform = @"iPod touch";
            
        } else if ([platform isEqualToString:@"iPad3,2"]||[platform isEqualToString:@"iPad3,1"]) {
            
            platform = @"iPad 3";
        } else if ([platform isEqualToString:@"iPad2,2"]||[platform isEqualToString:@"iPad2,1"]||[platform isEqualToString:@"iPad2,3"]||[platform isEqualToString:@"iPad2,4"]) {
            platform = @"iPad 2";
        }else if ([platform isEqualToString:@"iPad1,1"]) {
            
            platform = @"iPad 1";
            
            
        }else if ([platform isEqualToString:@"iPad2,5"]||[platform isEqualToString:@"iPad2,6"]||[platform isEqualToString:@"iPad2,7"]) {
            platform = @"ipad mini";
        } else if ([platform isEqualToString:@"iPad3,3"]||[platform isEqualToString:@"iPad3,4"]||[platform isEqualToString:@"iPad3,5"]||[platform isEqualToString:@"iPad3,6"]) {
            platform = @"ipad 3";
            
            
        }else{
            
            platform = name;
        }

        
    }else{

        if ([name isEqualToString:@"iPhone Simulator"]) {
            
            platform = name;
            
        }
        
    }
    
    return platform;
}

@end
