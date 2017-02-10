//
//  HKRootController.m
//  百思不得姐--001
//
//  Created by Mask on 16/6/25.
//  Copyright © 2016年 Mask. All rights reserved.
//  2.0

#import "HKRootController.h"
#import "UIImage+HKExtension.h"
#import "HKTabBar.h"
#import "HKessenceViewController.h"
#import "HKNewViewController.h"
#import "HKFriendTrendsViewController.h"
#import "HKMeViewController.h"
#import "HKNavController.h"


@interface HKRootController ()

@end

@implementation HKRootController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加所有的子控制器
    [self addChildVCs];
    HKTabBar * tabBar = [[HKTabBar alloc]init];
    [self setValue:tabBar forKey:@"tabBar"];
    
    
    
    //主题设置
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
    
    
    UITabBarItem * itemAppearance = [UITabBarItem appearance];
    NSDictionary * dict = @{
                            NSForegroundColorAttributeName:[UIColor darkGrayColor]
                            };
    //选中状态
    [itemAppearance setTitleTextAttributes:dict forState:UIControlStateSelected];
    
}


/**
 *  添加所有的子控制器
 */
- (void)addChildVCs{
    //精华
    [self setUpChildViewController:[[HKessenceViewController alloc]init] title:@"精华" imageNamed:@"tabBar_essence_icon"];
    //新帖
     [self setUpChildViewController:[[HKNewViewController alloc]init] title:@"新帖" imageNamed:@"tabBar_new_icon"];
    //关注
     [self setUpChildViewController:[[HKFriendTrendsViewController alloc]init] title:@"关注" imageNamed:@"tabBar_friendTrends_icon"];
    //我
     [self setUpChildViewController:[[HKMeViewController alloc]initWithStyle:(UITableViewStyleGrouped)] title:@"我" imageNamed:@"tabBar_me_icon"];
}



//创建子控制的方法
-(void)setUpChildViewController:(UIViewController *)vc title:(NSString *)title imageNamed:(NSString *)imageName{
    //精华
    HKNavController * naVc = [[HKNavController alloc]initWithRootViewController:vc];
    vc.title = title;//相当于上面两句
    vc.tabBarItem.image = [UIImage imageNamed:imageName];
    NSString * selectImageName = [imageName stringByAppendingString:@"_click"];
    vc.tabBarItem.selectedImage = [UIImage hk_originarImageNamed:selectImageName];
    //给TabBarController 添加子控制器
    [self addChildViewController:naVc];
}

@end
