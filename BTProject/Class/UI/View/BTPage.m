//
//  BTPage.m
//  BTProject
//
//  Created by 明桐的Mac on 16/3/27.
//  Copyright © 2016年 小谩的Mac. All rights reserved.
//

#import "BTPage.h"

@implementation BTPage

- (id)initWithCurrentImage:(UIImage*)currentImage normalImage:(UIImage*)image {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.activeImage = currentImage;
        
        self.inactiveImage = image;
    }
    return self;
}

-(void) updateDots

{
    for (int i=0; i<[self.subviews count]; i++) {
        
        UIImageView* dot = [self.subviews objectAtIndex:i];
        
        CGSize size;
        
        size.height = 5;     //自定义圆点的大小
        
        size.width = 5;      //自定义圆点的大小
        [dot setFrame:CGRectMake(dot.frame.origin.x, dot.frame.origin.y, size.width, size.width)];
        for (UIImageView* imageView in dot.subviews) {
            [imageView removeFromSuperview];
        }
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, dot.width, dot.height)];
        imageView.backgroundColor = [UIColor clearColor];
        [dot addSubview:imageView];
        if (i==self.currentPage)imageView.image = self.activeImage;
        
        else imageView.image = self.inactiveImage;
    }
    
}

-(void) setCurrentPage:(NSInteger)page

{
    [super setCurrentPage:page];
    
    [self updateDots];
    
}


@end
