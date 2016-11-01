//
//  BTResource.h
//  BTProject
//
//  Created by 明桐的Mac on 16/3/18.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
enum  devid {
    RES_dev_iphone_4           = 0,
    RES_dev_iphone_5,
    RES_dev_iphone_6,
    RES_dev_iphone_6p,
    RES_dev_ipad_mini,
    RES_dev_ipad,
};
#define HKUIScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define HKUIScreenWidth ([UIScreen mainScreen].bounds.size.width)

#define HKControllerViewWidth         self.view.frame.size.width
#define HKControllerViewHeight        self.view.frame.size.height

#define HKViewWidth                   self.frame.size.width
#define HKViewHeight                  self.frame.size.height

#define HKViewBoundsRect              self.bounds
#define HKControllerViewBoundsRect    self.view.bounds

#define HKTopBarHeight [BTResource topBarHeight]
#define HKNavigationBarHeight [BTResource navigationBarHeight]

#define HKTopBarOutsidHeight (HKControllerViewHeight - HKTopBarHeight) //除去顶层topBar后的高
#define HKTopBarOutsidRect CGRectMake(HKControllerViewBoundsRect.origin.x, HKTopBarHeight, HKControllerViewBoundsRect.size.width, HKTopBarOutsidHeight)  //除去顶层topBar后的fra me
//去除Tabbar的高度
#define BTTabBerHeight (HKUIScreenHeight - 49)

#define HKAPP_STATUS_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height

#define HKAPP_STATUS_NAVBAR_HEIGHT HKAPP_STATUS_HEIGHT + HKTopBarHeight

#define UIColorC1            [BTCommonUtil setColorWithInt: 0x312f2a]
#define UIColorC2            [BTCommonUtil setColorWithInt: 0x6d6d6d]
#define UIColorC3            [BTCommonUtil setColorWithInt: 0xffffff]
#define UIColorC4            [BTCommonUtil setColorWithInt: 0xef1669]
#define UIColorC5            [BTCommonUtil setColorWithInt: 0xdedede]
#define UIColorC6            [BTCommonUtil setColorWithInt: 0x4f94bb]
#define UIColorC7            [BTCommonUtil setColorWithInt: 0x7fa311]
#define UIColorC8            [BTCommonUtil setColorWithInt: 0xd65d92]
#define UIColorC9            [BTCommonUtil setColorWithInt: 0xaf2559]
#define UIColorC10           [BTCommonUtil setColorWithInt: 0xde8181]
#define UIColorC11           [BTCommonUtil setColorWithInt: 0x64ccf6]
#define UIColorC12           [BTCommonUtil setColorWithInt: 0xaad71f]
#define UIColorC13           [BTCommonUtil setColorWithInt: 0xff0000]
#define UIColorC14           [BTCommonUtil setColorWithInt: 0xf8f8f8]
#define UIColorC15           [BTCommonUtil setColorWithInt: 0xf5f4e7]
#define UIColorC16           [BTCommonUtil setColorWithInt: 0xedead8]
#define UIColorC17           [BTCommonUtil setColorWithInt: 0xfe71a2]
#define UIColorC18           [BTCommonUtil setColorWithInt: 0xececec]
#define UIColorC19           [BTCommonUtil setColorWithInt: 0xbdbdbd]
#define UIColorC20           [BTCommonUtil setColorWithInt: 0xacacac]
#define UIColorC21           [BTCommonUtil setColorWithInt: 0x29b6fd]
#define UIColorC22           [BTCommonUtil setColorWithInt: 0x92db2c]
#define UIColorC23           [BTCommonUtil setColorWithInt: 0x8f9299]
#define UIColorC24           [BTCommonUtil setColorWithInt: 0xdde0e5]
#define UIColorC25           [BTCommonUtil setColorWithInt: 0xc9c9c9]

#define UISystemFontT1        [UIFont systemFontOfSize: [BTResource fontSizeT1]]
#define UISystemFontT2        [UIFont systemFontOfSize: [BTResource fontSizeT2]]
#define UISystemFontT3        [UIFont systemFontOfSize: [BTResource fontSizeT3]]
#define UISystemFontT4        [UIFont systemFontOfSize: [BTResource fontSizeT4]]
#define UISystemFontT5        [UIFont systemFontOfSize: [BTResource fontSizeT5]]
#define UISystemFontT6        [UIFont systemFontOfSize: [BTResource fontSizeT6]]
#define UISystemFontT7        [UIFont systemFontOfSize: [BTResource fontSizeT7]]
#define UISystemFontT8        [UIFont systemFontOfSize: [BTResource fontSizeT8]]
#define UISystemFontT9        [UIFont systemFontOfSize: [BTResource fontSizeT9]]
#define UISystemFontT10       [UIFont systemFontOfSize: [BTResource fontSizeT10]]
#define UISystemFontT11       [UIFont systemFontOfSize: [BTResource fontSizeT11]]
#define UISystemFontT12       [UIFont systemFontOfSize: [BTResource fontSizeT12]]
#define UISystemFontT13       [UIFont systemFontOfSize: [BTResource fontSizeT13]]
#define UISystemFontT14       [UIFont systemFontOfSize: [BTResource fontSizeT14]]
#define UISystemFontT14_1      [UIFont systemFontOfSize: [BTResource fontSizeT14_1]]

#define UISystemFontT15       [UIFont systemFontOfSize: [BTResource fontSizeT15]]
#define UISystemFontT16       [UIFont systemFontOfSize: [BTResource fontSizeT16]]


#define UISystemFontT1H        [BTCommonUtil getFontHeight: UISystemUIScreenWidthFontT1]
#define UISystemFontT2H        [BTCommonUtil getFontHeight: UISystemFontT2]
#define UISystemFontT3H        [BTCommonUtil getFontHeight: UISystemFontT3]
#define UISystemFontT4H        [BTCommonUtil getFontHeight: UISystemFontT4]
#define UISystemFontT5H        [BTCommonUtil getFontHeight: UISystemFontT5]
#define UISystemFontT6H        [BTCommonUtil getFontHeight: UISystemFontT6]
#define UISystemFontT7H        [BTCommonUtil getFontHeight: HKUISystemFontT7]
#define UISystemFontT8H        [BTCommonUtil getFontHeight: UISystemFontT8]
#define UISystemFontT9H        [BTCommonUtil getFontHeight: UISystemFontT9]
#define UISystemFontT10H       [BTCommonUtil getFontHeight: UISystemFontT10]
#define UISystemFontT11H       [BTCommonUtil getFontHeight: UISystemFontT11]
#define UISystemFontT12H       [BTCommonUtil getFontHeight: UISystemFontT12]
#define UISystemFontT13H       [BTCommonUtil getFontHeight: UISystemFontT13]

#define UISystemFontCommonH    [BTCommonUtil getFontHeight: UISystemFontT7]


#define BlodDefine 18
#define THalfTime  0.5
#define TOneThird 1.f / 3.f
#define TFourthTime 0.25
#define TFifth  1.f / 5.f
#define TSixfh 1.f / 6.f
#define TSevenfh 1.f / 7.f
#define TEightfh 1.f / 8.f
#define TNinth   1.f / 9.f
#define TTenfh 1.f / 10.f
#define TEleventh 1.f / 11.f
#define TTwelfth 1.f / 12.f

#define TOneAndHalf 1.5
#define TTwoTime 2
#define TTwoOrTwoTime 2.2
#define TTwoAndHalf 2.5
#define TTwoOrSixTime 2.6
#define TTwoOrSevenTime 2.7
#define TTwoOrEightTime 2.8
#define TThreeTime 3
#define TThreeAndHalf 3.5
#define TThreeOrSevenTime 3.7
#define TFourTime 4
#define FourAndHalf 4.5
#define TFiveTime 5
#define TSixTime 6
#define TTenTime 10

#define TScaleDoneButtonBorderWidth    1
#define TScaleDoneButtonBorderHeight   5
#define TScaleCenterWorH  [HKResource scaleCenterWorH]

#define BTZero 0
#define BTOne  1
#define BTTwo  2
#define BTThree 3
#define BTFour 4
#define BTFive 5
#define BTSeven 7
#define BTEight 8
#define BTTen   10

// 获得RGB颜色
#define BTColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//*********************lixiang*******************************
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height-[BTResource topBarHeight])

//将屏幕高度宽度进行等分
#define kScreenHeight_2 (kScreenHeight/2)
#define kScreenHeight_3 (kScreenHeight/3)
#define kScreenHeight_4 (kScreenHeight/4)
#define kScreenHeight_5 (kScreenHeight/5.5)
#define kScreenHeight_6 (kScreenHeight/6.5)
#define kScreenHeight_8 (kScreenHeight/8)
#define kScreenHeight_10 (kScreenHeight/10)
#define kScreenHeight_16 (kScreenHeight/16)
#define kScreenHeight_32 (kScreenHeight/32)

#define kScreenWidth_2 (kScreenWidth/2)
#define kScreenWidth_3 (kScreenWidth/3)
#define kScreenWidth_4 (kScreenWidth/4)
#define kScreenWidth_5 (kScreenWidth/5)
#define kScreenWidth_10 (kScreenWidth/10)
#define kScreenWidth_16 (kScreenWidth/16)
#define kScreenWidth_18 (kScreenWidth/18)

//时间
#define kDaysNumberOfOneWeek 7
#define kOneMinuteTimeInterval (60.0)
#define kOneHourTimeInterval (60*kOneMinuteTimeInterval)
#define kEightHourTimeInterval (8*kOneHourTimeInterval)
#define kOneDayTimeInterval (24*kOneHourTimeInterval)
#define kOneWeekTimeInterval (7*kOneDayTimeInterval)
#define kPregnancyDurationTimeInterval (280*kOneDayTimeInterval)
#define kPregnancyWeekNumber 40
#define kOneYearTimeInterval (365*kOneDayTimeInterval)
#define kThreeYearTimeInterval 365 * 3
//半径
#define kRadius (kScreenWidth*1.5/2)
#define kRadiusPlus2 (kScreenWidth*1.5)
@interface BTResource : NSObject

+ (void)initDevId: (int)_devId DevSize: (CGSize)_devSize;
+ (int)devId;

+ (void)setDeviceName: (NSString*)_devName;
+ (NSString*)deviceName;

+ (CGFloat)topStatusBarHeight;
+ (void)setTopStatusBarHeight: (CGFloat)_topStatusBarHeight;

+ (CGFloat)navigationBarHeight;
+ (void)setNavigationBarHeight: (CGFloat)_navigationBarHeight;

+ (CGFloat)topBarHeight;

+ (CGFloat)bottomBarHeight;

+ (CGFloat)scaleDownButtonSizeH;
+ (CGFloat)scaleDownButtonSizeW;

+ (CGFloat)fontSizeT1;
+ (CGFloat)fontSizeT2;
+ (CGFloat)fontSizeT3;
+ (CGFloat)fontSizeT4;
+ (CGFloat)fontSizeT5;
+ (CGFloat)fontSizeT6;
+ (CGFloat)fontSizeT7;
+ (CGFloat)fontSizeT8;
+ (CGFloat)fontSizeT9;
+ (CGFloat)fontSizeT10;
+ (CGFloat)fontSizeT11;
+ (CGFloat)fontSizeT12;
+ (CGFloat)fontSizeT13;
+ (CGFloat)fontSizeT14;
+ (CGFloat)fontSizeT14_1;
+ (CGFloat)fontSizeT15;
+ (CGFloat)fontSizeT16;

+ (CGFloat)scaleCenterWorH;

+ (CGFloat)mainCommonCellOneHeight;

+ (UIFont*)mainContentFont;

+ (CGFloat)mainCellUpDis;
+ (CGFloat)mainBigDiameter;
+ (CGFloat)mainDiaryImgSize;
+ (CGFloat)mainAdvertImgSize;

+ (CGFloat)mainCenterDis;
+ (CGFloat)mainHeadImgSize;
+ (CGFloat)mainListLeftDis;
+ (CGFloat)mainListRightDis;
+ (double)iosVersion;
+ (void)setRecordStatus: (int)_recordStatus;
+ (int)recordStatus;
+ (CGSize)moreButtonSize ;
+ (CGSize)fdkSize;

+ (CGFloat)mainTableTopMoveDis;
//识别设备型号
+ (NSString*) doDevicePlatformWithIshiddenModel:(BOOL)ishiddenModel;
@end
