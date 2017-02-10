//
//  HKPushGuideView.m
//  百思不得姐--001
//
//  Created by Mask on 16/6/29.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "HKPushGuideView.h"

@implementation HKPushGuideView

+(instancetype)guideView
{
    HKPushGuideView * guideView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
    return guideView;
}



//点击了我知道了
- (IBAction)click:(id)sender {
    [self removeFromSuperview];
    
}


+(void)show
{
    //判断版本号
    //获取版本号
    NSDictionary * info = [[NSBundle mainBundle] infoDictionary];
    NSString * key = @"CFBundleShortVersionString";
    NSString * currentVersion =  info[key];
    //思路:判断,如果这次运行的版本号 和上次的版本号不一样..那么哥么就显示引导页!
    //数据持续化!! 沙盒!!
    //拿出沙盒中的版本号
    NSString * sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    //判断版本号
    if (![currentVersion isEqualToString:sanboxVersion]) {//进来就是版本号更新了
        //创建引导页
        HKPushGuideView * push = [HKPushGuideView guideView];
        push.frame = [UIApplication sharedApplication].keyWindow.bounds;
        [[UIApplication sharedApplication].keyWindow addSubview:push];
        
        //新的版本号存入到沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        //立刻存储
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}



@end
