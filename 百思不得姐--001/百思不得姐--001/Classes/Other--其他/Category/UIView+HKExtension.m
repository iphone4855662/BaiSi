//
//  UIView+HKExtension.m
//  百思不得姐--001
//
//  Created by Mask on 16/6/28.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "UIView+HKExtension.h"

@implementation UIView (HKExtension)





-(BOOL)isShowingOnWindow
{
    //主窗口
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    //以主窗口左上角为坐标原点,计算self的frame
    //传nil 默认就是主窗口!!
    CGRect newFrame = [self.superview convertRect:self.frame toView:nil];
    CGRect winFrame = window.bounds;
    
    //主窗口的bounds 和 self 的frame 是否有重叠
    return  !self.isHidden && self.alpha > 0.01 &&   CGRectIntersectsRect(newFrame, winFrame);
}


//X
-(CGFloat)x
{
    return self.frame.origin.x;
}
-(void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


//Y
-(CGFloat)y
{
    return self.frame.origin.y;
}
-(void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

//尺寸
-(CGSize)size
{
    return self.frame.size;
}
-(void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


//宽度
-(CGFloat)width
{
    return  self.frame.size.width;
}

-(void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


//高度
-(CGFloat)height
{
    return  self.frame.size.height;
}

-(void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

//中心X
-(CGFloat)centerX
{
    return  self.center.x;
}

-(void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

//中心点Y
-(CGFloat)centerY
{
    return  self.center.y;
}

-(void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}



@end
