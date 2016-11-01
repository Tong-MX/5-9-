//
//  BTNetWorkTopOhterGet.h
//  BTProject
//
//  Created by 明桐的Mac on 16/4/8.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTNetProtoBase.h"

@interface BTNetWorkTopOhterGet : BTNetProtoBase
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,strong)NSString  *msg;

@property (nonatomic,strong)NSMutableArray *TopMutable;

- (void)getTopHomelistWithOs_versions :(NSString*)os_versions ScreenSize:(CGFloat)screensize TRACK_device_info:(NSString*)track_device_info Scene:(NSInteger)scene netReachabilityType:(BTNetProtoBaseBlock)netReachabilityType;
@end
