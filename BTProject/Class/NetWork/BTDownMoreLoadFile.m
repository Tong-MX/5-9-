//
//  BTDownMoreLoadFile.m
//  BTProject
//
//  Created by 明桐的Mac on 16/3/27.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTDownMoreLoadFile.h"
static BTDownMoreLoadFile *downMoreLoadFile = nil;
@interface BTDownMoreLoadFile()

@property (nonatomic, strong) downloadFileSuccessBlock successBlock;
@property (nonatomic, strong) downloadFilefailedBlock failBlock;
@property (nonatomic, strong) NSString * mFileSubfix;
@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) NSMutableArray *dateArry;
@end
@implementation BTDownMoreLoadFile
+ (BTDownMoreLoadFile *)shareDownMoreLoadFile {
    static dispatch_once_t onceDownFile;
    dispatch_once(&onceDownFile, ^{
        downMoreLoadFile = [[BTDownMoreLoadFile alloc] init];
    });
    return downMoreLoadFile;
}
- (void)downMoreLoadFile: (NSMutableArray *)fileArray success:(downloadFileSuccessBlock)success failed:(downloadFilefailedBlock)failed{
    
    self.successBlock = success;
    self.failBlock = failed;
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(downloadFile:) object:fileArray];
    [thread start];
    
    
}
- (void)downloadFile:(NSMutableArray *)array {
    if (array == nil || array.count == 0) {
        self.failBlock();
        return;
    }
    self.dateArry = [NSMutableArray array];
    for (NSString * tmp in array) {
        
        NSURL *url = [[NSURL alloc] initWithString:tmp];
        self.data = [NSData dataWithContentsOfURL:url];
        [self.dateArry addObject:_data];
    }
    if (_data != nil) {
        self.successBlock(self.dateArry);
    }else{
        self.failBlock();
    }
    return;
    
    
    
}
@end
