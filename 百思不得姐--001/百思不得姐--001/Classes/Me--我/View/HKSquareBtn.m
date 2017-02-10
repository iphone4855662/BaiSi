//
//  HKSquareBtn.m
//  百思不得姐--001
//
//  Created by Mask on 16/7/16.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "HKSquareBtn.h"
#import <UIButton+WebCache.h>
#import "HKSquare.h"

@implementation HKSquareBtn

/**
 *  初始化代码
 */
-(void)setup
{
    //初始化代码
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:(UIControlStateNormal)];
//    self.titleLabel.backgroundColor = [UIColor redColor];
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
    self.imageView.y = self.height * 0.2;
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    //布局文字
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

-(void)setSquare:(HKSquare *)square
{
    _square = square;
    //设置数据
    [self setTitle:square.name forState:(UIControlStateNormal)];
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:(UIControlStateNormal)];

}

@end
