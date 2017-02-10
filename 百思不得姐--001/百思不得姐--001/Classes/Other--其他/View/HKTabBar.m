//
//  HKTabBar.m
//  百思不得姐--001
//
//  Created by Mask on 16/6/25.
//  Copyright © 2016年 Mask. All rights reserved.
//  alloc :分配内存空间  init:初始化属性

#import "HKTabBar.h"
#import "HKPublishController.h"

@interface HKTabBar ()

/** 发布按钮  */
@property(nonatomic,weak)UIButton * publishBtn;
@end

@implementation HKTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //创建子控件
        UIButton * publish = [[UIButton alloc]init];
        [publish setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publish setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon_click"] forState:UIControlStateHighlighted];
        //添加按钮监听
        [publish addTarget:self action:@selector(publishClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:publish];
        self.publishBtn = publish;
     
    }
    
    return self;
}


/** 发布按钮点击 */
-(void)publishClick
{
    //控制器alloc init 创建的时候 会首先找有没有同名的XIB!!
    HKPublishController * publishVC = [[HKPublishController alloc]init];
    //moda 控制器
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publishVC animated:NO completion:nil];
}



//用来布局子控件
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //布局子控件!!
    self.publishBtn.bounds = CGRectMake(0, 0, self.publishBtn.currentBackgroundImage.size.width, self.publishBtn.currentBackgroundImage.size.height);
    self.publishBtn.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
    //拿出子控件布局  UITabBarButton
    //注意点:UITabBarButton 是系统没有提供出来的一个类!!
    //
    int index = 0;
    CGFloat W = self.width * 0.2;
    CGFloat H = self.height;
    CGFloat Y = 0;
    for (UIView * view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
           //能来到这里面都是我想要的
            CGFloat X = W * ((index == 2)? ++index:index);//是为了让第2个跳一下
            view.frame = CGRectMake(X, Y, W, H);
            
            index++;
        }
        
    }
    
    
}


@end
