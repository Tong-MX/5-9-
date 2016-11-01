//
//  BTSHopingHeaderView.m
//  BTProject
//
//  Created by 明桐的Mac on 16/5/2.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTSHopingHeaderView.h"
@interface BTSHopingHeaderView () {
    CGFloat desHeight;
    CGFloat scrollData;
    CGPoint startPoint;
}
@property (nonatomic, strong)UIButton *concentrationBtn;
@property (nonatomic, strong)UIButton *recommendBtn;
@property (nonatomic, strong)UIView *titleView;
@property (nonatomic, strong)UILabel *desLabel;
@property (nonatomic,strong) UIPanGestureRecognizer *up;
@property (nonatomic,strong) UIPanGestureRecognizer *down;
@end
@implementation BTSHopingHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        scrollData = 0;
        startPoint = CGPointMake(0, 0);
//        [self creatHearderUI];
        self.up=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipes:)];
//        [self addGestureRecognizer:self.up];
        
    }
    return self;
}

- (void)handleSwipes:(UIPanGestureRecognizer *)sender
{
    CGPoint point = [sender translationInView:self];
    if (point.y < scrollData) {
        self.top += point.y;
        NSLog(@"%lf",self.top);
        scrollData = self.top;
    }else if (point.y > scrollData) {
        self.top -= point.y;
        NSLog(@"%lf",self.top);
        scrollData = self.top;
    }
    
}
- (void)creatHearderUI {
    self.titleLabel = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:UIColorC2 Font:[UIFont systemFontOfSize:17] TextAlignment:NSTextAlignmentLeft Tag:0];
    self.titleLabel.numberOfLines = 1;
    
    self.desLabel = [BTCommonUtil createLabelFrame:CGRectZero BgColor:nil Text:nil textColor:UIColorC2 Font:[UIFont systemFontOfSize:15] TextAlignment:NSTextAlignmentLeft Tag:0];
    self.desLabel.numberOfLines = 0;
    self.desLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    self.concentrationBtn = [BTCommonUtil createButtonFrame:CGRectZero Target:self BgColor:nil Title:@"半塘精选" TitleColor:UIColorC2 BgImg:nil action:@selector(clickAction:) Tag:0];
    self.concentrationBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.concentrationBtn.selected = YES;
    
    self.recommendBtn = [BTCommonUtil createButtonFrame:CGRectZero Target:self BgColor:nil Title:@"用户推荐" TitleColor:UIColorC2 BgImg:nil action:@selector(clickAction:) Tag:1];
    self.recommendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    self.titleView = [[UIView alloc] init];
    self.titleView.backgroundColor = BTColor(242, 117, 172);
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.desLabel];
    [self addSubview:self.concentrationBtn];
    [self addSubview:self.recommendBtn];
    [self addSubview:self.titleView];
}

#pragma mark set方法传出str值调整行与行间距

- (void)setDesStr:(NSString *)desStr {
    _desStr = desStr;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_desStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];//调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_desStr length])];
    _desLabel.attributedText = attributedString;
    [self.desLabel sizeToFit];
    //    [BTCommonUtil getAttributedStringSize:attributedString Font:[UIFont systemFontOfSize:15] W:_desLabel.width Spacing:10];
    [self layoutSubviewsHeader];
}

- (void)layoutSubviewsHeader {
    desHeight  = [BTCommonUtil getStringSize:_desStr Font:[UIFont systemFontOfSize:15] W:HKUIScreenWidth - 18 Spacing:10].height;
    
    self.titleLabel.frame = CGRectMake(10, 10, HKUIScreenWidth - 20, 20);
    self.desLabel.frame = CGRectMake(self.titleLabel.left, self.titleLabel.top + self.titleLabel.height + 10, HKUIScreenWidth - 18, desHeight);
    self.concentrationBtn.frame = CGRectMake(30, self.desLabel.top + desHeight + 30, 90, 30);
    self.recommendBtn.frame = CGRectMake(HKUIScreenWidth - 130,_concentrationBtn.top, self.concentrationBtn.width, self.concentrationBtn.height);
    self.titleView.frame = CGRectMake(self.concentrationBtn.left, self.concentrationBtn.top + self.concentrationBtn.height + 3, self.concentrationBtn.width + 10, 2);
    self.frame = CGRectMake(BTZero, HKUIScreenHeight, HKUIScreenWidth,desHeight + self.titleLabel.height +  self.concentrationBtn.height + self.titleView.height + 60);
    if (_block) {
        _block(self.frame);
    }
//    _myCell.headerViewHeigth = self.headerView.height;
}

- (void)clickAction:(UIButton*)btn {
    CGFloat leftFloat;
    if (btn.tag == 0) {
        _concentrationBtn.selected = !_recommendBtn.selected;
        leftFloat = _concentrationBtn.left;
    }else if (btn.tag == 1) {
        _recommendBtn.selected = !_concentrationBtn.selected;
        leftFloat = _recommendBtn.left;
    }
    [UIView animateWithDuration:.3 animations:^{
        _titleView.left = leftFloat;
    }];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    UITouch *touch = [touches anyObject];
//    CGPoint currentTouchPoint = [touch locationInView:self];
//    if (currentTouchPoint.y > scrollData) {
//        CGPoint labelPosition = CGPointMake(self.left, self.top + currentTouchPoint.y);
//        self.top = labelPosition.y;
//        scrollData = currentTouchPoint.y;
//        MTLog(@"你在往下边滑动....%lf",self.top);
//    }else if (currentTouchPoint.y < scrollData) {
//        CGPoint labelPosition = CGPointMake(self.left, self.top + currentTouchPoint.y);
//        self.top = -labelPosition.y;
//        scrollData = currentTouchPoint.y;
//        MTLog(@"你在往上边滑动....%lf",self.top);
//    }
    
    //计算位移=当前位置-起始位置
    CGPoint point = [[touches anyObject] locationInView:self];
    float dx = 0;
    float dy = point.y - startPoint.y;
    
    //计算移动后的view中心点
    CGPoint newcenter = CGPointMake(self.center.x + dx, self.center.y + dy);
    
    
    /* 限制用户不可将视图托出屏幕 */
//    float halfx = CGRectGetMidX(self.bounds);
//    //x坐标左边界
//    newcenter.x = MAX(halfx, newcenter.x);
//    //x坐标右边界
//    newcenter.x = MIN(self.superview.bounds.size.width - halfx, newcenter.x);
    
    //y坐标同理
    float halfy = CGRectGetMidY(self.bounds);
    newcenter.y = MAX(halfy, newcenter.y);
    newcenter.y = MIN(self.superview.bounds.size.height - halfy, newcenter.y);
    
    //移动view
//    self.top = newcenter.y;
}
@end
