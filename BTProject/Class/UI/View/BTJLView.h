//
//  BTJLView.h
//  BTProject
//
//  Created by 明桐的Mac on 16/5/6.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ClickActionBlock)();
@interface BTJLView : UIView
@property (nonatomic, copy) ClickActionBlock cleanMessageBlock;

//显示Label
 
@property (nonatomic, strong) UILabel *unReadLabel;

//气泡颜色
@property (nonatomic, strong) UIColor *bubbleColor;

//拉伸系数，取值（0~1），系数越大，拉伸距离越长。
@property (nonatomic, assign) CGFloat decayCoefficent;

//气泡变化的大小
@property (nonatomic, strong)NSArray *values;
//@property (nonatomic, assign)CGFloat values3;
//字体与颜色外部需要访问
@property (nonatomic, strong) UIView *frontView;
/**
 *  初始化bubbleView
 *
 *  @param centerPoint 中心点坐标
 *  @param radius      半径
 *  @param superView   父视图
 *
 *  @return 实例对象
 */
- (instancetype)initWithCenterPoint:(CGPoint)centerPoint bubleRadius:(CGFloat)radius addToSuperView:(UIView *)superView;
//- (void)hidenBubbleView;
//- (void)showBubbleView;
- (void)addBubbleAnimation;
@end
