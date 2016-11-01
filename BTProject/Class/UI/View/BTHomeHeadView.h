//
//  BTHomeHeadView.h
//  BTProject
//
//  Created by 明桐的Mac on 16/3/26.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BTHomeHeadWithButtonClickDelegate<NSObject>
- (void)homeHeadWithButtonTag:(NSIndexPath*)tagIndexPath;
- (void)homeHeadWithExtendData:(NSString*)extendData TitleStr:(NSString*)titleStr clickTag:(NSInteger)clickTag;
@end
@interface BTHomeHeadView : UIView<UIScrollViewDelegate>

@property (nonatomic ,strong)NSDictionary *headScrolleDic;
@property (nonatomic ,strong)NSDictionary *bannerCategoryDic;
@property (nonatomic ,assign)id<BTHomeHeadWithButtonClickDelegate>delegate;
@property (nonatomic ,strong)NSIndexPath *titleScolleIndexPath;
@end
