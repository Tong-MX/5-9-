//
//  PullToRefreshCoreTextView.h
//  PullToRefreshCoreText
//
//  Created by Cem Olcay on 14/10/14.
//  Copyright (c) 2014 questa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

typedef void(^refreshAction)(void);

typedef NS_ENUM(NSUInteger, MJRefreshHeaderViewStatus) {
    RefreshCoreTextStatusHidden,
    RefreshCoreTextStatusDragging,
    RefreshCoreTextStatusTriggered,
};

@interface RefreshHeaderView : UIView

@property (copy) refreshAction action;
@property (nonatomic, assign) MJRefreshHeaderViewStatus status;
@property (nonatomic, assign, getter=isLoading) BOOL loading;

@property (nonatomic, strong) NSString *pullText;
@property (nonatomic, strong) UIColor *pullTextColor;
@property (nonatomic, strong) UIFont *pullTextFont;

@property (nonatomic, strong) NSString *refreshingText;
@property (nonatomic, strong) UIColor *refreshingTextColor;
@property (nonatomic, strong) UIFont *refreshingTextFont;


@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) CGFloat triggerOffset;
@property (nonatomic, assign) CGFloat triggerThreshold;

- (instancetype)initWithFrame:(CGRect)frame
                     pullText:(NSString *)pullText
                pullTextColor:(UIColor *)pullTextColor
                 pullTextFont:(UIFont *)pullTextFont
               refreshingText:(NSString *)refreshingText
          refreshingTextColor:(UIColor *)refreshingTextColor
           refreshingTextFont:(UIFont *)refreshingTextFont
                       action:(refreshAction)action;
- (void)endLoading;
@end
