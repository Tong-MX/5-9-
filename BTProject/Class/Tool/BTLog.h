//
//  BTLog.h
//  BTProject
//
//  Created by 明桐的Mac on 16/3/22.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTLog : NSObject

+ (void)trace: (NSString*)tag Content: (NSString*)content;
+ (void)warn: (NSString*)tag Content: (NSString*)content;
+ (void)error: (NSString*)tag Content: (NSString*)content;

+ (void)test: (NSString*)tag Content: (NSString*)content;


@end
