//
//  BTWebViewController.h
//  BTProject
//
//  Created by 明桐的Mac on 16/5/5.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BaseRequestListVC.h"

@interface BTWebViewController : BaseRequestListVC
@property (nonatomic, strong) NSString *url;//跳转的url
@property (nonatomic, strong)NSString *titleStr;//标题
@property (nonatomic, assign)NSInteger type;//判断本地读取还是网络
@end
