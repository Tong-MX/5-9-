//
//  BTProgressHUD.m
//  BTProject
//
//  Created by 明桐的Mac on 16/4/13.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTProgressHUD.h"

@interface BTProgressHUD () {
    CGFloat angle;
    BOOL running;
}

@property (strong) UIImageView *imageview;
@property (strong) UIImageView *imgBgView;

@end

@implementation BTProgressHUD

- (void)dealloc {
    _imageview = nil;
    _imgBgView = nil;
    [self stopAnimation];
}

- (id)init {
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    
    if (self) {
        [self initImageview];
    }
    
    return self;
}

- (void)initParameter {
    self.backgroundColor =  [UIColor clearColor];
}

- (void)initImageview {
    NSArray *gifArr = @[[UIImage imageNamed:@"load21"],
                        [UIImage imageNamed:@"load20"],
                        [UIImage imageNamed:@"load19"],
                        [UIImage imageNamed:@"load18"],
                        [UIImage imageNamed:@"load17"],
                        [UIImage imageNamed:@"load16"],
                        [UIImage imageNamed:@"load15"],
                        [UIImage imageNamed:@"load14"],
                        [UIImage imageNamed:@"load13"],
                        [UIImage imageNamed:@"load12"],
                        [UIImage imageNamed:@"load11"],
                        [UIImage imageNamed:@"load10"],
                        [UIImage imageNamed:@"load9"],
                        [UIImage imageNamed:@"load8"],
                        [UIImage imageNamed:@"load7"],
                        [UIImage imageNamed:@"load6"],
                        [UIImage imageNamed:@"load5"],
                        [UIImage imageNamed:@"load4"],
                        [UIImage imageNamed:@"load3"],
                        [UIImage imageNamed:@"load2"],
                        [UIImage imageNamed:@"load1"]];
    
    UIImage *bgImg = [UIImage imageNamed: @"load10"];
    CGSize bgImgSize = [BTCommonUtil HKImageSize: bgImg];
    bgImgSize.width /= 2;
    bgImgSize.height /= 2;
    
    CGRect bgRect = CGRectMake([BTCommonUtil centerXorY: HKViewWidth InH: bgImgSize.width], [BTCommonUtil centerXorY: HKViewHeight-40 InH: bgImgSize.height], bgImgSize.width, bgImgSize.height);
    
    self.imgBgView = [[UIImageView alloc] initWithFrame: bgRect];
    _imgBgView.backgroundColor = [UIColor clearColor];
    _imgBgView.animationImages = gifArr;
    _imgBgView.animationDuration = 1.5; //执行一次完整动画所需的时长
    _imgBgView.animationRepeatCount = 10000;  //动画重复次数
    [self addSubview: _imgBgView];
    
    _imgBgView.hidden = YES;
    
    UIImage *img = [UIImage imageNamed: @"dh"];
    CGSize imgSize = [BTCommonUtil HKImageSize: img];
    self.imageview = [[UIImageView alloc] initWithImage: img];
    self.imageview.frame = CGRectMake([BTCommonUtil centerXorY: HKViewWidth InH: imgSize.width], [BTCommonUtil centerXorY: HKViewHeight InH: imgSize.height] - imgSize.height *  THalfTime, imgSize.width, imgSize.height);
    [self addSubview: self.imageview];
    self.imageview.hidden = YES;
    
    running = NO;
}

- (void)run {
    if (running == YES) {
        angle += 15;
        [self startAnimation];
        [_imgBgView startAnimating];
        [NSTimer scheduledTimerWithTimeInterval: 0.03 target: self selector: @selector(run) userInfo: nil repeats: NO];
    }
}


- (void)startTime
{
    self.imageview.hidden = NO;
    self.imgBgView.hidden = NO;
    [_imgBgView startAnimating];
    running = YES;
    [self performSelectorOnMainThread:@selector(run) withObject:nil waitUntilDone: NO];
}


- (void)stopAnimation
{
    self.imageview.hidden = YES;
    self.imgBgView.hidden = YES;
    running = NO;
    [UIView areAnimationsEnabled];
    [_imgBgView stopAnimating];
    
}


-(void) startAnimation
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.01];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    _imageview.transform = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
    [UIView commitAnimations];
}

- (void)endAnimation {
    
}

- (void)setBgViewColor: (UIColor*)color {
    self.backgroundColor = color;
}

@end
