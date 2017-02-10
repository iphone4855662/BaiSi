//
//  HKTopicVoiceView.m
//  百思不得姐--001
//
//  Created by Mask on 16/7/11.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "HKTopicVoiceView.h"
#import "HKTopic.h"
#import <UIImageView+WebCache.h>
#import "HKShowPictureController.h"

@interface HKTopicVoiceView ()
/** 内容图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** 播放次数 */
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
/** 播放时长 */
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;


@end


@implementation HKTopicVoiceView


+(instancetype)voiceView
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



-(void)setTopic:(HKTopic *)topic
{
    _topic = topic;
    //图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.imageUrl]];
    //播放次数
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd播放",topic.playcount];
    //时长
    NSInteger minute = topic.voicetime / 60 ;
    NSInteger second = topic.voicetime % 60;
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}



@end
