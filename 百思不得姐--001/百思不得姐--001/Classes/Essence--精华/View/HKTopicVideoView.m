//
//  HKTopicVideoView.m
//  百思不得姐--001
//
//  Created by Mask on 16/7/11.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "HKTopicVideoView.h"
#import "HKShowPictureController.h"
#import <UIImageView+WebCache.h>
#import "HKTopic.h"


@interface HKTopicVideoView ()
/** 内容图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** 播放次数 */
@property (weak, nonatomic) IBOutlet UILabel *palycountLabel;
/** 视频时长 */
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;

@end

@implementation HKTopicVideoView

-(void)setTopic:(HKTopic *)topic
{
    _topic = topic;
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.imageUrl]];
    //播放次数
    self.palycountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    //时长
    NSInteger minute = topic.videotime / 60 ;
    NSInteger second = topic.videotime % 60;
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    
}

+(instancetype)videoView
{
    //XIB加载View
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
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








@end
