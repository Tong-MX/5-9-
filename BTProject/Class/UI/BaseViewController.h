//
//  BaseViewController.h
//  BTProject
//
//  Created by 明桐的Mac on 16/3/19.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationController.h"

@interface BaseViewController : UIViewController

@property (strong) NSString *logTagName;
@property (assign) int controllerId; //自己的id
@property (assign) int fromControllerId;//从哪个controller跳转过来的ID。
- (void)initSize;
- (void)initParameters;

@end
