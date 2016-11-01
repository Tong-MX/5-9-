//
//  NetWorkHomeGet.h
//  BTProject
//
//  Created by 明桐的Mac on 16/3/23.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTNetProtoBase.h"

@interface BTNetWorkHomeGet : BTNetProtoBase
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,strong)NSString  *msg;
@property (nonatomic,strong)NSDictionary *data;
@property (nonatomic,strong)NSArray *banner;
@property (nonatomic,strong)NSArray *banner_bottom_element;
@property (nonatomic,strong)NSArray *category_element;
@property (nonatomic,strong)NSArray *topic;
@property (nonatomic,strong)NSArray *firstpage;
//以上是解析data存的数据
//一下是为了映射model存的数据
@property (nonatomic,strong)NSMutableArray *bannerArray;
@property (nonatomic,strong)NSMutableArray *banner_bottom_elementArray;
@property (nonatomic,strong)NSMutableArray *category_elementArray;

@property (nonatomic,strong)NSMutableArray *topicArray;
@property (nonatomic,strong)NSMutableArray *firstpageArray;
@property (nonatomic,strong)id temp;

- (void)getHomelistWithOs_versions :(NSString*)os_versions ScreenSize:(CGFloat)screensize TRACK_device_info:(NSString*)track_device_info netReachabilityType:(BTNetProtoBaseBlock)netReachabilityType;
@end
