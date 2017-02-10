//
//  HKMeFooterView.m
//  百思不得姐--001
//
//  Created by Mask on 16/7/16.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "HKMeFooterView.h"
#import <AFNetworking.h>
#import "HKSquare.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
#import "HKSquareBtn.h"
#import "HKWebViewController.h"

@implementation HKMeFooterView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        //url
        NSString * url = @"http://api.budejie.com/api/api_open.php";
        //参数
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        params[@"a"] = @"square";
        params[@"c"] = @"topic";
        //发送请求
        [[AFHTTPSessionManager manager] GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {//下载进度
        } success:^(NSURLSessionDataTask *task, NSDictionary * responseObject) {
            NSArray * squares = [HKSquare mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            
            [self createSquares:squares];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {//出错了!
         
            
        }];
        
    }
    return self;
}


/**
 *  创建方块
 */
-(void)createSquares:(NSArray *)squares
{
    
    int maxcols = 4;
    //宽度&高度
    CGFloat btnW = ScreenWidth / maxcols;
    CGFloat btnH = btnW;
    
    for (int i = 0; i < squares.count; i ++) {
        
        HKSquareBtn * btn = [[HKSquareBtn alloc]init];
        [self addSubview:btn];
        //设置模型
        btn.square = squares[i];
        //计算位置
        int col = i % maxcols;
        int row = i / maxcols;
        btn.x = col * btnW;
        btn.y = row * btnH;
        btn.width = btnW;
        btn.height = btnH;
               //添加按钮的点击事件!!
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    
    //
    self.height = ((squares.count + maxcols - 1) / maxcols) * btnH;
    // (12 + 3)/ 4  == 3
    //占了多少行 = (总个数 + 每行最大值 - 1)/ 每行最大值
   
    
    //重绘
    [self setNeedsDisplay];
}

-(void)btnClick:(HKSquareBtn *)btn
{
    if( ![btn.square.url hasPrefix:@"http"]) return;
    
    HKWebViewController * web = [[HKWebViewController alloc]init];
    web.title = btn.square.name;
    web.url = btn.square.url;
    
    //跳转控制器
    UITabBarController * tabBar = (UITabBarController *) [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController * nav = (UINavigationController *) tabBar.selectedViewController;
    [nav pushViewController:web animated:YES];  
}

@end
