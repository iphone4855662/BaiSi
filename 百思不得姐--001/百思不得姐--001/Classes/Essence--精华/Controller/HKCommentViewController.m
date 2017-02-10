//
//  HKCommentViewController.m
//  百思不得姐--001
//
//  Created by Mask on 16/7/13.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "HKCommentViewController.h"
#import "HKTopicCell.h"
#import "HKTopic.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import "HKComment.h"
#import <MJExtension.h>
#import "HKCommentHeaderView.h"
#import "HKCommentCell.h"

@interface HKCommentViewController ()<UITableViewDelegate,UITableViewDataSource>
//工具条底部的约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
/** tableView */
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 最热评论数组  */
@property(nonatomic,strong)NSArray * hotComments;
/** 最新评论  */
@property(nonatomic,strong)NSMutableArray * latestCommmtens;
/** 保存模型中的最热评论  */
@property(nonatomic,strong)NSArray * saveTopCmt;

/** 当前的页码 */
@property(assign,nonatomic)NSInteger page;

/** 请求管理者  */
@property(nonatomic,strong)AFHTTPSessionManager * manager;
@end

static NSString * const  HKCommentID = @"comment";

@implementation HKCommentViewController


-(AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化
    [self setupBasic];
    //创建头部View
    [self setupHeader];
    //添加刷新控件
    [self setupRefresh];
    
    
}

/**
 *  添加刷新控件
 */
-(void)setupRefresh
{
    //添加下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
    //添加上拉加载更多
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMroeComments)];
    //一进来哥么隐藏先
    self.tableView.mj_footer.hidden = YES;
    
}


/**
 *  加载更多评论数据
 */
-(void)loadMroeComments
{
    //结束之前的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    
    //参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"page"] = @(self.page);
    HKComment * cmt = [self.latestCommmtens lastObject];
    params[@"lastcid"] = cmt.ID;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php"
 parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {//成功
        //页码++
        self.page += 1;
        //最新评论
         NSArray * temArr = [HKComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestCommmtens addObjectsFromArray:temArr];
        
        [self.tableView reloadData];
        
        //控制footer 的状态
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestCommmtens.count >= total) {//加载完毕
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else {
            [self.tableView.mj_footer endRefreshing];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"哥么加载更多数据失败了!!");
        [self.tableView.mj_footer endRefreshing];
    }];

}

/**
 *  加载新的评论
 */
-(void)loadNewComments
{
    //结束之前所有的请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //参数
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id   _Nullable responseObject) {//成功
        self.page = 1;
        //结束刷新
        [self.tableView.mj_header endRefreshing];
        
        //有没有评论
        if (![responseObject isKindOfClass:[NSDictionary class]]) return ;
        
        self.hotComments = [HKComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        //最新评论
        self.latestCommmtens = [HKComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableView reloadData];
        //评论的总数
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestCommmtens.count >= total) {//加载完毕
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}


/**
 *  创建头部View
 */
-(void)setupHeader
{
    //创建Header
    UIView * header = [[UIView alloc]init];
    //添加Cell
    HKTopicCell * cell = [HKTopicCell cell];
    self.saveTopCmt = self.topic.top_cmt;
    self.topic.top_cmt = nil;
    cell.topic  = self.topic;
    [cell.topic setValue:@0 forKey:@"cellHeight"];
    cell.size = CGSizeMake(ScreenWidth, self.topic.cellHeight);
    [header addSubview:cell];
    //header高度
    header.height = self.topic.cellHeight + HKTopicCellMargin;
    self.tableView.tableHeaderView = header;
}



/**
 *  初始化代码
 */
-(void)setupBasic
{
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageNamed:@"comment_nav_item_share_icon" target:nil action:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.tableView.backgroundColor = HKGlobalColor;
    //注册Cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HKCommentCell class]) bundle:nil] forCellReuseIdentifier:HKCommentID];
    //设置cell高度自动计算  这个自适应必须是在iOS 8.0以后  苹果推荐应用!
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    //去掉分割线
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
}

- (void)keyboardWillChangeFrame:(NSNotification *)not {
    //取出键盘frame
    CGRect frame = [not.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //修改底部约束
    self.bottomConstraint.constant = ScreenHeight - frame.origin.y;
    //键盘的动画时间
    [UIView animateWithDuration:0.0 animations:^{
        [self.view layoutIfNeeded];
    }];
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    //恢复帖子的top_cmt
    if (self.saveTopCmt) {
        self.topic.top_cmt = self.saveTopCmt;
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    //取消所有任务
//    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.manager invalidateSessionCancelingTasks:YES];
}

#pragma mark - <代理>

//拖拽就会来到这里
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - <数据源>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger hotCount = self.hotComments.count;
    NSInteger latestCount = self.latestCommmtens.count;
    if (hotCount) return 2;
    if (latestCount) return 1;
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComments.count;
    //当前服务器返回这一页的最新评论的个数
    NSInteger latestCount = self.latestCommmtens.count;
    
    //隐藏加载更多控件
    tableView.mj_footer.hidden = (latestCount == 0);
    
    if (section == 0) {
        return hotCount ? hotCount : latestCount ;
    }
    if (section == 1) return latestCount;
    return 0;
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //缓存池取Header
    HKCommentHeaderView * header = [HKCommentHeaderView headerViewWithTableView:tableView];
    //设置label 数据
    NSInteger hotCount = self.hotComments.count;
    if (section == 0){
        header.title = hotCount? @"最热评论":@"最新评论";
    }else {
       header.title = @"最新评论";
    }
    return header;
}


//更具indexPath 拿到对应的模型数据
-(HKComment *)commentInIndextPath:(NSIndexPath *)indexPath
{
    NSArray * arr = nil;
    if (indexPath.section == 0) {
        arr = self.hotComments.count ? self.hotComments : self.latestCommmtens;
    }else{
       arr = self.latestCommmtens;
    }
    return arr[indexPath.row];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    HKCommentCell * cell = [tableView dequeueReusableCellWithIdentifier:HKCommentID];
    //给数据
    cell.comment = [self commentInIndextPath:indexPath];
    return cell;
}



@end
