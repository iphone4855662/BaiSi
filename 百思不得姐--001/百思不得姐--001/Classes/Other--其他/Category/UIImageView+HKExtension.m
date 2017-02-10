//
//  UIImageView+HKExtension.m
//  百思不得姐--001
//
//  Created by Mask on 16/7/15.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "UIImageView+HKExtension.h"
#import <UIImageView+WebCache.h>

@implementation UIImageView (HKExtension)

-(void)setHeader:(NSString *)url
{
   [self  sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[[UIImage imageNamed:@"defaultUserIcon"] circleImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {//成功
    self.image = [image circleImage];
   }];

}

@end
