//
//  BTTabarControllerTableViewController.m
//  BTProject
//
//  Created by 明桐的Mac on 16/3/18.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTTabarController.h"
#import "BTHomeViewController.h"
#import "BTMessageViewController.h"
#import "BTPublicViewController.h"
#import "BTMYLifeViewController.h"
#import "BaseNavigationController.h"
#import "BTTopBarViewController.h"
#import "BTTransferImageViewController.h"
#import "BTRegisterController.h"
#import "BaseRequestListVC.h"
#import <AssetsLibrary/AssetsLibrary.h>

#define kClassKey   @"rootVCClassString"
#define kTitleKey   @"kTitleKey"
#define kImgKey     @"imageName"
#define kSelImgKey  @"selectedImageName"


@interface BTTabarController ()<UIImagePickerControllerDelegate>
@property (nonatomic, strong)NSMutableArray *btnArr;
@property (nonatomic, strong)ALAssetsLibrary *libary;//Arc模式必须是全局的
@property (nonatomic, strong)NSMutableArray *dataSouce;
@property (nonatomic, strong)BTHomeViewController *homeVC;
@property (nonatomic, strong)BaseRequestListVC *baseController;
@property (nonatomic, strong)NSMutableArray *imageArr;
@end

@implementation BTTabarController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self beginAnmation];
    [BTPreferences setTransfelPhotoWithIsSave:NO];//相片没有保存
    [self customerPickView];
    [self removeAllTar];
    [self customTabarVC];
    [self initTabarVC];
    //创建标签控制器
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataSouce = [NSMutableArray array];
    self.baseController = [[BaseRequestListVC alloc] init];
//    self.imageArr = [NSMutableArray array];

}

- (void)beginAnmation {
    self.view.transform=CGAffineTransformMakeScale(0.01f, 0.01f);//先让要显示的view最小直至消失
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //InOut 表示进入和出去时都启动动画
    [UIView setAnimationDuration:2.f];//动画时间
    self.view.transform=CGAffineTransformMakeScale(0.01f, 0.01f);//先让要显示的view最小直至消失
    self.view.transform = CGAffineTransformMakeScale(1.0f, 1.0f);//将要显示的view按照正常比例显示出来
    [UIView commitAnimations]; //启动动画
}

#pragma mark 自定义标签栏

- (void)customTabarVC {
    self.btnArr = [NSMutableArray array];
    NSArray *childItemsArray = @[
                                 @{kClassKey  : @"BTHomeViewController"
                                   ,
                                   kImgKey    : @"tab_首页",
                                   kSelImgKey : @"tab_首页_pressed"},
                                 
                                 @{kClassKey  : @"BTPublicViewController",
                                   kImgKey    :
                                       @"tab_社区",
                                   kSelImgKey : @"tab_社区_pressed"},
                                 
                                 @{kClassKey  : @"BTTransferImageViewController",
                                   kImgKey   :@"tab_publish_add",
                                   kSelImgKey : @"tab_publish_addPush"},
                                 
                                 @{kClassKey  : @"BTMessageViewController",
                                   kImgKey    : @"tab_分类",
                                   kSelImgKey : @"bellClick"} ,
                                 
                                 @{kClassKey :
                                       @"BTMYlifeViewController",
                                   kImgKey :@"tab_我的",
                                   kSelImgKey:@"tab_我的_pressed"},
                                 ];
    UIView *tarView = [[UIView alloc] initWithFrame:CGRectMake(0, HKUIScreenHeight - 49, HKUIScreenWidth, 49)];
    tarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tarView];
    float itemWith = HKUIScreenWidth / 5;
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        UIButton *homeBtn = [BTCommonUtil createButtonFrame:CGRectMake(idx * itemWith + 20, 10, 24.5, 26.5) Target:self BgColor:nil Title:nil TitleColor:nil BgImg:nil action:@selector(clickAction:) Tag:0];
        [homeBtn setImage:[UIImage imageNamed:dict[kImgKey]] forState:UIControlStateNormal];
        [homeBtn setImage:[UIImage imageNamed:dict[kSelImgKey]] forState:UIControlStateSelected];
        if (idx == 0) {
            homeBtn.tag = 0;
            [_btnArr addObject:homeBtn];
        }else if (idx == 1) {
            homeBtn.tag = 1;
            [_btnArr addObject:homeBtn];
        }else if (idx == 2) {
            homeBtn.tag = 9;
        }else if (idx == 3) {
            homeBtn.tag = 2;
            [_btnArr addObject:homeBtn];
        }else if (idx == 4) {
            homeBtn.tag = 3;
            [_btnArr addObject:homeBtn];
        }
        if (idx == 0) {
            homeBtn.selected = YES;
        }
        [tarView addSubview:homeBtn];
    }];
}
#pragma mark 创建tabar控制器

- (void)initTabarVC {
    // 1.创建首页视图控制器
    self.homeVC = [[BTHomeViewController alloc] init];
    // 2.创建消息
    BTPublicViewController *messageVC = [[BTPublicViewController alloc] init];
    // 3.创建个人中心
    BTMessageViewController *profileVC = [[BTMessageViewController alloc] init];
    // 4.创建我的
    BTMYlifeViewController *moreVC = [[BTMYlifeViewController alloc] init];
    // 6.创建所有控制器集合的数组
    NSArray *viewCtrls = @[_homeVC,messageVC,profileVC,moreVC];
    // 7.把所有的导航控制器给标签控制器
    self.viewControllers = viewCtrls;
}

- (void)clickAction:(UIButton*)btn {
    if (btn.tag == 9) {
        //自定义
        BTTransferImageViewController *transFirImage = [[BTTransferImageViewController alloc] init];
        transFirImage.dataSouce = _dataSouce;
        [self.navigationController presentViewController:transFirImage animated:YES completion:nil];
        return;
    }
    
    if (btn.tag == 3) {
        BTRegisterController *registerVc = [[BTRegisterController alloc] init];
        [self.navigationController presentViewController:registerVc animated:YES completion:nil];
        return;
    }
    UIButton *lastBtn = _btnArr[self.selectedIndex];
    if (btn != lastBtn) {
        
        btn.selected = YES;
        lastBtn.selected = NO;
    }
        self.selectedIndex = btn.tag;
}

#pragma mark 计算相册数量数量大否则相册打开失败
- (void)customerPickView {
    self.libary = [[ALAssetsLibrary alloc] init];
    [_libary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        NSString *str = (NSString*)group;
        NSLog(@"~~~~~~%@",str);
        if (group) {
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result) {
                    [self.dataSouce addObject:result];
//                    [BTLog trace:@"照片界面" Content:@"取相片成功"];
                    if (_dataSouce.count > 0) {
                        [self setImageArr:_dataSouce];
                    }
                }
            }];
        }
    } failureBlock:^(NSError *error) {
        [BTLog trace:@"照片界面" Content:@"取出相片失败"];
        [self customerPickView];
    }];
}

- (void)removeAllTar {
    // 移除YMTabBar以外的其他控件
    for (int i = 0; i<self.tabBar.subviews.count; i++) {
        UIView *child = self.tabBar.subviews[i];
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

#pragma mark 拿出手机相片
- (void)setImageArr:(NSMutableArray *)imageArr {
    self.baseController.photos = imageArr;
    self.homeVC.transFirImageArr = imageArr;
}
#pragma mark 快速创建系统的标签栏

- (void)creatTabr {
    NSArray *childItemsArray = @[
                                 @{kClassKey  : @"BTHomeViewController"
                                   ,
                                   kImgKey    : @"tab_首页",
                                   kSelImgKey : @"tab_首页_pressed"},
                                 
                                 @{kClassKey  : @"BTPublicViewController",
                                   kImgKey    :
                                       @"tab_社区",
                                   kSelImgKey : @"tab_社区_pressed"},
                                 
                                 @{kClassKey  : @"BTTransferImageViewController",
                                   kImgKey   :@"homeAdd",
                                   kSelImgKey : @"homeAdd"},
                                 
                                 @{kClassKey  : @"BTMessageViewController",
                                   kImgKey    : @"tab_分类",
                                   kSelImgKey : @"bellClick"} ,
                                 
                                 @{kClassKey :
                                       @"BTMYlifeViewController",
                                   kImgKey :@"tab_我的",
                                   kSelImgKey:@"tab_我的_pressed"},
                                 ];
    
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        UIViewController *vc = [NSClassFromString(dict[kClassKey]) new];
        vc.title = dict[kTitleKey];
        
        UITabBarItem *item = vc.tabBarItem;
        item.title = dict[kTitleKey];
        item.tag = idx;
        item.image = [UIImage imageNamed:dict[kImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[kSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        if (vc) {
            //            [self addChildViewController:vc];
        }
    }];
}
@end
