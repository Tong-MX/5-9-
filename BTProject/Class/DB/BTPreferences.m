//
//  BTPreferences.m
//  BTProject
//
//  Created by 明桐的Mac on 16/3/22.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTPreferences.h"

#define DBDeveloperSelectKey        @"developerSelect"
#define BTHomeScrollView            @"HomeScrollView"
#define BTOterView                  @"OterView"
#define BTOtherStr                  @"OtherStr"
#define BTOtherScroolStr            @"OtherScroolStr"
#define BTTranferPhotoKey           @"TranferPhotoKey"
#define BTJLKey                     @"JLKey"
@implementation BTPreferences

+ (BOOL)developerSelect {
    
    
    BOOL developerSelect = [[NSUserDefaults standardUserDefaults] boolForKey: DBDeveloperSelectKey];
    
    return developerSelect;
}

+ (void)setDeveloperSelect: (BOOL)b {
    
    [[NSUserDefaults standardUserDefaults] setBool: b forKey: DBDeveloperSelectKey];
}

//+ (void)setUserHead: (UIImage*)img {
//    NSData *data = UIImageJPEGRepresentation(img, 1.0);
//    
//    [[NSUserDefaults standardUserDefaults] setObject: data forKey: kUserHead];
//}
//
//+ (UIImage *)userHead {
//    
//    NSData * data = [[NSUserDefaults standardUserDefaults] dataForKey: kUserHead];
//    
//    if (data == nil) {
//        [BTLog trace:  @"后台" Content: @"用户的头像为nil"];
//        return [UIImage imageNamed: RES_IMG_HEAD];
//    }
//    
//    UIImage *img = [UIImage imageWithData: data];
//    
//    return img;
//}

+ (void)setHomeHeadScrolleView :(NSMutableArray*)arry{
    if (arry) {
        [[NSUserDefaults standardUserDefaults] setObject:arry forKey:BTHomeScrollView];
    }
}

+ (NSMutableArray *)homeHeadScrolleViewShow {
    
    NSMutableArray *imgArray = [[NSUserDefaults standardUserDefaults] objectForKey:BTHomeScrollView];
    if (imgArray == nil) {
        return [NSMutableArray array];
    }
    return imgArray;
}

+ (void)setOterHeadView :(NSMutableArray*)arry{
    if (arry) {
        [[NSUserDefaults standardUserDefaults] setObject:arry forKey:BTOterView];
    }else {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:BTOterView];
    }
}
+ (NSMutableArray *)oterHeadView{

    NSMutableArray *imgArray = [[NSUserDefaults standardUserDefaults] objectForKey: BTOterView];
    
    if (imgArray == nil) {
        
        return [NSMutableArray array];
    }
    return imgArray;
}

+ (void)setOtherHeadViewTitle :(NSMutableArray*)arry{

    if (arry) {
        [[NSUserDefaults standardUserDefaults] setObject:arry forKey:BTOtherStr];
    }
}
+ (NSMutableArray *)otherHeadViewTitle{
    NSMutableArray *titleArray = [[NSUserDefaults standardUserDefaults] objectForKey:BTOtherStr];
    if (titleArray == nil) {
        
        return [NSMutableArray array];
    }
    return titleArray;
}
//其他视图上的滑动标题
+ (void)setOtherHeadViewScrollTitle :(NSMutableArray*)arry{
    if (arry) {
        [[NSUserDefaults standardUserDefaults] setObject:arry forKey:BTOtherScroolStr];
    }
}

+ (NSMutableArray *)otherHeadViewScrollTitle{
    NSMutableArray *scrollTitleArr = [[NSUserDefaults standardUserDefaults] objectForKey:BTOtherScroolStr];
    if (scrollTitleArr == nil) {
        return [NSMutableArray array];
    }
    return scrollTitleArr;
}

+ (void)setTransfelPhotoWithIsSave:(BOOL)saved {
//    if (!saved) {
    [[NSUserDefaults standardUserDefaults] setBool: saved forKey: BTTranferPhotoKey];
//    }
}

+ (BOOL)savePhoto {
    BOOL savePhoto = [[NSUserDefaults standardUserDefaults] boolForKey: BTTranferPhotoKey];
    
    return savePhoto;
}

+ (void)setJLSaveWithIsSave:(BOOL)saved {
    //    if (!saved) {
    [[NSUserDefaults standardUserDefaults] setBool: saved forKey: BTJLKey];
    //    }
}

+ (BOOL)saveJL {
    BOOL savePhoto = [[NSUserDefaults standardUserDefaults] boolForKey: BTJLKey];
    
    return savePhoto;
}
@end
