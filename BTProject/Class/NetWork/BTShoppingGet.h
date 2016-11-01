//
//  BTShoppingGet.h
//  BTProject
//
//  Created by 明桐的Mac on 16/4/30.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTNetProtoBase.h"

@interface BTShoppingGet : BTNetProtoBase
@property (nonatomic, assign)NSInteger status;
@property (nonatomic, strong)NSString  *msg;
@property (nonatomic, strong)NSDictionary *data;
@property (nonatomic, strong)NSString *titleStr;
@property (nonatomic, strong)NSString *descStr;
@property (nonatomic, strong)NSString *picUrl;
@property (nonatomic, strong)NSArray *productArr;
@property (nonatomic, strong)NSMutableArray *productMtable;
- (void)getShoppingListWithOs_versions :(NSString*)os_versions ScreenSize:(CGFloat)screensize TRACK_device_info:(NSString*)track_device_info SID:(NSString*)sid netReachabilityType:(BTNetProtoBaseBlock)netReachabilityType;
@end
