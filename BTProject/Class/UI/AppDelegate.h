//
//  AppDelegate.h
//  BTProject
//
//  Created by 明桐的Mac on 16/3/16.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
+ (AppDelegate *)appDelegate;
- (void)showComplete: (NSString *)msg Time: (CGFloat)time;
@property (nonatomic, strong) BaseNavigationController *nvigationController;
@end

