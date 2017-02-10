//
//  HKNewViewController.m
//  百思不得姐--001
//
//  Created by Mask on 16/6/25.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "HKNewViewController.h"


@interface HKNewViewController ()

@end

@implementation HKNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏的图片
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //设置左边的按钮
    self.navigationItem.leftBarButtonItem  = [UIBarButtonItem itemWithImageNamed:@"MainTagSubIcon" target:nil action:nil];
    //设置颜色
    self.view.backgroundColor = HKGlobalColor;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
