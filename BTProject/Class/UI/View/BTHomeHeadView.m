//
//  BTHomeHeadView.m
//  BTProject
//
//  Created by 明桐的Mac on 16/3/26.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTHomeHeadView.h"
#import "BTPage.h"
#import "BTHeadOtherView.h"
#define Countdown 3
@interface BTHomeHeadView()<BTCollectionViewButtonDelegate>
@property (nonatomic ,strong)UIScrollView *scrollHeadView;
@property (nonatomic ,strong)BTPage *pageControl;
@property (nonatomic ,strong)NSMutableArray *imageMutableArray;
@property (nonatomic ,strong)NSMutableArray *banerExtendMtutabel;
@property (nonatomic ,strong)NSMutableArray *banerTitleMtutabel;
@property (nonatomic ,strong)BTHeadOtherView *wihtView;
@property (nonatomic, strong) NSTimer *timer;//创建定时器
@property (nonatomic, assign) int time;
@property (nonatomic, assign) int currentPage;

@end
@implementation BTHomeHeadView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor =[UIColor clearColor];
    
        [self creatHeadScrollView];
        [self creatOtherHeadView];
        [self createPageControl];
        [self creatTimer];
    }
    
    return self;
}

#pragma mark 创建滑动的头视图

- (void)creatHeadScrollView{

    self.scrollHeadView = [[UIScrollView alloc] initWithFrame:CGRectMake(BTZero, BTZero, HKUIScreenWidth, HKUIScreenHeight / 4 + [BTCommonUtil setHeightPX:50])];
    
    _scrollHeadView.backgroundColor = [UIColor whiteColor];
    _scrollHeadView.delegate = self;
    _scrollHeadView.showsVerticalScrollIndicator = NO;
    _scrollHeadView.showsHorizontalScrollIndicator = YES;
    _scrollHeadView.pagingEnabled = YES;
    [self addSubview:_scrollHeadView];

    NSMutableArray *homeHeadArray = [BTPreferences homeHeadScrolleViewShow];
    
    if (homeHeadArray.count > 0) {
        
        if (homeHeadArray.count == 1) {
            _scrollHeadView.pagingEnabled = NO;
        }
        [self scrollHeadImageView:homeHeadArray];
    }
}

#pragma mark 创建Page
- (void)createPageControl {
}

- (void)creatOtherHeadView{

    self.wihtView = [[BTHeadOtherView alloc] initWithFrame:CGRectMake(BTZero, _scrollHeadView.frame.size.height, HKUIScreenWidth, self.frame.size.height - _scrollHeadView.frame.size.height + [BTCommonUtil setHeightPX:60])];
    self.wihtView.backgroundColor = [UIColor clearColor];
    self.wihtView.delegate = self;
    UIImageView *bannerArcView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 1, HKUIScreenWidth, 0)];
    UIImage *image = [UIImage imageNamed:@"home_banner_bottom_arc_icon"];
    CGSize imgSize = [BTCommonUtil HKImageSize:image];
    CGRect rect = bannerArcView.frame;
    rect.size.height = imgSize.height;
    rect.origin.y -= imgSize.height;
    bannerArcView.frame = rect;
    bannerArcView.image = image;
    bannerArcView.backgroundColor = [UIColor clearColor];

    _pageControl = [[BTPage alloc] initWithCurrentImage:[UIImage imageNamed:@"home_banner_red"] normalImage:[UIImage imageNamed:@"home_banner_nomal"]];
    _pageControl.frame = CGRectMake(5, 0, HKUIScreenWidth, 20);
    _pageControl.userInteractionEnabled = NO;
    _pageControl.numberOfPages = 5;
    
    [self addSubview:_wihtView];
    [_wihtView addSubview:bannerArcView];
    [bannerArcView addSubview:_pageControl];
}

#pragma mark set方法
- (void)setHeadScrolleDic:(NSDictionary *)headScrolleDic {
    dispatch_queue_t queue1 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 2.在并行队列里面添加异步任务
    dispatch_async(queue1, ^{
        // 多线程的入口
        @autoreleasepool {
            _imageMutableArray = headScrolleDic[@"banerMutable"];
            _banerExtendMtutabel = headScrolleDic[@"banerExtendMtutabel"];
            _banerTitleMtutabel = headScrolleDic[@"banerTitleMtutabel"];
        }
    });
    NSMutableArray *headScrollerArray = [NSMutableArray array];
    //            [BTPreferences setHomeHeadScrolleView:headScrolleDic[@"banerMutable"]];
    [headScrolleDic[@"banerMutable"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSURL *url = [NSURL URLWithString:obj];
        [headScrollerArray addObject:url];
    }];
    
    [self scrollHeadImageView:headScrollerArray];
   
}

- (void)setBannerCategoryDic:(NSDictionary *)bannerCategoryDic{
    
    self.wihtView.bannerCategoryDic = bannerCategoryDic;
}

- (void)scrollHeadImageView :(NSMutableArray*)homeHeadArray{
    
    _pageControl.numberOfPages = homeHeadArray.count;
    _pageControl.currentPage = 0;
    _scrollHeadView.contentSize = CGSizeMake(HKUIScreenWidth * (_imageMutableArray.count+2), HKUIScreenHeight);
    _scrollHeadView.contentOffset = CGPointMake(HKUIScreenWidth, 0);
    
    NSMutableArray *imageMutableArray = [NSMutableArray arrayWithArray:homeHeadArray];
    if (homeHeadArray.count > 0) {
        [imageMutableArray insertObject:[homeHeadArray lastObject] atIndex:BTZero];
        [imageMutableArray addObject:homeHeadArray[0]];
    }
    
    _scrollHeadView.contentSize = CGSizeMake(HKUIScreenWidth * imageMutableArray.count, _scrollHeadView.frame.size.height);
    for (int i = 0; i < imageMutableArray.count; i++) {
        UIImageView *scrollHeadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(HKUIScreenWidth * i, BTZero, HKUIScreenWidth, self.scrollHeadView.frame.size.height)];

        [scrollHeadImageView sd_setImageWithURL:imageMutableArray[i] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            scrollHeadImageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)];
            scrollHeadImageView.tag = i;
            [scrollHeadImageView addGestureRecognizer:tapGesture];
            [_scrollHeadView addSubview:scrollHeadImageView];            
        }];
    }
}

- (void)actionTap:(UITapGestureRecognizer*)tap {
    UIView *targetview = tap.view;
    if (_delegate && [_delegate respondsToSelector:@selector(homeHeadWithExtendData:TitleStr:clickTag:)]) {
        [_delegate homeHeadWithExtendData:self.banerExtendMtutabel[targetview.tag - 1] TitleStr:self.banerTitleMtutabel[targetview.tag - 1] clickTag:targetview.tag];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int currentPage = scrollView.contentOffset.x / HKUIScreenWidth;
    
    if (currentPage == BTZero) {
        
        self.pageControl.currentPage = _imageMutableArray.count;
        [self.scrollHeadView scrollRectToVisible:CGRectMake(HKUIScreenWidth * _imageMutableArray.count, 0, HKUIScreenWidth, HKUIScreenHeight) animated:NO];
        
    }else if (currentPage == _imageMutableArray.count +1){
    
        self.pageControl.currentPage = 0;
        self.scrollHeadView.contentOffset = CGPointMake(HKUIScreenWidth, BTZero);
        
    }else if (currentPage == _imageMutableArray.count){
    
        self.pageControl.currentPage = currentPage;
        
    }else{
    
        self.pageControl.currentPage = currentPage - 1;
    }
    [self creatTimer];
}

- (void)collectionWithButtonclickTag:(NSIndexPath*)tagIndexPath{
    if ([_delegate respondsToSelector:@selector(homeHeadWithButtonTag:)]) {
        [_delegate homeHeadWithButtonTag:tagIndexPath];
    }
}
- (void)setTitleScolleIndexPath:(NSIndexPath *)titleScolleIndexPath{
    _wihtView.titleScolleIndexPath = titleScolleIndexPath;
}

- (void)creatTimer{
    //创建定时器
    [self.timer invalidate];
    self.timer = nil;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:Countdown target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:YES];
    
}

#pragma  mark timer的代理方法
- (void)timerFireMethod:(NSTimer *)timer {
    
    if (self.imageMutableArray.count > 1) {
        if (self.time == self.imageMutableArray.count) {
            self.time = 0;
        }
        
        if (self.time == 0) {
            self.scrollHeadView.contentOffset = CGPointMake(self.scrollHeadView.width * (self.time + 1), 0);
            
            int page = self.time;
            self.currentPage = page;
            self.pageControl.currentPage = page;
            self.time += 1;
        } else {
            [UIView animateWithDuration:.5 animations:^{
                self.scrollHeadView.contentOffset = CGPointMake(self.scrollHeadView.width * (self.time + 1), 0);
                
                int page = self.time;
                self.currentPage = page;
                self.pageControl.currentPage = page;
                
                self.time += 1;
            }];
        }
    } else {
        [self.timer invalidate];
        self.timer = nil;
        return;
    }
}


@end
