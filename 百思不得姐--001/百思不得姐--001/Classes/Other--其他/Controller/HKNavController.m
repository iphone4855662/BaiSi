//
//  HKNavController.m
//  百思不得姐--001
//
//  Created by Mask on 16/6/28.
//  Copyright © 2016年 Mask. All rights reserved.
//   代码像上挪动  cmd + alt + [

#import "HKNavController.h"
#import "HKBar.h"

@interface HKNavController ()

@end

@implementation HKNavController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationBarHidden = YES;
//
//    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 64)];
//    UIButton * btn = [[UIButton alloc]init];
//    [btn setImage:[UIImage imageNamed:@"cellFollowClickIcon"] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    btn.x = 20;
//    btn.y = 20;
//    btn.height = btn.currentImage.size.height;
//    btn.width  = btn.currentImage.size.width;
//    view.backgroundColor = [UIColor greenColor];
//    [view addSubview:btn];
//    [self.view addSubview:view];
}

/**
 *  当第一次来到这个类的时候回调用一次,今后不会再来了
 */
+(void)initialize
{
    //设置主题
    //可以指定类的主题!!
    UINavigationBar* bar =  [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class],]];
    
    [bar  setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
//    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:nil];
//    self.navigationBar.tintColor = [UIColor blackColor];
//    viewController.view;// 我们控制器的view 是懒加载.
    //自定义左上角返回按钮
    //需要判断:如果是栈底控制器,我们就不换
    if (self.childViewControllers.count > 0) {
        //哥么你要想隐藏.那么必须在我push之前给我设置

        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithImageNamed:@"navigationButtonReturn" title:@"返回" target:self action:@selector(back)];
    }
    
    //调用父类的方法
    [super pushViewController:viewController animated:animated];
}
-(void)back
{
    [self popViewControllerAnimated:YES];
}




@end
