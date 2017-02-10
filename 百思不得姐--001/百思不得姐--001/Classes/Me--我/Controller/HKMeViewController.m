//
//  HKMeViewController.m
//  百思不得姐--001
//
//  Created by Mask on 16/6/25.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "HKMeViewController.h"
#import "HKMeCell.h"
#import "HKMeFooterView.h"

static NSString * HKMeID = @"me";
@interface HKMeViewController ()

@end

@implementation HKMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    [self setupTableView];
    
}

-(void)setupTableView
{
    //注册
    [self.tableView registerClass:[HKMeCell class] forCellReuseIdentifier:HKMeID];
    //调整tableviewViewController的header 和footer
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = HKTopicCellMargin;
    //设置footer
    self.tableView.tableFooterView = [[HKMeFooterView alloc]init];
    self.tableView.tableFooterView.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 200, 0);
}

-(void)setupNav
{
    //设置title
    self.navigationItem.title = @"我的";
    //设置右边item
    self.navigationItem.rightBarButtonItems = @[
                                                [UIBarButtonItem itemWithImageNamed:@"mine-setting-icon" target:nil action:nil],
                                                [UIBarButtonItem itemWithImageNamed:@"mine-moon-icon" target:nil action:nil]
                                                ];
    
    //设置颜色
    self.view.backgroundColor = HKGlobalColor;
}

#pragma mark - <数据源>
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HKMeCell * cell = [tableView dequeueReusableCellWithIdentifier:HKMeID];
    if (indexPath.section == 0) {
        cell.textLabel.text = @"登录/注册";
        cell.imageView.image = [UIImage imageNamed:@"publish-audio"];
    }else if(indexPath.section == 1){
        cell.textLabel.text = @"离线下载";
    }
    
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
