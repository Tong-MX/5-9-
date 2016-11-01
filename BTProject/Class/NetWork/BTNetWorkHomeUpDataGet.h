//
//  BTNetWorkHomeUpDataGet.h
//  BTProject
//
//  Created by 明桐的Mac on 16/4/10.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTNetProtoBase.h"

@interface BTNetWorkHomeUpDataGet : BTNetProtoBase
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,strong)NSString  *msg;
@property (nonatomic,strong)NSMutableArray *TopMutable;

- (void)getHomelistWithOs_versions :(NSString*)os_versions ScreenSize:(CGFloat)screensize TRACK_device_info:(NSString*)track_device_info Page:(NSInteger)page UPData :(CGFloat)updataTime netReachabilityType:(BTNetProtoBaseBlock)netReachabilityType;
@end
