//
//  BTPreferences.h
//  BTProject
//
//  Created by 明桐的Mac on 16/3/22.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTPreferences : NSObject
+ (BOOL)developerSelect;
+ (void)setDeveloperSelect: (BOOL)b;

#pragma 存储头像
+ (void)setUserHead: (UIImage*)img;
+ (UIImage *)userHead;
+ (void)setUserHeadUrl: (NSString*)url;
+ (NSString *)userHeadUrl;
+ (BOOL)haveUserHead;

//保存滑动视图图片
+ (void)setHomeHeadScrolleView :(NSMutableArray*)arry;
+ (NSMutableArray *)homeHeadScrolleViewShow;
//保存其他视图标签图片
+ (void)setOterHeadView :(NSMutableArray*)arry;
+ (NSMutableArray *)oterHeadView;
//保存标题其他视图
+ (void)setOtherHeadViewTitle:(NSMutableArray *)arry;
+ (NSMutableArray *)otherHeadViewTitle;

//保存滑动视图的标题
+ (void)setOtherHeadViewScrollTitle:(NSMutableArray*)arry;
+ (NSMutableArray *)otherHeadViewScrollTitle;

+(void)setTransfelPhotoWithIsSave:(BOOL)saved;
+(BOOL)savePhoto;

//简历保存
+ (void)setJLSaveWithIsSave:(BOOL)saved;
+ (BOOL)saveJL;
@end
