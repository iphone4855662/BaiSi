//
//  HKPublishController.m
//  百思不得姐--001
//
//  Created by Mask on 16/7/9.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "HKPublishController.h"
#import "HKVerticalButton.h"
#import <POP.h>

static CGFloat const HKAnimationDelay = 0.1;
static CGFloat const HKSpringSpeed = 20;
static CGFloat const HKSpringBounciness = 15;

@interface HKPublishController ()
/** 标语  */
@property(nonatomic,weak)UIImageView * sloganView;

/** block */
//@property(copy,nonatomic)void (^animFinishBlock)() ;
@end

@implementation HKPublishController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //关闭交互
    self.view.userInteractionEnabled = NO;
    
    //添加那6个按钮
    //数据
    NSArray * imageNames = @[@"publish-video",@"publish-picture",@"publish-text",@"publish-audio",@"publish-review",@"publish-offline"];
    NSArray * titles = @[@"发视频",@"发图片",@"发段子",@"发声音",@"审帖",@"离线下载"];
    //按钮尺寸
    CGFloat btnW = 72;
    CGFloat btnH = btnW + 30;
    CGFloat startY = (ScreenHeight - 2 * btnH) * 0.5 ;
    CGFloat startX = 25;
    int  maxCols = 3;
    CGFloat buttonMargin = (ScreenWidth  - 2 * startX - maxCols * btnW)/(maxCols - 1);
    for (int i = 0; i < imageNames.count; i++) {
        //创建按钮
        HKVerticalButton * verticalBtn = [[HKVerticalButton alloc]init];
        verticalBtn.tag = i;
        //添加监听
        [verticalBtn addTarget:self action:@selector(verticalClick:) forControlEvents:(UIControlEventTouchUpInside)];
        //设置数据
        [verticalBtn setTitle:titles[i] forState:(UIControlStateNormal)];
        [verticalBtn setImage:[UIImage imageNamed:imageNames[i]] forState:(UIControlStateNormal)];
        [verticalBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        verticalBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        //布局
        int col = i % maxCols;
        int row = i / maxCols;
        CGFloat X = startX + (btnW + buttonMargin) * col;
        CGFloat Y = startY + row * btnH;
        //添加到控制器上
        [self.view addSubview:verticalBtn];
        
        //添加一些动画!!
        //POP动画可以直接改变控件的Frame
        CGFloat animStartY = -btnH;
        POPSpringAnimation * anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.springSpeed = HKSpringSpeed;
        anim.springBounciness = HKSpringBounciness;
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(X, animStartY, btnW, btnH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(X, Y, btnW, btnH)];
        //演示开始动画
        anim.beginTime = CACurrentMediaTime() + i * HKAnimationDelay;
        
        //添加动画
        [verticalBtn pop_addAnimation:anim forKey:nil];
    }
    //创建标语
    UIImageView * slogan = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    CGFloat centerEndX = ScreenWidth * 0.5;
    CGFloat centerEndY = ScreenHeight * 0.2;
    CGFloat centerBeginY = -slogan.height * 0.5;
    [self.view addSubview:slogan];
    self.sloganView = slogan;
    //添加动画
    POPSpringAnimation * anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.springSpeed = HKSpringSpeed;
    anim.springBounciness = HKSpringBounciness;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerEndX, centerBeginY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerEndX, centerEndY)];
    anim.beginTime = CACurrentMediaTime() + imageNames.count * HKAnimationDelay;
    [slogan pop_addAnimation:anim forKey:nil];
    //设置block属性
    [anim setCompletionBlock:^(POPAnimation * anim, BOOL finish) {
        //动画结束就来到这里
        self.view.userInteractionEnabled = YES;
        
    }];
}

/**
 *  6个按钮的点击
 */
-(void)verticalClick:(UIButton *)btn
{
    [self cancle];
    if (btn.tag == 2) {
        [self cancleAnimaFinishBlock:^{
            NSLog(@"发段子");
        }];
    }
    if (btn.tag == 0){
        [self cancleAnimaFinishBlock:^{
            NSLog(@"发视频");
        }];
    }
}

/**
 *  自定义一个取消动画结束的方法
 *
 *  @param animFinishBlock 动画结束回调
 */
-(void)cancleAnimaFinishBlock:(void(^)())animFinishBlock
{
    //一开始动画就不让点击
    self.view.userInteractionEnabled = NO;
    //拿到内部所有的子控件!!
    for (int i = 2; i < self.view.subviews.count; i++) {
        //拿出子控件
        UIView * subView = self.view.subviews[i];
        //动画处理
        POPBasicAnimation * anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subView.centerX, ScreenHeight + subView.height)];
        anim.beginTime = CACurrentMediaTime() + (i - 2) * HKAnimationDelay;
        [subView pop_addAnimation:anim forKey:nil];
        //最后一个动画执行完毕了回调!
        if(i == (self.view.subviews.count - 1)){
            [anim setCompletionBlock:^(POPAnimation * anim , BOOL finish) {
                //干掉发布界面
                [self dismissViewControllerAnimated:NO completion:nil];
                //动画执行完毕!!
//                if (animFinishBlock) {
//                    animFinishBlock();
//                }
                !animFinishBlock? :animFinishBlock();
            }];
        }
    }
}


/**
 *  控制器View的点击
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self cancleAnimaFinishBlock:nil];
}

/**
 *  取消按钮点击
 */
- (IBAction)cancle {
    [self cancleAnimaFinishBlock:nil];
}








@end
