//
//  BTLog.m
//  BTProject
//
//  Created by 明桐的Mac on 16/3/22.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTLog.h"

#define TOTag @"HKLog"
#define TOMaxSize 1 * 512 * 1024

#define TODateFormat @"MM-dd HH:mm:ss:SSS"

#define TOLevelTarce  0
#define TOLevelWarning 1
#define TOLevelError 2

#define TOLogName  @"FetalBeat.log"
#define TOLogBakName @"FetalBeat-Bak.log"

static NSString *logPath;
static NSString *logBakPath;
static  NSFileHandle *fileHandle;

static  int logLevel = TOLevelTarce;
static NSDateFormatter *dateFormatter;

@implementation BTLog
+ (void)initialize {
    [super initialize];
    [BTPreferences setDeveloperSelect: YES];
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat: TODateFormat];
    }
    
    if (logPath == nil) {
        logPath = [[NSString alloc] initWithString: [[BTCommonUtil fileCachePath]  stringByAppendingString: [NSString stringWithFormat: @"/%@/%@", TOTag, TOLogName]]];
    }
    
    if (logBakPath == nil) {
        logBakPath = [[NSString alloc] initWithString: [[BTCommonUtil fileCachePath]  stringByAppendingString: [NSString stringWithFormat: @"/%@/%@", TOTag, TOLogBakName]]];
    }
    
    if (![BTCommonUtil isFileExistsAtPath: logPath]) {
        [self writeFristInfo];
    }
    
    if (fileHandle == nil) {
        NSString *path = [self writeFile: TOTag FileName: TOLogName];
        fileHandle = [NSFileHandle fileHandleForWritingAtPath: path];
        [fileHandle seekToEndOfFile];
    }
}

+ (void)init {
    if ([BTCommonUtil isFileExistsAtPath: logBakPath]) {
        [BTCommonUtil delPath: logBakPath];
        
        if ([BTCommonUtil isFileExistsAtPath: logPath]) {
            [self moveItemPath: logPath ToPath: logBakPath];
        }
        
    } else {
        if ([BTCommonUtil isFileExistsAtPath: logPath]) {
            [self moveItemPath: logPath ToPath: logBakPath];
        }
    }
    
    [self writeFristInfo];
    
    if (fileHandle != nil) {
        [fileHandle closeFile];
        fileHandle = nil;
    }
    
    NSString *path = [self writeFile: TOTag FileName: TOLogName];
    fileHandle = [NSFileHandle fileHandleForWritingAtPath: path];
    [fileHandle seekToEndOfFile];
}

+ (void)trace: (NSString*)tag Content: (NSString*)content {
    if (logLevel > TOLevelTarce) {
        return;
    }
    
    [self appendLog: [NSString stringWithFormat: @"%@\t%@", tag, content] Level: @"i"];
}

+ (void)appendLog: (NSString*)content Level: (NSString*)level {
    if ([BTPreferences developerSelect]) {
        NSMutableData  *writer = [[NSMutableData alloc] init];
        NSString *log = [NSString stringWithFormat: @"\n%@\t%@\t%@", [self time], level, content];
#if HKDebug
        printf("%s\n", [log UTF8String]);
#endif
        [writer appendData: [log dataUsingEncoding: NSUTF8StringEncoding]];
        [fileHandle writeData: writer];
        writer = nil;
        
        if ([self fileSize: TOLogName] > TOMaxSize) {
            [self init];
        }
    }
}

#define TTimeError @"time error"
+ (NSString*)time {
    if (dateFormatter != nil) {
        return [dateFormatter stringFromDate: [NSDate date]];
    }
    
    return TTimeError;
}
+ (int)fileSize :(NSString*)fileName {
    NSString *path = [self writeFile: TOTag FileName: fileName];
    NSFileManager * filemanager = [NSFileManager defaultManager];
    
    if([filemanager fileExistsAtPath: path]){
        
        NSDictionary * attributes = [filemanager attributesOfItemAtPath: path error:nil];
        NSNumber *theFileSize = [attributes objectForKey: NSFileSize];
        
        if (theFileSize) {
            
            return [theFileSize intValue];
        }
    } else {
        [self init];
    }
    
    return 0;
}
+ (NSString*)writeFile: (NSString*)rootPath FileName: (NSString*)fileName {
    NSString *path = [[BTCommonUtil fileCachePath]  stringByAppendingString: [NSString stringWithFormat: @"/%@/%@", rootPath, fileName]];
    
    if ([BTCommonUtil isFileExistsAtPath: path]) {
        return path;
    } else {
        path = [[NSString alloc] initWithFormat: @"%@/%@", [BTCommonUtil getPathViaName: rootPath FromFilePath: [BTCommonUtil fileCachePath]],fileName];
    }
    
    return path;
}


//+ (void)init {
//    if ([BTCommonUtil isFileExistsAtPath: logBakPath]) {
//        [BTCommonUtil delPath: logBakPath];
//        
//        if ([BTCommonUtil isFileExistsAtPath: logPath]) {
//            [self moveItemPath: logPath ToPath: logBakPath];
//        }
//        
//    } else {
//        if ([BTCommonUtil isFileExistsAtPath: logPath]) {
//            [self moveItemPath: logPath ToPath: logBakPath];
//        }
//    }
//    
//    [self writeFristInfo];
//    
//    if (fileHandle != nil) {
//        [fileHandle closeFile];
//        fileHandle = nil;
//    }
//    
//    NSString *path = [self writeFile: TOTag FileName: TOLogName];
//    fileHandle = [NSFileHandle fileHandleForWritingAtPath: path];
//    [fileHandle seekToEndOfFile];
//}
//
+ (void)moveItemPath: (NSString*)filePath ToPath: (NSString*)filePath2 {
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSError *error;
    
    if ([fileMgr moveItemAtPath:filePath toPath:filePath2 error:&error] != YES) {
        printf("%s\n", [[error localizedDescription] UTF8String]);
    }
}

+ (void)writeFristInfo {
    NSString *iosVersion = [[UIDevice currentDevice] systemVersion];
    
    NSString *str = [NSString stringWithFormat: @"%@-%@-%@-%@", [BTResource deviceName], iosVersion, HKSoftwateVersion, HKHarowareVersion];
    NSString *text = [[[self time] stringByAppendingString: @"\t"] stringByAppendingString: str];
    
    NSMutableData  *writer = [[NSMutableData alloc] init];
    [writer appendData: [text dataUsingEncoding: NSUTF8StringEncoding]];
    
    [writer writeToFile: [self writeFile: TOTag FileName: TOLogName] atomically:YES];
}




@end
