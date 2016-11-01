//
//  MJRefreshFooterView.m
//  weibo
//
//  Created by mj on 13-2-26.
//  Copyright (c) 2013年 itcast. All rights reserved.
//  上拉加载更多


#import "MJRefreshFooterView.h"
#define kDegreesToRadian(x) (M_PI * (x) / 180.0 )

#define kRadianToDegrees(radian) (radian* 180.0 )/(M_PI)
@implementation MJRefreshFooterView

#pragma mark - 初始化
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame: frame]) {
        // 移除刷新时间
		[_lastUpdateTimeLabel removeFromSuperview];
        _lastUpdateTimeLabel = nil;
    
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _arrowImage.frame = CGRectMake(HKUIScreenWidth/2 - 8, 36, 16, 16);
}
#pragma mark - UIScrollView相关
#pragma mark 重写设置ScrollView
- (void)setScrollView:(UIScrollView *)scrollView
{
    // 1.移除以前的监听器
    [_scrollView removeObserver:self forKeyPath:@"contentSize" context:nil];
    // 2.监听contentSize
    [scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    
    // 3.父类的方法
    [super setScrollView:scrollView];
    
    // 4.重新调整frame
    [self adjustFrame];
}

- (void)free
{
    [super free];
    [_scrollView removeObserver:self forKeyPath:@"contentSize" context:nil];
}

#pragma mark 监听UIScrollView的属性
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    
    if ([@"contentSize" isEqualToString:keyPath]) {
        [self adjustFrame];
    }
}

#pragma mark 重写调整frame
- (void)adjustFrame
{
    // 内容的高度
    CGFloat contentHeight = _scrollView.contentSize.height;
    // 表格的高度
    CGFloat scrollHeight = _scrollView.frame.size.height;
    CGFloat y = MAX(contentHeight, scrollHeight);
    // 设置边框 设置刷新视图的高度位置等+20是加上状态栏的高度
    self.frame = CGRectMake(0, y-[BTResource topBarHeight]+20, _scrollView.frame.size.width, [BTResource topBarHeight] / 9 * 11);
    
    // 挪动标签的位置
    CGPoint center = _statusLabel.center;
    center.y = _arrowImage.center.y;
    _statusLabel.center = center;
}

#pragma mark - 状态相关
#pragma mark 设置状态
- (void)setState:(RefreshState)state
{
    if (_state == state) return;
    
    [super setState:state];
    
	switch (_state = state)
    {   //因为直接刷新所以可以忽略正常几种状态直接刷新状态
		case RefreshStatePulling:
        {
            
            _arrowImage.image = [UIImage imageNamed:@"load_Smal"];
            _arrowImage.hidden = NO;
            [UIView animateWithDuration:0.2 animations:^{
//                _arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
//                [_arrowImage.layer addAnimation:[self rotation:.5 degree:kRadianToDegrees (360) direction:1 repeatCount:100] forKey:nil];
                [self transFormCAAnimation:_arrowImage transFormDuration:.3 repeat:10];
                UIEdgeInsets inset = _scrollView.contentInset;
                inset.bottom = 0;
                _scrollView.contentInset = inset;
            }];
			break;
        }
		case RefreshStateNormal:
        {
//            _arrowImage.image = [UIImage imageNamed:@"load_Smal"];
//            [_arrowImage.layer addAnimation:[self rotation:2 degree:kRadianToDegrees (90) direction:1 repeatCount:MAXFLOAT] forKey:nil];
            [self transFormCAAnimation:_arrowImage transFormDuration:.3 repeat:10];
            [UIView animateWithDuration:0.2 animations:^{
                UIEdgeInsets inset = _scrollView.contentInset;
                inset.bottom = 0;
                _scrollView.contentInset = inset;
            }];
			break;
        }
            
        case RefreshStateRefreshing:
        {
            _arrowImage.image = [UIImage imageNamed:@"load_Smal"];
            [UIView animateWithDuration:0.2 animations:^{
                // 1.顶部多出65的滚动范围
                UIEdgeInsets inset = _scrollView.contentInset;
//                inset.bottom = self.frame.origin.y - _scrollView.contentSize.height +[BTResource topBarHeight] / 9 * 11;
                _arrowImage.hidden = YES;
                inset.bottom = 0;
                _scrollView.contentInset = inset;
                
                // 2.设置滚动位置
//                _scrollView.contentOffset = CGPointMake(0, self.validY + [BTResource topBarHeight] / 9 * 11);
            }];
			break;
        }
	}
}

#pragma mark - 在父类中用得上
// 合理的Y值
- (CGFloat)validY
{   
    return MAX(_scrollView.contentSize.height-10, _scrollView.frame.size.height) - _scrollView.frame.size.height-10;
}

// view的类型
- (int)viewType
{
    return RefreshViewTypeFooter;
}

#pragma mark ==== 旋转动画 ======

-(CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:( int )direction repeatCount:(int)repeatCount
{
    CATransform3D rotationTransform = CATransform3DMakeRotation (degree, 0 , 0 , direction);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation. toValue = [NSValue valueWithCATransform3D:rotationTransform];
    animation.duration = dur;
    animation.autoreverses = NO ;
    animation.cumulative = NO ;
    animation.fillMode = kCAFillModeBackwards ;
    animation.repeatCount = repeatCount;
    animation.delegate = self ;
    
    return animation;
}

- (void)transFormCAAnimation:(UIImageView*)anim transFormDuration:(NSTimeInterval)dur repeat:(NSInteger)repeatCount {
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = dur;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeatCount;
    
    [anim.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}
@end