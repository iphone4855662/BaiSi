//
//  UIBarButtonItem+HKExtension.m
//  百思不得姐--001
//
//  Created by Mask on 16/6/28.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "UIBarButtonItem+HKExtension.h"

@implementation UIBarButtonItem (HKExtension)


+(instancetype)itemWithImageNamed:(NSString *)imageName target:(id)target action:(SEL)action
{
    //设置左边的按钮
    UIButton * btn =[[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    //拼接一个字符串,获取高亮状态的图片名称
    NSString * highlightImageName = [imageName stringByAppendingString:@"-click"];
    [btn setImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
    btn.bounds = CGRectMake(0, 0, btn.currentImage.size.width, btn.currentImage.size.height);
    //添加  监听  btn 按钮的Events :单击 然后调用 Target:self 的Action:方法
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  [[UIBarButtonItem alloc]initWithCustomView:btn];
}


+(instancetype)backItemWithImageNamed:(NSString *)imageName title:(NSString *)title target:(id)target action:(SEL)action
{
    //设置左边的按钮
    UIButton * btn =[[UIButton alloc]init];
    //给按钮设置title
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
//    btn.backgroundColor = [UIColor redColor];
    //设置按钮的内容位置
        //内容向左对齐
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //内边距
    [btn setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    //拼接一个字符串,获取高亮状态的图片名称
    NSString * highlightImageName = [imageName stringByAppendingString:@"-click"];
    [btn setImage:[UIImage imageNamed:highlightImageName] forState:UIControlStateHighlighted];
    btn.bounds = CGRectMake(0, 0, btn.currentImage.size.width + 80, btn.currentImage.size.height);
    //添加  监听  btn 按钮的Events :单击 然后调用 Target:self 的Action:方法
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  [[UIBarButtonItem alloc]initWithCustomView:btn];
}



@end
