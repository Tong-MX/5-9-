//
//  BTNetProtoBase.m
//  BTProject
//
//  Created by 明桐的Mac on 16/3/23.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTNetProtoBase.h"

static BTNetProtoBase *singleModel = nil;

@implementation BTNetProtoBase


+(BTNetProtoBase *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (nil == singleModel) {
            singleModel = [[BTNetProtoBase alloc]init];
        }
    });
    return singleModel;
}

- (float)convertStringToTimeInterval:(NSString *)dateString FormatterStr:(NSString *)formatterStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:formatterStr];
    NSDate *date = [formatter dateFromString:dateString];
    float interval = date.timeIntervalSince1970;
    return interval;
}

- (NSString *)convertTimeIntervalToString:(float)timeInterval FormatterStr:(NSString *)formatterStr{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:formatterStr];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

- (NSArray *)parseHTMLStrWithStr:(NSString *)str {
    if (str.length == 0 || str == nil) {
        return nil;
    }
    
    NSMutableArray *imgArr = [NSMutableArray array];
    NSMutableArray *strArr = [NSMutableArray array];
    NSMutableArray *aLinkArr = [NSMutableArray array];
    
    str = [BTCommonUtil specialCharacters: str];
    
    //1.取图片url
    NSError *error = nil;
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"(<img src=\")[^\"]+(\" />)"
                                                                           options:0
                                                                             error:&error];
    
    [regex enumerateMatchesInString:str options:0 range:NSMakeRange(0, str.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        
        NSString *url = [str substringWithRange:result.range];
        
        [imgArr addObject:url];
        
    }];
    
    for (int i =0 ; i < imgArr.count; i++) {
        NSString *url = imgArr[i];
        str = [str stringByReplacingOccurrencesOfString:url withString:@""];
        
        url = [url substringWithRange:NSMakeRange(10, url.length - 14)];
        [imgArr replaceObjectAtIndex:i withObject:url];
    }
    
    //2.处理超链接
    regex = [NSRegularExpression regularExpressionWithPattern:@"(<a href=\")[^\"]+(\">)" options:0 error:&error];
    [regex enumerateMatchesInString:str options:0 range:NSMakeRange(0, str.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        
        NSString *aLink = [str substringWithRange:result.range];
        
        [aLinkArr addObject:aLink];
        
    }];
    
    for (int i = 0; i < aLinkArr.count; i++) {
        NSString *aLink = aLinkArr[i];
        str = [str stringByReplacingOccurrencesOfString:aLink withString:@""];
        
        aLink = [aLink substringWithRange:NSMakeRange(9, aLink.length - 11)];
        [aLinkArr replaceObjectAtIndex:i withObject:aLink];
    }
    str = [str stringByReplacingOccurrencesOfString:@"</a>" withString:@""];
    
    //3.多个空格合并为一个
    while ([str rangeOfString:@"  "].length != 0) {
        str = [str stringByReplacingOccurrencesOfString:@"  " withString:@" "];
    }
    
    //4.处理换行回车
    str = [str stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    while ([str rangeOfString:@"\n \n"].length != 0) {
        str = [str stringByReplacingOccurrencesOfString:@"\n \n" withString:@""];
    }
    
    //5.多个换行合并为一个,
    NSRange range = [str rangeOfString:@"\n\n"];
    while (range.length != 0) {
        str = [str stringByReplacingOccurrencesOfString:@"\n\n" withString:@"\n"];
        range = [str rangeOfString:@"\n\n"];
    }
    
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\n"];
    
    //6处理前缀后缀
    while ([str hasPrefix:@"\n"]) {
        str = [str substringFromIndex:2];
        
    }
    
    while ([str hasSuffix:@"\n"]) {
        str = [str substringToIndex:str.length - 2];
        
    }
    
    //7.
    NSString *tempStr = str;
    //    str = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (str) {
        [strArr addObject:str];
    }else{
        [strArr addObject:tempStr];
    }
    
    
    return @[strArr,imgArr];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (CGFloat)installTime {
    NSDate *now = [NSDate date];
    CGFloat app_installtime = [now timeIntervalSince1970];
    
    return app_installtime;
}

- (NSString*)trackDeviceInfo:(NSString*)trackDeviceInfo {
    if ([trackDeviceInfo isEqualToString:@"iPhone Simulator"]) {
        
        trackDeviceInfo = @"iPhone5.1";
    }

    return [NSString stringWithFormat:@"%@%@",trackDeviceInfo,Device_info];
}
@end
