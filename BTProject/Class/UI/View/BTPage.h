//
//  BTPage.h
//  BTProject
//
//  Created by 明桐的Mac on 16/3/27.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BTPage : UIPageControl

@property (nonatomic, strong) UIImage* activeImage;

@property (nonatomic, strong) UIImage* inactiveImage;


- (id)initWithCurrentImage:(UIImage*)currentImage normalImage:(UIImage*)image;
@end
