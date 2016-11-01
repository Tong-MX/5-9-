//
//  BTHeadOtherView.h
//  BTProject
//
//  Created by 明桐的Mac on 16/3/27.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BTCollectionViewButtonDelegate<NSObject>
- (void)collectionWithButtonclickTag:(NSIndexPath*)tagIndexPath;
@end
@interface BTHeadOtherView : UIView

@property (nonatomic ,strong)NSDictionary *bannerCategoryDic;
@property (nonatomic ,assign)id<BTCollectionViewButtonDelegate>delegate;
@property (nonatomic ,strong)NSIndexPath *titleScolleIndexPath;
@end
