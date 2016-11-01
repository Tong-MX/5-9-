//
//  BTAdfaViewController.m
//  BTProject
//
//  Created by 明桐的Mac on 16/5/7.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTAdfaViewController.h"
#import "BTPage.h"
#import "BTTabarController.h"
@interface BTAdfaViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic ,strong)BTPage *pageControl;
@property (nonatomic ,strong)UILabel *labeStr;
@end

@implementation BTAdfaViewController

- (void)viewDidLoad {
//    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatHeadScrollView];
}

#pragma mark 创建滑动的头视图
- (void)creatHeadScrollView{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(BTZero, BTZero, HKUIScreenWidth, HKUIScreenHeight)];
    
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = YES;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.contentSize = CGSizeMake(HKUIScreenWidth * 4, HKUIScreenHeight - 20);
    [self.view addSubview:_scrollView];
    [self creatUI];
    [self createPageControl];
}

#pragma mark 创建Page

- (void)createPageControl {
    _pageControl = [[BTPage alloc] initWithCurrentImage:[UIImage imageNamed:@"home_banner_red"] normalImage:[UIImage imageNamed:@"home_banner_nomal"]];
    _pageControl.frame = CGRectMake(4, HKUIScreenHeight - 200, HKUIScreenWidth, 20);
    if ([BTCommonUtil deviceID] == RES_dev_iphone_5) {
        _pageControl.top = HKUIScreenHeight - 155;
    }else if ([BTCommonUtil deviceID] == RES_dev_iphone_6) {
        _pageControl.top = HKUIScreenHeight - 180;
    }else if ([BTCommonUtil deviceID] == RES_dev_iphone_6p) {
        _pageControl.top = HKUIScreenHeight - 200;
    }
    _pageControl.userInteractionEnabled = NO;
    _pageControl.numberOfPages = 4;
    
    [self.view addSubview:_pageControl];
}


- (void)creatUI {
    NSMutableArray *imageArr = [NSMutableArray array];
    NSArray *textArr = @[@"本人李明桐毕业于辽宁的一所石油化工大学,专业是矿物加工工程 虽然我学的是非计算机专业但是我热爱编程,更热爱iOS开发,喜欢它的理念 喜欢它的设计,更热爱这份职业",@"我于2014年毕业来到北京进了第一家工作单位“北京瑞智和康科技有限公司” 做的第一款软件“快乐妈咪”它让我在开发当中成长,学习,进步,而我的第一份心血也全部融入到这里它也让我有了些许成就感我感谢它,也感谢有了一个好的开始",@"2016年2月由于快乐妈咪被收购所以在同年3月份进入了“小邻小里科技有限公司”接触了“小美到家” “小美店铺” “小美管家”等多个项目,在这里给了我继续努力的学习和工作",@"工作这两年我更热爱我的这份职业,我的生活需要努力,我的生活需要奋斗,我愿意通过我的努力通过我的奋斗去改变自己,我也希望贵公司给我个机会我愿意证明我自己的价值,给我梦想就有我停留的位置"];
    for (int i = 0; i < 4; i++) {
        NSString *str = [NSString stringWithFormat:@"ADFA%d",i+1];
        UIImage *image = [UIImage imageNamed:str];
        [imageArr addObject:image];
    }
    for (int i = 0; i < imageArr.count; i++) {
        UIImageView *scrollHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(HKUIScreenWidth * i, BTZero, HKUIScreenWidth, HKUIScreenHeight)];
        
        scrollHeadImageView.image = imageArr[i];
        scrollHeadImageView.contentMode = UIViewContentModeScaleToFill;
        scrollHeadImageView.userInteractionEnabled = YES;
        
       self.labeStr = [BTCommonUtil createLabelFrame:CGRectMake(50, HKUIScreenHeight - 200, HKUIScreenWidth - 100, 200) BgColor:nil Text:textArr[i] textColor:[UIColor blackColor] Font:nil TextAlignment:NSTextAlignmentLeft Tag:0];
        if ([BTCommonUtil deviceID] == RES_dev_iphone_5) {
            self.labeStr.top += 5;
            self.labeStr.font = [UIFont systemFontOfSize:14];
        }else {
            self.labeStr.font = [UIFont systemFontOfSize:18];
        }
        self.labeStr.numberOfLines = 0;
        if (i == 0) {
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSaveGState(context);
            [[UIColor colorWithRed:0x3e/255.0 green:0x45/255.0 blue:0x4e/255.0 alpha:1.0] set];
            CGContextSetShadowWithColor(context, CGSizeMake(0, 0), 5, [UIColor whiteColor].CGColor);
            UILabel *labeTitel = [BTCommonUtil createLabelFrame:CGRectMake(BTZero, 35, HKUIScreenWidth, 20) BgColor:nil Text:@"请允许我介绍一下我自己" textColor:BTColor(252, 99, 100) Font:[UIFont systemFontOfSize:24] TextAlignment:NSTextAlignmentCenter Tag:0];
            labeTitel.numberOfLines = 0;
            
            [scrollHeadImageView addSubview:labeTitel];
        }
        if (i == 1 && [BTCommonUtil deviceID] != RES_dev_iphone_6p) {
            self.labeStr.top += 10;
        }
        if (i == 3) {
            UIButton *clickBtn = [BTCommonUtil createButtonFrame:CGRectMake(HKUIScreenWidth - 90, HKUIScreenHeight - 50, 90, 40) Target:self BgColor:BTColor(252, 99, 100) Title:@"点击跳过" TitleColor:[UIColor whiteColor] BgImg:nil action:@selector(clkickAction:) Tag:0];
            clickBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            clickBtn.layer.cornerRadius = 90/4;
            clickBtn.layer.masksToBounds = YES;
            [scrollHeadImageView addSubview:clickBtn];
        }
        
        [_scrollView addSubview:scrollHeadImageView];
        [scrollHeadImageView addSubview:self.labeStr];
    }
}

- (void)clkickAction:(UIButton*)btn {
    self.view.transform = CGAffineTransformMakeScale(1.0f, 1.0f);//将要显示的view按照正常比例显示出来
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut]; //InOut 表示进入和出去时都启动动画
    [UIView setAnimationDuration:2.f];//动画时间
    self.view.transform=CGAffineTransformMakeScale(0.01f, 0.01f);//先让要显示的view最小直至消失
    [UIView commitAnimations]; //启动动画
    if (self.adfaBlock) {
        self.adfaBlock(self);
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int currentPage = scrollView.contentOffset.x / HKUIScreenWidth;
    self.pageControl.currentPage = currentPage;
}


@end
