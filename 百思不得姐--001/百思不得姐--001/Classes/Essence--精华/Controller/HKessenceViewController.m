//
//  HKessenceViewController.m
//  百思不得姐--001
//
//  Created by Mask on 16/6/25.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "HKessenceViewController.h"
#import "HKTopicViewController.h"

@interface HKessenceViewController ()<UIScrollViewDelegate>

/** 指示器  */
@property(nonatomic,weak)UIView * indicator;
/** 按钮  */
@property(nonatomic,weak)UIButton * selectBtn;
/** 头部标题栏  */
@property(nonatomic,weak)UIView * titleView;
/** 内容View  */
@property(nonatomic,weak)UIScrollView * contentView;

@end

@implementation HKessenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化子控制器
    [self setupChildVcs];
    
    //初始化顶部标题栏
    [self setupTitleView];
    
    //初始化导航栏
    [self setupNav];
    
    
    //初始化内容ScrollView
    [self setupScrollView];
    
}

/**
 *  初始化子控制器
 */
-(void)setupChildVcs
{
    
    HKTopicViewController * all = [[HKTopicViewController alloc]init];
    all.title = @"全部";
    all.type = HKTopicTypeAll;
    [self addChildViewController:all];

    HKTopicViewController * video = [[HKTopicViewController alloc]init];
    video.title = @"视频";
    video.type = HKTopicTypeVideo;
    [self addChildViewController:video];
    
    HKTopicViewController * voice = [[HKTopicViewController alloc]init];
    voice.title = @"声音";
    voice.type = HKTopicTypeVoice;
    [self addChildViewController:voice];
    
    HKTopicViewController * picture = [[HKTopicViewController alloc]init];
    picture.title = @"图片";
    picture.type = HKTopicTypePicture;
    [self addChildViewController:picture];
    
    HKTopicViewController * word = [[HKTopicViewController alloc]init];
    word.title = @"段子";
    word.type = HKTopicTypeWord;
    [self addChildViewController:word];
    


}


/**
 *  初始化内容ScrollView
 */
-(void)setupScrollView
{
    
    UIScrollView * contentView = [[UIScrollView alloc]init];
    //让ScrollView分页显示
    contentView.pagingEnabled = YES;
    contentView.delegate = self;
    self.contentView = contentView;
    contentView.frame = [UIScreen mainScreen].bounds;
    //滚动区域
    contentView.contentSize = CGSizeMake(self.childViewControllers.count * contentView.width, 0);

    //关闭系统帮你设置Inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view insertSubview:contentView atIndex:0];
    
    //加载第一个子控制器
    [self scrollViewDidEndScrollingAnimation:contentView];
    
}



/**
 *  初始化导航栏
 */
- (void)setupNav {
    //设置导航栏的图片
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //设置左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageNamed:@"MainTagSubIcon" target:nil action:nil];
    
    //设置颜色
    self.view.backgroundColor = HKGlobalColor;
    [self.view addSubview:[[UISwitch alloc]init]];
}


/**
 *  初始化顶部标题栏
 */
-(void)setupTitleView
{
    
    
    UIView * titleView = [[UIView alloc]init];
    self.titleView = titleView;
    titleView.width = self.view.width;
    titleView.height = 35;
    titleView.y = self.navigationController.navigationBar.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    
    [self.view addSubview:titleView];
    
    //创建指示器
    UIView * indicatorView = [[UIView alloc]init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.y = titleView.height - indicatorView.height;
    self.indicator = indicatorView;
    
    
    //添加子标题
    NSArray * childs = self.childViewControllers;
   CGFloat btnWidth = titleView.width / childs.count;
    CGFloat btnHeight = titleView.height;
    
    for (int i = 0; i < childs.count ; i++) {
        //创建按钮
        UIButton * btn = [[UIButton alloc]init];
        btn.width = btnWidth;
        btn.height = btnHeight;
        btn.tag = i;
        btn.x = i * btnWidth;
        UIViewController * vc = childs[i];
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(titleSelect:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        if (i == 0) {
            btn.enabled = NO;
            self.selectBtn = btn;
            //设置指示器
            [btn layoutIfNeeded];
            self.indicator.width = btn.titleLabel.width;
            self.indicator.centerX = btn.centerX;
        }
        
        [titleView addSubview:btn];
    }
    //添加指示器
    [titleView addSubview:indicatorView];
}

/**
 *  选中指示器
 */
-(void)titleSelect:(UIButton *) btn{
    //挪动我的指示器
    [UIView animateWithDuration:0.25 animations:^{
        self.indicator.width = btn.titleLabel.width;
        self.indicator.centerX = btn.centerX;
    }];
    
    //变色
    self.selectBtn.enabled = YES;
    btn.enabled = NO;
    self.selectBtn = btn;
    
    
    //2.滚动contentView
    CGPoint offset = self.contentView.contentOffset;
    offset.x = btn.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}


#pragma mark - <ScrollView代理>

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //要知道加载哪一个控制器的View
    //根据偏移量来获得当前加载哪一个!!  偏移量/宽度 获得偏移了几个宽度
    NSInteger index = scrollView.contentOffset.x/scrollView.width;
    //取出当前控制器
    UITableViewController * vc = self.childViewControllers[index];
    //设置tableView的细节
    vc.tableView.height = scrollView.height;
    vc.tableView.y = 0;
    //控制器的View的坐标
    vc.tableView.x = scrollView.contentOffset.x;
    //添加View
    [scrollView addSubview:vc.tableView];
    //设置内边距
    CGFloat top = CGRectGetMaxY(self.titleView.frame);
    CGFloat bottom = HKTopicCellBottomBarH + HKTopicCellMargin;
    vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
}

//
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //点击对应的按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    //这种方式取Tag一定要注意! 如果tag为0.哥么直接返回自己!
//    [self.titleView viewWithTag:index];
    UIButton * btn = self.titleView.subviews[index];
    [self titleSelect:btn];
    //主动调用代理方法
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
}








@end
