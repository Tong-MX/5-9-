//
//  BTNetWorkZCPost.h
//  BTProject
//
//  Created by 明桐的Mac on 16/5/7.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTNetProtoBase.h"

@interface BTNetWorkZCPost : BTNetProtoBase
@property (nonatomic ,assign)NSInteger status;
@property (nonatomic ,strong)NSString  *msg;
@property (nonatomic ,strong)NSDictionary *data;
@property (nonatomic ,strong)NSMutableArray *recGroupsArr;
@property (nonatomic ,strong)NSMutableArray *inforArr;
@property (nonatomic ,strong)NSMutableArray *postListArr;
- (void)postPublicZClistWithOs_versions :(NSString*)os_versions ScreenSize:(CGFloat)screensize TRACK_device_info:(NSString*)track_device_info GroupId:(NSInteger)groupId netReachabilityType:(BTNetProtoBaseBlock)netReachabilityType;
@end
