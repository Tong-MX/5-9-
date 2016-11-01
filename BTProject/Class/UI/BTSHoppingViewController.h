//
//  BTSHoppingViewController.h
//  BTProject
//
//  Created by 明桐的Mac on 16/4/27.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BaseRequestListVC.h"

@interface BTSHoppingViewController : BaseRequestListVC
@property (nonatomic, strong)NSMutableArray *homePostBackSoure;//多少个数据
@property (nonatomic, strong)NSIndexPath *homePostIndexPath;
@property (nonatomic, assign)CGRect cellRect;
@property (nonatomic, strong)NSMutableArray *transFirImageArr;//手机相片
- (void)pushAnimation;
@end
