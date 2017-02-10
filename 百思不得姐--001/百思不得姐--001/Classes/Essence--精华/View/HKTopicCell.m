//
//  HKTopicCell.m
//  百思不得姐--001
//
//  Created by Mask on 16/7/3.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "HKTopicCell.h"
#import "HKTopic.h"
#import <UIImageView+WebCache.h>
#import "HKTopicPictureView.h"
#import "HKTopicVoiceView.h"
#import "HKTopicVideoView.h"
#import "HKComment.h"
#import "HKUser.h"
#import "UIImageView+HKExtension.h"

@interface HKTopicCell ()
/* 头像 **/
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/* 昵称 **/
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/* 时间 **/
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/* 顶 **/
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
/* 踩 **/
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
/* 分享 **/
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
/* 评论 **/
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
/* 新浪加V **/
@property (weak, nonatomic) IBOutlet UIImageView *sinaV;
/* 帖子文字内容 **/
@property (weak, nonatomic) IBOutlet UILabel *text_label;
/** 图片帖子中间的内容  */
@property(nonatomic,weak)HKTopicPictureView * pictureView;
/** 声音帖子中间的内容  */
@property(nonatomic,weak)HKTopicVoiceView * voiceView;
/** 视频帖子中间的内容  */
@property(nonatomic,weak)HKTopicVideoView * videoView;
/** 最热评论整体 */
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
/** 最热评论内容 */
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;

@end

@implementation HKTopicCell

+(instancetype)cell
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}


-(HKTopicVideoView *)videoView
{
    if (!_videoView) {
        HKTopicVideoView * videoView = [HKTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

/**
 *  声音帖子中间内容
 */
-(HKTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        HKTopicVoiceView * voiceView = [HKTopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
    
}


-(HKTopicPictureView *)pictureView
{
    if (!_pictureView) {
        HKTopicPictureView * pictureView = [HKTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    //设置背景图片
    self.backgroundView = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"mainCellBackground"] hk_resizableImage]];
    //设置头像的圆角
//    self.profileImageView.layer.cornerRadius = self.profileImageView.width * 0.5;
//    self.profileImageView.layer.masksToBounds = YES;
}

/* 模型的set方法 **/
-(void)setTopic:(HKTopic *)topic
{
    _topic = topic;
    //设置数据
    //处理最热评论
    HKComment * comment = topic.top_cmt.firstObject;
    if (comment) {//有最热评论
        self.topCmtView.hidden = NO;
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@",comment.user.username,comment.content];
    }else{//没有最热评论
        self.topCmtView.hidden = YES;
    }
    
    
    
    //设置帖子文字内容
    self.text_label.text = topic.text;
    
    //设置新浪加V
    self.sinaV.hidden = !topic.isSina_v;
    [self.profileImageView setHeader:topic.profile_image];
    
    
    self.nameLabel.text = topic.name;
    //设置时间
    self.timeLabel.text = topic.create_time;
    //底部工具条的按钮内容
    [self setBtnTitle:self.dingBtn count:topic.ding placeholder:@"顶"];
    [self setBtnTitle:self.caiBtn count:topic.cai placeholder:@"踩"];
    [self setBtnTitle:self.shareBtn count:topic.repost placeholder:@"分享"];
    [self setBtnTitle:self.commentBtn count:topic.comment placeholder:@"评论"];
    
    //根据类型进行判断 如果是图片我就添加PictureView
    if (topic.type == HKTopicTypePicture) {//图片
        self.pictureView.hidden = NO;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureViewFrame;
    }else if (topic.type == HKTopicTypeVoice){//音频
        self.pictureView.hidden = YES;
        self.voiceView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.topic = topic;
        self.voiceView.frame = topic.voiceViewFrame;
    }else if (topic.type == HKTopicTypeVideo){//视频
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoViewFrame;
    }else{//文字
        self.pictureView.hidden = YES;
        self.voiceView.hidden = YES;
        self.videoView.hidden = YES;
    }
}


/**
 *  设置工具条按钮文字
 *
 *  @param btn         按钮
 *  @param count       数据
 *  @param placeholder 占位文字
 */
-(void)setBtnTitle:(UIButton *)btn count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count > 9999) {
        placeholder = [NSString stringWithFormat:@"%.1f万",count/10000.0];
    }else if ( count > 0){
        placeholder = [NSString stringWithFormat:@"%zd",count];
    }
    [btn setTitle:placeholder forState:UIControlStateNormal];
}


-(void)setFrame:(CGRect)frame
{
//    NSLog(@"%s",__func__);
    frame.size.height = self.topic.cellHeight - HKTopicCellMargin;
    frame.origin.y += HKTopicCellMargin;
    frame.size.width -= 2 * HKTopicCellMargin;
    frame.origin.x = HKTopicCellMargin;
    
    [super setFrame:frame];
}



//建议大家
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

//点击更多
- (IBAction)more:(id)sender {
//    UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:@"举报" otherButtonTitles:@"收藏", nil];
//    
//    [sheet showInView:self.window];
    
    UIAlertController * alet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    [alet addAction:[UIAlertAction actionWithTitle:@"收藏" style:(UIAlertActionStyleDefault) handler: nil]];
    [alet addAction:[UIAlertAction actionWithTitle:@"举报" style:(UIAlertActionStyleDestructive) handler:nil]];
    [alet addAction:[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil]];

    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alet animated:YES completion:nil];
    
}

@end
