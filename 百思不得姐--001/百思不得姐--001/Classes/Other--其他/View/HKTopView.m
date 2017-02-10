//
//  HKTopView.m
//  百思不得姐--001
//
//  Created by Mask on 16/7/15.
//  Copyright © 2016年 Mask. All rights reserved.
//  iOS 9.0 以后状态栏的显示还是隐藏是由最顶层的window决定的!!
//  需要在顶层的window中的rootViewController 中设置不要隐藏

#import "HKTopView.h"


@implementation HKTopView
static UIWindow * window_;
+(void)show
{
    window_ = [[UIWindow alloc]init];
    window_.frame = CGRectMake(0, 0, ScreenWidth, 20);
    window_.backgroundColor = [UIColor clearColor];
    window_.windowLevel = UIWindowLevelAlert;
    //Hank 郑重声明!不要自定义Root控制器!用主窗口的根控制器!!!
    window_.rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
    
    window_.hidden = NO;
}




+(void)windowClick
{
    //1 取出控制器中ScrollView 进行滚动!!
    //拿到主窗口
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    [self searchSrollViewInView:window];
}


//递归遍历子控件
+(void)searchSrollViewInView:(UIView *)superView
{
    for (UIScrollView * subView in superView.subviews) {
        //如果是ScrollView,滚到顶部
        if ([subView isKindOfClass:[UIScrollView class]] && subView.isShowingOnWindow) {
            //滚动
            CGPoint offset = subView.contentOffset;
            offset.y = -subView.contentInset.top;
            [subView setContentOffset:offset animated:YES];
        }
        //继续查找子控制器
        [self searchSrollViewInView:subView];
    }
    
}





@end
