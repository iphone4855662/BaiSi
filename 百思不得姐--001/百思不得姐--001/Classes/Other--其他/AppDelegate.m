//
//  AppDelegate.m
//  百思不得姐--001
//
//  Created by Mask on 16/6/25.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "AppDelegate.h"
#import "HKPushGuideView.h"
#import "HKRootController.h"
#import "HKTopView.h"

@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


//程序启动完毕调用
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //1.创建一个不会被销毁的Window(继承UIView)
    self.window = [[UIWindow alloc]init];
    //2.设置window的根控制器
    HKRootController * rootC =  [[HKRootController alloc]init];
    //设置根控制器的代理
    rootC.delegate = self;
    self.window.rootViewController = rootC;
    //3.让window现实并且设置为主窗口
    [self.window makeKeyAndVisible];
    
    //显示引导页
//    [HKPushGuideView show];
    //添加一个window,点击这个window,可以让屏幕上的ScrollView 滚动到最顶部
    [HKTopView show];
    return YES;
}

#pragma mark - <代理>
//你现在选中了哪一个控制器
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
//    //通知参数
//    NSMutableDictionary * userInfo = [NSMutableDictionary dictionary];
//    userInfo[HKSelectedControllerKey] = viewController;
//    userInfo[HKSelectedControllerIndexKey] = @(tabBarController.selectedIndex);
    //发出通知
    [HKNoteCenter postNotificationName:HKTabBarDidSelectNotification object:nil userInfo:nil];
}


@end
