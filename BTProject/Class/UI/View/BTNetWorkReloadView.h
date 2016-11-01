//
//  BTNetWorkReloadView.h
//  BTProject
//
//  Created by 明桐的Mac on 16/4/9.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTObjectView.h"

@protocol BTNetWorkReloadViewDelegate <NSObject>

- (void)reloadUI;

@end


@interface BTNetWorkReloadView : BTObjectView

@property (nonatomic, assign) id<BTNetWorkReloadViewDelegate>delegate;
@property (nonatomic, strong) UILabel *explanationLabel;

@end
