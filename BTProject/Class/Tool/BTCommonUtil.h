//
//  BTCommonUtil.h
//  BTProject
//
//  Created by 明桐的Mac on 16/3/21.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
@interface BTCommonUtil : NSObject

+ (BTCommonUtil *)shareInstance;

+ (UIButton*)createButtonFrame: (CGRect)frame Target: target BgColor: (UIColor*)bgColor Title: (NSString*)title TitleColor: (UIColor*)titleColor BgImg: (UIImage*)bgImg action: (SEL)action Tag: (int)tag;
+ (UIButton*)createTouchButtonFrame: (CGRect)frame Target: target BgColor: (UIColor*)bgColor Title: (NSString*)title TitleColor: (UIColor*)titleColor BgImg: (UIImage*)bgImg Img: (UIImage*)img action: (SEL)action Tag: (int)tag;

+ (UILabel*)createLabelFrame: (CGRect)frame BgColor: (UIColor*)bgColor Text: (NSString*)text textColor: (UIColor*)textColor Font: (UIFont*)font TextAlignment: (NSTextAlignment)textAlignment Tag: (int)tag;
+ (UIImageView*)createImageViewFrame: (CGRect)frame BgColor: (UIColor*)bgColor Img: (UIImage*)img Tag: (int)tag;

//+ (HKUILabel*)createHKUiLabelRect: (CGRect)rect BgColor: (UIColor*)bgColor Text: (NSString*)text TextColor: (UIColor*)textColor Font: (UIFont*)font TextAlignment: (NSTextAlignment)textAlignment VerticalAlignment: (VerticalAlignment)verticalAlignment;

+ (NSString *)fileDocumentPath;
+ (NSString *)fileCachePath;
+ (NSString *)fileLibraryPath;
+ (NSString *)filePlistPath;

+ (NSString *)getPicDataFolderPath;
+ (NSString *)getRecordDataFolderPath;
+ (NSString *)getPlistDataFolderPath;

+ (NSString *)createFileNameWithFormatter:(NSString *)formatterStr Suffix:(NSString *)suffixStr;

+ (BOOL)isFileExistsAtPath:(NSString *)file;
+ (NSString *)getPathViaName:(NSString *) name FromFilePath: (NSString*)filePath;
+ (BOOL)delPath:(NSString *)path;
+ (BOOL)deleteDir: (NSString *)dir;
+ (void)clearCacheDir;
+ (BOOL)copyFile:(NSString *)srcPath toPath:(NSString *)dstPath;

+ (CGFloat)getFontWidth:(UIFont*)font Text: (NSString*)text;
+ (CGFloat)getFontHeight: (UIFont*)font;
+ (CGFloat)getFontWidth: (UIFont*)font;
+ (CGSize)getFontSize: (UIFont*)font Text: (NSString*)text;
+ (UIColor*)setColorWithInt: (int)newColor;
+ (CGColorRef)getColorRef:(int)newColor;

+ (UIColor*)setColorWithInt: (int)newColor Alpha: (CGFloat)alpha;
+(void)drawText:(CGContextRef)context string:(NSString *)aString rect:(CGRect)aRect;

+ (NSString *)getTimeStringTimeStamp: (NSTimeInterval)timeStamp formatter: (NSString *)formatterStr;
+ (NSString *)getTimeStringTimeDate: (NSDate*)date formatter: (NSString *)formatterStr;
+ (NSTimeInterval)getTimeStampTimeString: (NSString*)date formatter: (NSString *)formatterStr;
+ (NSDate*)gettimeStringToDate: (NSString*)date formatter: (NSString *)formatterStr;

+ (UIButton*)createBorderDoneButtonFrame: (CGRect)frame Target: target BorderColor: (CGColorRef)borderColor Action: (SEL)action BorderSize: (CGSize)borderSize Tag: (int)tag Title: (NSString*)title TitleColor: (UIColor*)titleColor;

//计算图片大小
+ (CGSize)HKImageSize: (UIImage*)img;

//左右对齐 outW 外层view的宽 inW 内层view的宽
+ (CGFloat)viewLeftRightAlignOutW: (CGFloat)outW  InW: (CGFloat)inW;
//上下对齐 outH 外层view的高 inH 内层view的高
+ (CGFloat)viewTopBottomAlignOutH: (CGFloat)outH  InH: (CGFloat)inH;
+ (CGFloat)centerXorY: (CGFloat)outXorY  InH: (CGFloat)inXorY;

+ (void)showAlertTitle: (NSString*)title Message: (NSString*)message CancelButton: (NSString*)cancelButton OtherButton: (NSString*)otherButton Deg: (id)deg Tag: (int)tag;
+ (void)showAlertTitle: (NSString*)title Message: (NSString*)message CancelButton: (NSString*)cancelButton OtherButton: (NSString*)otherButton Deg: (id)deg;
+ (UIImage *)getImageFromView:(UIView *)view;
//把秒转换成00:00格式
+ (NSString*)secondChangeString: (long)_second;

+ (NSInteger)IOSVersion; //获取ios版本

//***************************lixiang**************
+(CGFloat)fontSizeiPhone4S:(CGFloat)iPhone4S iPhone5S:(CGFloat)iPhone5S;

+ (void)openRec;

+ (NSString *)objectToJson:(id)object;
+ (NSDictionary *)jsonToDictionary: (NSString *)json;

+ (NSString *)intArrayToString: (NSMutableArray *)array;
+ (NSString *)floatArrayToString: (NSMutableArray *)array;
+ (NSString *)longArrayToString: (NSMutableArray *)array;

+ (NSMutableArray *)stringToArray: (NSString *)str Key: (NSString*)key;

+ (UIImage *)getImageFromURL:(NSString *)fileURL;

//获取文字的size
+ (CGSize)getAttributedStringSize: (NSAttributedString *)attributedString Font: (UIFont*)font W: (CGFloat)width Spacing: (CGFloat)lineSpacing;
+ (CGSize)getStringSize: (NSString *)string Font: (UIFont*)font W: (CGFloat)width Spacing: (CGFloat)lineSpacing;

//根据时间戳判断是多久以前
+ (NSString*)getDateValue: (NSTimeInterval)timeInterval;

+ (CGSize)getHighImagePath: (NSString*)path MaxWidth: (CGFloat)width;
+ (CGSize)getHighImage: (UIImage*)img MaxWidth: (CGFloat)width;
+ (CGSize)getHighImageSize: (CGSize)size MaxWidth: (CGFloat)width;

+ (int)getWeeklyNum: (NSString*)date;
+ (int)getDayNum: (NSString*)date ;

+ (NSString *)babyResultTitle: (NSString *)timeStamp Type: (int)type;

+ (NSString *) getBabyModelAdultResultTitle: (long)timeStamp;

+ (long) getMidnightTime: (long) timeStamp;
+ (NSString *)getSideMenuTitle;

+ (NSString *)getNavidationBarTitleWithType:(int)type;
+ (NSString *)getNavidationBarTitle: (NSString*)dateStr Type: (int)type;

+ (BOOL)netWork;
+ (BOOL)netWorkWifi;
+ (void)setNetWorkStatus: (NetworkStatus)status;

+ (long long) fileSizeAtPath: (NSString *)filePath;

+ (NSString *)getCmsShareUrl: (NSString *)idStr;
+ (NSString *)getBBSShareUrl: (NSString *)idStr;
+ (NSString *)getBKShareUrl: (NSString *)idStr;
+ (NSString *)getKWShareUrl: (NSString *)idStr;
+ (NSString *)getWDRecordUrl: (int)type recTime: (long)recTime;

+ (NSDate*)min1970Date;

+ (void) downImageWithUrl: (NSString*)imgUrl;
+ (UIImage*)getSubImage: (UIImage*)img Rect: (CGRect)rect;

+ (NSString *) getCheckLabel: (long)timeStamp;
+ (NSString *) getCheckLabelMain: (long)timeStamp;

+ (BOOL)strIsValid: (NSString*)string;

#pragma 返回一个指定size 的uiimage
+ (UIImage*)originImage:(UIImage *)image ScaleToSize:(CGSize)size;

+ (NSData *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

+ (int)deviceID;

+ (BOOL)iphone6P;

+ (NSString*)duedateMonthOrBibyMonth: (NSString*)timeStr;

+ (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize;

+ (NSString *)fileCutOffWithPath:(NSString *)path;
+ (NSString *)getShiPuTitle;

+ (BOOL)isEqualCurrentDate:(NSDate *)date;

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

+ (BOOL)hidenSide;
+ (void)setHidenSide: (BOOL)hidden;

#pragma 设置label的间距
+ (void)setLabel:(UILabel *)label string:(NSAttributedString *)str withLineSpacing:(CGFloat)space;
//+ (void)setNewLabel:(UILabel *)label string:(NSString *)str withLineSpacing:(CGFloat)space;

+ (int)getBabyPushParameter;
+ (NSString *)getBabyTitle;

+ (NSString*)channelNo;
+ (BOOL)isChannelNo ;
+ (NSString *) getVccineCheckLabel: (long)timeStamp;
+ (NSString *) getVccineCheckMain: (long)timeStamp ;

+ (void)modifyWebHeader;

+ (int) getWeekDayNum: (NSTimeInterval) timeStamp;

//特殊字符处理;
+ (NSString*)specialCharacters: (NSString*)str;

+ (NSMutableArray *)setCheckDateAndTimeWithCheckOption;

//+ (BOOL)isAllowedNotification;

- (void)saveImgToPhoto: (UIImage*)img;
- (void)saveImgToPhotoImgUrl:(NSString*)imgUrl;

#pragma mark 以iPhone6为基础传PX值可以直接返回数值
+ (CGFloat)setWidthPX:(CGFloat)px;
+ (CGFloat)setHeightPX:(CGFloat)px;

@end
