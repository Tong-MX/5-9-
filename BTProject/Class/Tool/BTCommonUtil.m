//
//  BTCommonUtil.m
//  BTProject
//
//  Created by 明桐的Mac on 16/3/21.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTCommonUtil.h"
#import "AFHTTPRequestOperation.h"
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <sys/stat.h>
#import <sys/xattr.h>
#define kSaveImgToPhotoSuccess 0
#define kSaveImgToPhotoFalure -1

static BTCommonUtil *commonUtil;
static NetworkStatus workStatus;
@implementation BTCommonUtil

+ (BTCommonUtil *)shareInstance {
    @synchronized(self) {
        if(commonUtil == nil) {
            commonUtil = [[BTCommonUtil alloc] init];
        }
    }
    
    return commonUtil;
}

+ (UIButton*)createButtonFrame: (CGRect)frame Target: target BgColor: (UIColor*)bgColor Title: (NSString*)title TitleColor: (UIColor*)titleColor BgImg: (UIImage*)bgImg action: (SEL)action Tag: (int)tag {
    
    UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundImage: bgImg forState: UIControlStateNormal];
    [button setTitleColor: titleColor forState: UIControlStateNormal];
    [button setTitle: title forState: UIControlStateNormal];
    [button addTarget: target action: action forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    
    if (!bgColor) {
        button.backgroundColor = [UIColor clearColor];
    } else {
        button.backgroundColor = bgColor;
    }
    
    return button;
}

+ (UIButton*)createTouchButtonFrame: (CGRect)frame Target: target BgColor: (UIColor*)bgColor Title: (NSString*)title TitleColor: (UIColor*)titleColor BgImg: (UIImage*)bgImg Img: (UIImage*)img action: (SEL)action Tag: (int)tag {
    
    UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
    button.frame = frame;
    [button setBackgroundImage: bgImg forState: UIControlStateNormal];
    [button setBackgroundImage: img forState: UIControlStateHighlighted];
    [button setTitleColor: titleColor forState: UIControlStateNormal];
    [button setTitle: title forState: UIControlStateNormal];
    [button addTarget: target action: action forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    
    if (!bgColor) {
        button.backgroundColor = [UIColor clearColor];
    } else {
        button.backgroundColor = bgColor;
    }
    
    return button;
}

+ (UILabel*)createLabelFrame: (CGRect)frame BgColor: (UIColor*)bgColor Text: (NSString*)text textColor: (UIColor*)textColor Font: (UIFont*)font TextAlignment: (NSTextAlignment)textAlignment Tag: (int)tag {
    
    UILabel *label = [[UILabel alloc] initWithFrame: frame];
    label.textAlignment = textAlignment;
    
    if (!bgColor) {
        label.backgroundColor = [UIColor clearColor];
    } else {
        label.backgroundColor = bgColor;
    }
    
    label.text = text;
    label.textColor = textColor;
    label.font = font;
    label.tag = tag;
    
    return label;
}

//+ (HKUILabel*)createHKUiLabelRect: (CGRect)rect BgColor: (UIColor*)bgColor Text: (NSString*)text TextColor: (UIColor*)textColor Font: (UIFont*)font TextAlignment: (NSTextAlignment)textAlignment VerticalAlignment: (VerticalAlignment)verticalAlignment {
//    HKUILabel *label = [[HKUILabel alloc] initWithFrame: rect];
//    label.textAlignment = textAlignment;
//    label.verticalAlignment = verticalAlignment;
//    label.font = font;
//    label.textColor = textColor;
//    
//    if (bgColor == nil) {
//        bgColor = [UIColor clearColor];
//    }
//    
//    label.backgroundColor = bgColor;
//    label.text = text;
//    
//    return label;
//}

+ (UIImageView*)createImageViewFrame: (CGRect)frame BgColor: (UIColor*)bgColor Img: (UIImage*)img Tag: (int)tag {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame: frame];
    if (!bgColor) {
        imageView.backgroundColor = [UIColor clearColor];
    } else {
        imageView.backgroundColor = bgColor;
    }
    
    imageView.image = img;
    
    return imageView;
}

+ (NSString *)fileDocumentPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [paths objectAtIndex:0];
}

+ (NSString *)fileCachePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    return path;
}

//+ (NSString *)getRecordDataFolderPath {
//    return [self getPathViaName:FetalBeatPath];
//}
//
//+ (NSString *)getPicDataFolderPath {
//    return [self getPathViaName:PicPath];
//}
//
//+ (NSString *)getPlistDataFolderPath {
//    return [self getPathViaName:PlistPath];
//}

+ (NSString *)getPathViaName:(NSString *) name {
    NSString * result = nil;
    BOOL isDir = FALSE;
    
    NSString *documentsDirectory = [self fileCachePath];
    NSString *last = [[NSString alloc] initWithFormat:@"/%@", name];
    NSString *path = [documentsDirectory stringByAppendingString:last];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (!([fileManager fileExistsAtPath:path isDirectory:&isDir] && isDir)) {
        if (![fileManager createDirectoryAtPath: path withIntermediateDirectories:YES attributes:nil error:nil]) {
        } else {
            result = [path copy];
        }
    } else {
        result = [path copy];
    }
    
    return result;
}

+ (NSString *)fileLibraryPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    return path;
}

//+ (NSString *)filePlistPath {
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//    NSString *path = [paths objectAtIndex:0];
//    NSString *result = [NSString stringWithFormat:@"%@/%@", path, HKPlistDir];
//    NSFileManager *fileManage = [NSFileManager defaultManager];
//    
//    if (![fileManage fileExistsAtPath:result]) {
//        [fileManage createDirectoryAtPath:result withIntermediateDirectories:NO attributes:nil error:nil];
//    };
//    return result;
//}

+ (BOOL)isFileExistsAtPath:(NSString *)file {
    if  (!file) {
        return NO;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:file]) {
        return YES;
    } else {
        return NO;
    }
}

+ (NSString *)getPathViaName:(NSString *) name FromFilePath: (NSString*)filePath {
    NSString * result = nil;
    BOOL isDir = FALSE;
    
    NSString *last = [[NSString alloc] initWithFormat:@"/%@", name];
    NSString *path = [filePath stringByAppendingString:last];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (!([fileManager fileExistsAtPath:path isDirectory:&isDir] && isDir)) {
        if (![fileManager createDirectoryAtPath: path withIntermediateDirectories:YES attributes:nil error:nil]) {
            
        } else {
            result = [path copy];
        }
    } else {
        result = [path copy];
    }
    
    return result;
}

+ (BOOL)delPath:(NSString *)path {
    if  (!path) {
        return NO;
    }
    
    BOOL result = YES;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        if (![fileManager removeItemAtPath:path error:nil]) {
            result = NO;
        }
    }
    
    return result;
}

+ (BOOL)deleteDir: (NSString *)dir {
    if (dir.length == 0) {
        return NO;
    }
    
    NSString *imageDir = dir;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:imageDir error:nil];
}

+ (void)clearCacheDir {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dir = [self fileCachePath];
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:dir error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        if (![filename isEqualToString:@"HKLog"]) {
            [fileManager removeItemAtPath:[dir stringByAppendingPathComponent:filename] error:NULL];
        }
    }
}

+ (BOOL)copyFile:(NSString *)srcPath toPath:(NSString *)dstPath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([self isFileExistsAtPath:dstPath]) {
        [self delPath:dstPath];
    }
    BOOL result = [fileManager copyItemAtPath:srcPath toPath:dstPath error:nil];
    return result;
}

+ (NSString *)createFileNameWithFormatter:(NSString *)formatterStr Suffix:(NSString *)suffixStr {
    NSString *result = nil;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    if (formatterStr == nil) {
        [formatter setDateFormat:@"YYYYMMddHHmmss"];
    } else {
        [formatter setDateFormat:formatterStr];
    }
    
    NSString *fileName = [formatter stringFromDate:[NSDate date]];
    if (suffixStr == nil) {
        result = [[NSString alloc] initWithFormat: @"%@",fileName];
    } else {
        result = [[NSString alloc] initWithFormat: @"%@.%@",fileName, suffixStr];
    }
    
    return result;
}

#define TTextExample @"彬"
+ (CGFloat)getFontWidth:(UIFont*)font Text: (NSString*)text {
    if (text) {
        CGSize size = [text sizeWithAttributes: @{NSFontAttributeName: font}];
        CGSize adjustedSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
        CGFloat width = adjustedSize.width;
        return width;
    }
    
    return 0;
}


+ (CGFloat)getFontHeight: (UIFont*)font {
    CGSize size = [TTextExample sizeWithAttributes: @{NSFontAttributeName: font}];
    CGSize adjustedSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
    
    CGFloat height = adjustedSize.height;
    return height;
}

+ (CGFloat)getFontWidth: (UIFont*)font {
    CGSize size = [TTextExample sizeWithAttributes: @{NSFontAttributeName: font}];
    CGSize adjustedSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
    CGFloat width = adjustedSize.width;
    return width;
}

+ (CGSize)getFontSize: (UIFont*)font Text: (NSString*)text {
    CGSize size = [text sizeWithAttributes: @{NSFontAttributeName: font}];
    CGSize adjustedSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
    
    return adjustedSize;
}

//0x312f2a ffc6df
+ (UIColor*)setColorWithInt: (int)newColor {
    int r = (newColor >> 16) & 0xff;
    int g = (newColor >> 8) & 0xff;
    int b = newColor & 0xff;
    int a = (newColor >> 24) & 0xff;
    if (a == 0) {
        a = 0xff;
    }
    
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
}

//+ (NSString *)getTimeStringTimeStamp: (NSTimeInterval)timeStamp formatter: (NSString *)formatterStr {
//    
//    return [NSDate convertTimeIntervalToStringWithTimeInterval:timeStamp style:formatterStr];
//}

//+ (NSString *)getTimeStringTimeDate: (NSDate*)date formatter: (NSString *)formatterStr {
//    
//    return [NSDate convertDateToStringWithDate:date style:formatterStr];
//}

//+ (NSTimeInterval)getTimeStampTimeString: (NSString*)date formatter: (NSString *)formatterStr {
//    
//    return [NSDate convertStringToTimeIntervalWithString:date style:formatterStr];
//}

//+ (NSDate*)gettimeStringToDate: (NSString*)date formatter: (NSString *)formatterStr {
//    
//    return [NSDate convertStringToDateWithString:date style:formatterStr];
//}

+ (UIButton*)createBorderDoneButtonFrame: (CGRect)frame Target: target BorderColor: (CGColorRef)borderColor Action: (SEL)action BorderSize: (CGSize)borderSize Tag: (int)tag Title: (NSString*)title TitleColor: (UIColor*)titleColor {
    UIButton *button = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    button.frame = frame;
    [button addTarget: target action: action forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    button.backgroundColor = [UIColor clearColor];
    button.layer.borderColor =  borderColor;
    button.layer.borderWidth = borderSize.width;
    button.layer.cornerRadius = borderSize.height;
    [button setTitleColor: titleColor forState: UIControlStateNormal];
    [button setTitle: title forState: UIControlStateNormal];
    
    return button;
}

+ (CGColorRef) getColorRef:(int)newColor
{
    int r = (newColor >> 16) & 0xff;
    int g = (newColor >> 8) & 0xff;
    int b = newColor & 0xff;
    int a = (newColor >> 24) & 0xff;
    if (a == 0) {
        a = 0xff;
    }
    
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a].CGColor;
}

+ (UIColor*)setColorWithInt: (int)newColor Alpha: (CGFloat)alpha {
    int r = (newColor >> 16) & 0xff;
    int g = (newColor >> 8) & 0xff;
    int b = newColor & 0xff;
    
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alpha];
}

#define AttributedStringHeightTrim 5
//获取文字的size
+ (CGSize)getAttributedStringSize: (NSAttributedString *)attributedString Font: (UIFont*)font W: (CGFloat)width Spacing: (CGFloat)lineSpacing{
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys: font,NSFontAttributeName,nil];
    NSString *anotherString=[attributedString string];
    
    CGSize  size =[anotherString boundingRectWithSize: CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:tdic context:nil].size;
    
    size.height += AttributedStringHeightTrim;
    return size;
}

+ (CGSize)getStringSize: (NSString *)string Font: (UIFont*)font W: (CGFloat)width Spacing: (CGFloat)lineSpacing {
    
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    CGSize size =[string boundingRectWithSize: CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    CGFloat lise = size.height / [BTCommonUtil getFontHeight: font];
    size.height += lise * lineSpacing;
    
    return size;
}
+ (void)setLabel:(UILabel *)label string:(NSAttributedString *)str withLineSpacing:(CGFloat)space {
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithAttributedString:str];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing: space];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(BTZero, [str length])];
    [label setAttributedText:attributedString1];
    [label sizeToFit];
    
    attributedString1 = nil;
    paragraphStyle1 = nil;
}


//特殊字符处理 有需要在完善
+ (NSString*)specialCharacters: (NSString*)str {
    str = [str stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    str = [str stringByReplacingOccurrencesOfString:@"&emsp;" withString:@" "];
    str = [str stringByReplacingOccurrencesOfString:@"&ensp;" withString:@" "];
    
    str = [str stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    str = [str stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    str = [str stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    str = [str stringByReplacingOccurrencesOfString:@"&quot;" withString: @"\""];
    str = [str stringByReplacingOccurrencesOfString:@"&copy;" withString:@"©"];
    str = [str stringByReplacingOccurrencesOfString:@"&reg;" withString:@"®"];
    str = [str stringByReplacingOccurrencesOfString:@"&times;" withString:@"×"];
    str = [str stringByReplacingOccurrencesOfString:@"&divide;" withString:@"÷"];
    
    return str;
}

- (void)image:(UIImage *)image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo {
    
    if(error != NULL){
        [[NSNotificationCenter defaultCenter] postNotificationName: HKNotifySaveImgToPhoto object: [NSNumber numberWithInt: kSaveImgToPhotoFalure]];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName: HKNotifySaveImgToPhoto object: [NSNumber numberWithInt: kSaveImgToPhotoSuccess]];
    }
}

- (void)saveImgToPhotoImgUrl:(NSString*)imgUrl {
    if (imgUrl.length > BTZero) {
        NSURL *URL = [NSURL URLWithString: imgUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
        [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if ([responseObject isKindOfClass:[UIImage class]]) {
                UIImage *image = responseObject;
                
                if (image) {
                    [self saveImgToPhoto: image];
                } else {
                    [[NSNotificationCenter defaultCenter] postNotificationName: HKNotifySaveImgToPhoto object: [NSNumber numberWithInt: kSaveImgToPhotoFalure]];
                }
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [[NSNotificationCenter defaultCenter] postNotificationName: HKNotifySaveImgToPhoto object: [NSNumber numberWithInt: kSaveImgToPhotoFalure]];
        }];
        
        [requestOperation start];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName: HKNotifySaveImgToPhoto object: [NSNumber numberWithInt: kSaveImgToPhotoFalure]];
    }
}

+ (BOOL)netWork {
    if (workStatus == NotReachable) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        return NO;
    }
    
    return YES;
}

+ (CGFloat)centerXorY: (CGFloat)outXorY  InH: (CGFloat)inXorY {
    return (outXorY - inXorY) * THalfTime;
}

+ (void)setNetWorkStatus: (NetworkStatus)status {
    workStatus = status;
}
+ (CGSize)HKImageSize: (UIImage*)img
{
    CGSize imgSize = img.size;
    
    if ([BTResource devId] == RES_dev_ipad) {
        imgSize.width *= TTwoTime;
        imgSize.height *= TTwoTime;
    }
    return imgSize;
}

+ (CGFloat)viewTopBottomAlignOutH: (CGFloat)outH  InH: (CGFloat)inH {
    return (outH - inH) * THalfTime;
}

+ (CGFloat)viewLeftRightAlignOutW: (CGFloat)outW  InW: (CGFloat)inW {
    return (outW - inW) * THalfTime;
}

+ (int)deviceID {
    NSString *model = [[UIDevice currentDevice] model];
    
    int devid;
    
    if ([model rangeOfString: @"iPhone"].length > BTZero || [model rangeOfString: @"iPod"].length > BTZero) {
        CGFloat h = [[ UIScreen mainScreen ] bounds ].size.height;
    
        if ((HKDevice_5_h - h) > BTZero) {
            devid = RES_dev_iphone_4;
        } else if ((HKDevice_5_h - h)  == BTZero) {
            devid = RES_dev_iphone_5;
        } else if (HKUIScreenHeight == HKDevice_6p_h) {
            devid = RES_dev_iphone_6p;
        }else {
            devid = RES_dev_iphone_6;
        }
    } else if([model rangeOfString: @"iPad"].length > 0) {
        devid = RES_dev_iphone_4;
    } else {
        devid = RES_dev_iphone_5;
        
    }
    
    return devid;
}

+ (BOOL)iphone6P {
    NSString *model = [[UIDevice currentDevice] model];
    
    if ([model rangeOfString: @"iPhone"].length > BTZero) {
        CGFloat h = [[UIScreen mainScreen ] bounds ].size.height;
        
        if (h - HKDevice_6p_h >= BTZero) {
            return YES;
        }
    }
    
    return NO;
}
//以iPhone6为基础
+ (CGFloat)setWidthPX:(CGFloat)px{
    
    return ((px/2)*HKUIScreenWidth)/375;
    
}
+ (CGFloat)setHeightPX:(CGFloat)px{
    
    return ((px/2)*HKUIScreenHeight)/667;
}


@end
