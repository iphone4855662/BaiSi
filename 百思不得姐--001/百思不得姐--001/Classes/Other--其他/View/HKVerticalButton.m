//
//  HKVerticalButton.m
//  百思不得姐--001
//
//  Created by Mask on 16/7/9.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "HKVerticalButton.h"

@implementation HKVerticalButton

/**
 *  初始化代码
 */
-(void)setup
{
    //初始化代码
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self setup];
    }
    return self;
}

-(void)awakeFromNib
{
    [self setup];
}



//我自己的frame发生变化.就会来到这里
-(void)layoutSubviews
{
    [super layoutSubviews];
    //布局 图片
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    //布局文字
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.imageView.height;
}

@end
