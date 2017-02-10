//
//  HKTopicViewController.m
//  百思不得姐--001
//
//  Created by Mask on 16/6/29.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "HKTopicViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "HKTopic.h"
#import "HKTopicCell.h"
#import "HKCommentViewController.h"

/*
 先加载更多  同时又刷新数据   5
 刷新先回来: 页码清0  数据为第一页新数据
 加载更多回来了: 加入第6页的数据  页码变为 1
 
 重复发送请求有很多的坑!!
 我们开发人员!要避免用户重复发送请求!!
 */

@interface HKTopicViewController ()
/** 页码 */
@property(assign,nonatomic)NSInteger page;
/** 加载下一页时需要的参数 */
@property(copy,nonatomic)NSString * maxtime;

/** 段子帖子数据  */
@property(nonatomic,strong)NSMutableArray *  topics;

/** 请求参数  */
@property(nonatomic,strong)NSDictionary * params;

/** 上一次选中的索引(或者控制器) */
@property(assign,nonatomic)NSInteger lastSelectedIndex;


@end

@implementation HKTopicViewController
static  NSString * const HKTopicCellID = @"topicCell";

#pragma mark - <a参数>
-(NSString *)a
{
    return [self.parentViewController isKindOfClass:NSClassFromString(@"HKNewViewController")] ? @"newlist" :@"list";
}


-(NSMutableArray *)topics
{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加刷新控件
    [self setupRefresh];
    
    //初始化tableView
    [self setupTableView];
    
    //注册通知
    [HKNoteCenter addObserver:self selector:@selector(tabBarSelect) name:HKTabBarDidSelectNotification object:nil];
}

//接收到选中tabBar的通知
-(void)tabBarSelect
{
    //点击第二次并且是我所在的控制器而且在窗口上我就刷新!!
    if (self.lastSelectedIndex == self.tabBarController.selectedIndex
        &&self.tableView.isShowingOnWindow){
        //刷新
        [self.tableView.mj_header beginRefreshing];
    }
    //保存选中
    self.lastSelectedIndex = self.tabBarController.selectedIndex;
}

/**
 *  初始化tableView
 */
-(void)setupTableView
{
    
    //处理tableView
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//没有分割线
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //注册cell
    [self.tableView  registerNib:[UINib nibWithNibName:NSStringFromClass([HKTopicCell class]) bundle:nil] forCellReuseIdentifier:HKTopicCellID];
    
}



/**
 *  创建刷新控件
 */
-(void)setupRefresh
{
    //创建下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    //开始刷新
    [self.tableView.mj_header beginRefreshing];
    //根据位置设置半透明
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    //上拉加载更多
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    
}


/**
 *  加载更多数据
 */
-(void)loadMoreTopics
{
    //结束下拉刷新
    [self.tableView.mj_header endRefreshing];
    //url
    NSString * url = @"http://api.budejie.com/api/api_open.php";
    //参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;

    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"page"] = @(self.page);
    params[@"maxtime"] = self.maxtime;
    
    //存入参数
    self.params = params;
    
    //加载数据
    [[AFHTTPSessionManager manager] GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {//下载进度
        
    }success:^(NSURLSessionDataTask *task, NSDictionary * responseObject) {//下载完成!
        if (self.params != params) {//说明刚才发送过其他的请求
            return ;
        }
        //存maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //加页码
        self.page++;
        //拼接数据
        NSArray * arr = [HKTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:arr];
        //刷新数据
        [self.tableView reloadData];
        //上拉刷新控件
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {//出错了!
        [self.tableView.mj_footer endRefreshing];
    }];
    
}



/**
 *  加载新的帖子数据
 */
- (void)loadNewTopics {
    
    //结束上拉加载更多
    [self.tableView.mj_footer endRefreshing];
    //url
    NSString * url = @"http://api.budejie.com/api/api_open.php";
    //参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    //保存请求
    self.params = params;
    //加载数据
    [[AFHTTPSessionManager manager] GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {//下载进度
        
    } success:^(NSURLSessionDataTask *task, NSDictionary * responseObject) {//下载完成!
        if (self.params != params) {//说明刚才发送过其他的请求
            return ;
        }
        //页码清零
        self.page = 0;
        //获取数据
        [responseObject writeToFile:@"/Users/h/Desktop/项目实战/2016年07月11日/资料/hank.plist" atomically:YES];
        self.topics = [HKTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        //刷新表格
        [self.tableView reloadData];
        //存maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {//出错了!
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        
    }];
}



#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HKTopicCell * cell = [tableView dequeueReusableCellWithIdentifier:HKTopicCellID];
    //set方法
    cell.topic = self.topics[indexPath.row];
    return cell;
}

#pragma mark - <tableView代理>
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HKTopic * topic = self.topics[indexPath.row];
    return topic.cellHeight;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HKCommentViewController * commentVC = [[HKCommentViewController alloc]init];
    commentVC.topic = self.topics[indexPath.row];
    [self.navigationController pushViewController:commentVC animated:YES];
}






@end
