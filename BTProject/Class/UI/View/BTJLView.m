//
//  BTJLView.m
//  BTProject
//
//  Created by 明桐的Mac on 16/5/6.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTJLView.h"
@interface BTJLView () {
    //    圆A切点 做拖拽准备
    CGPoint point_A;
    CGPoint point_B;
    //    圆B切点
    CGPoint point_C;
    CGPoint point_D;
    //    两圆切线中点坐标，控制BezierPath
    CGPoint controlPoint_AC;
    CGPoint controlPoint_BD;
    
    CGFloat radius_A;
    CGFloat radius_B;
    CGFloat center_distance;
    
    CGPoint circleA_Center;
    CGPoint circleB_Center;
    
    CGFloat sinValue;
    CGFloat cosValue;
}
@property (nonatomic, strong) CAShapeLayer *animationLayer;
@property (nonatomic, strong) UIView *backView;
@end
@implementation BTJLView
- (instancetype)initWithCenterPoint:(CGPoint)centerPoint bubleRadius:(CGFloat)radius addToSuperView:(UIView *)superView {
    
    if (self = [super initWithFrame:CGRectMake(centerPoint.x - radius, centerPoint.y - radius, radius * 2, radius * 2)]) {
        self.decayCoefficent = 2.1;
        [superView addSubview:self];
        [self creatconfigUI];
    }
    return self;
}

- (void)setBubbleColor:(UIColor *)bubbleColor {
    
    if (_bubbleColor != bubbleColor) {
        _bubbleColor = bubbleColor;
        self.frontView.backgroundColor = self.bubbleColor;
        self.backView.backgroundColor = self.bubbleColor;
    }
}

//创建圆 与 字体的ui
- (void)creatconfigUI {
    
    self.backgroundColor = [UIColor clearColor];
    self.animationLayer = [CAShapeLayer layer];
    self.frontView = [[UIView alloc] initWithFrame:self.bounds];
    self.backView = [[UIView alloc] initWithFrame:self.bounds];
    self.frontView.layer.cornerRadius = self.frontView.bounds.size.width * .5;
    self.backView.layer.cornerRadius = self.backView.bounds.size.width * .5;
    self.backView.hidden = YES;
    [self addSubview:self.frontView];
//    [self addSubview:self.backView];
    //滑动手势
    UIPanGestureRecognizer *panGestureRecongnizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
//    [self.frontView addGestureRecognizer:panGestureRecongnizer];
    //点击手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)];
    [self.frontView addGestureRecognizer:tapGesture];
    
    self.unReadLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 30, 40)];
    self.unReadLabel.textAlignment = NSTextAlignmentCenter;
    self.unReadLabel.textColor = [UIColor whiteColor];
    self.unReadLabel.font = [UIFont systemFontOfSize:11 weight:0.05];
    [self.frontView addSubview:self.unReadLabel];
}

- (void)setValues:(NSArray *)values {
    _values = values;
    [self addBubbleAnimation];
}
//小球动画效果
- (void)addBubbleAnimation {
    CAKeyframeAnimation *scaleXAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
    scaleXAnimation.values = self.values;//1.0 1.5 1.0
    scaleXAnimation.keyTimes = @[@0,@0.5,@1.0];
    scaleXAnimation.repeatCount = HUGE_VAL;
    scaleXAnimation.autoreverses = YES;
    scaleXAnimation.duration = 2.0;
    scaleXAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.frontView.layer addAnimation:scaleXAnimation forKey:@"frontScaleXAnimation"];
    
    CAKeyframeAnimation *scaleYAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleYAnimation.values = self.values; //@[@1.0,@1.5,@1.0];
    scaleYAnimation.keyTimes = @[@0,@0.5,@1.0];
    scaleYAnimation.duration = 2.0;
    scaleYAnimation.autoreverses = YES;
    scaleYAnimation.repeatCount = HUGE_VAL;
    scaleYAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.frontView.layer addAnimation:scaleYAnimation forKey:@"frontScaleYAnimation"];
}

- (void)panAction:(UIPanGestureRecognizer *)pan {

    
}

- (void)actionTap:(UITapGestureRecognizer*)tap {
    if (self.cleanMessageBlock) {
        self.cleanMessageBlock(self);
    }
}
@end
