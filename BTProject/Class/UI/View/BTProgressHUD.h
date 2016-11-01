//
//  BTProgressHUD.h
//  BTProject
//
//  Created by 明桐的Mac on 16/4/13.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTObjectView.h"

@interface BTProgressHUD : BTObjectView
- (void)startTime;
- (void)stopAnimation;

- (void)setBgViewColor: (UIColor*)color;
@end
