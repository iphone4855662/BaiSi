//
//  HKTopicPictureView.m
//  百思不得姐--001
//
//  Created by Mask on 16/7/6.
//  Copyright © 2016年 Mask. All rights reserved.
//  帖子的图片内容

#import "HKTopicPictureView.h"
#import <UIImageView+WebCache.h>
#import "HKTopic.h"
#import "HKProgressView.h"
#import <SVProgressHUD.h>
#import "HKShowPictureController.h"
@interface HKTopicPictureView ()
/* gif标识 **/
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/* 内容图片 **/
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/* 查看大图按钮 **/
@property (weak, nonatomic) IBOutlet UIButton *seeBigBtn;
/* 图片下载进度条 **/
@property (weak, nonatomic) IBOutlet HKProgressView *progressView;


@end

@implementation HKTopicPictureView

+(instancetype)pictureView
{
    //通过Xib加载View
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    
    
}

-(void)awakeFromNib
{
    //关闭autoresizing
    self.autoresizingMask = UIViewAutoresizingNone;
    //让图片开启交互
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
    
}


/**
 *  全屏显示图片
 */
-(void)showPicture
{
    //allco init  加载 XIB
    HKShowPictureController * showPicture = [[HKShowPictureController alloc]init];
    //传递数据
    showPicture.topic = self.topic;
    //moda
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}


-(void)setTopic:(HKTopic *)topic
{
    _topic = topic;
    //立刻显示进度值
    [self.progressView setProgress:topic.pictureProgress animated:YES];
    self.progressView.hidden = topic.isLoadImageFinish;
    
    //设置中间内容图片   更具URl
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.imageUrl]  placeholderImage:nil options:kNilOptions progress:^(NSInteger receivedSize, NSInteger expectedSize) {//图片下载进度
        topic.loadImageFinish = NO;
        topic.pictureProgress = 1.0 * receivedSize / expectedSize;
        [self.progressView setProgress:topic.pictureProgress animated:YES];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if(topic.isBigImage){
            //1.开启图形上下文
            UIGraphicsBeginImageContextWithOptions(topic.pictureViewFrame.size, YES, 0.0);
            //2.画图片
            // [image drawAtPoint:CGPointMake(0, 0)];
            CGFloat width = topic.pictureViewFrame.size.width;
            CGFloat height = width * image.size.height / image.size.width;
            [image drawInRect:CGRectMake(0, 0, width, height)];
            //3.获得图片
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            //4.关闭图形上下文
            UIGraphicsEndImageContext();
        }
        //完毕来到这里
        self.progressView.hidden = YES;
        topic.loadImageFinish = YES;
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"加载失败!"];
        }
        
    }];
    //gif标识显示隐藏
    self.gifView.hidden = !topic.isGif;
    //显示查看大图
    if (topic.isBigImage) {//大图处理
        self.seeBigBtn.hidden = NO;
        self.imageView.clipsToBounds = YES;//裁剪超出的部分
    }else{//不是大图
        self.seeBigBtn.hidden = YES;
    }
}

@end
