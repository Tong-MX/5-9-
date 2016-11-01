//
//  BTHomeHeaderViewController.h
//  BTProject
//
//  Created by 明桐的Mac on 16/5/5.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BaseRequestListVC.h"

@interface BTHomeHeaderViewController : BaseRequestListVC
@property (nonatomic, strong)NSString *extendData;//点击的视图需要的请求的数据
@property (nonatomic, strong)NSString *titleStr;//标题
@property (nonatomic, strong)NSMutableArray *transFirImageArr;
@end
