//
//  BTDownMoreLoadFile.h
//  BTProject
//
//  Created by 明桐的Mac on 16/3/27.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTNetProtoBase.h"

typedef void (^downloadFileSuccessBlock)(id obj);
typedef void (^downloadFilefailedBlock)();

@interface BTDownMoreLoadFile : BTNetProtoBase
+ (BTDownMoreLoadFile *)shareDownMoreLoadFile;
- (void)downMoreLoadFile: (NSMutableArray *)fileArray success:(downloadFileSuccessBlock)success failed:(downloadFilefailedBlock)failed;

@end
