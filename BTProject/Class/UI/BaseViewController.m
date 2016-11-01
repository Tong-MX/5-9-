//
//  BaseViewController.m
//  BTProject
//
//  Created by 明桐的Mac on 16/3/19.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initParameters];
    [self initSize];
    // Do any additional setup after loading the view.
}

- (void)initParameters { //初始化一般参数，比如背景色，id等等
}

- (void)initSize {//初始化size信息，以用来适配其他设备的ui位置
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
