//
//  BTAdfaViewController.h
//  BTProject
//
//  Created by 明桐的Mac on 16/5/7.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CikeJumpActionBlock)();
@interface BTAdfaViewController : UIViewController
@property (nonatomic,copy)CikeJumpActionBlock adfaBlock;
@end
