//
//  HKTopic.h
//  百思不得姐--001
//
//  Created by Mask on 16/7/1.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HKTopic : NSObject

/** id */
@property(copy,nonatomic)NSString * ID;

/** 帖子类型 */
@property(assign,nonatomic)HKTopicType type;
/** 名称 */
@property(copy,nonatomic)NSString * name;
/** 头像 */
@property(copy,nonatomic)NSString * profile_image;
/** 时间 */
@property(copy,nonatomic)NSString * create_time;
/** 文字 */
@property(copy,nonatomic)NSString * text;
/** 顶的数量 */
@property(assign,nonatomic)NSInteger ding;
/** 踩的数量 */
@property(assign,nonatomic)NSInteger cai;
/** 转发数量 */
@property(assign,nonatomic)NSInteger repost;
/** 评论数量 */
@property(assign,nonatomic)NSInteger comment;

/** 图片的高度 */
@property(assign,nonatomic)CGFloat height;
/** 图片的宽度 */
@property(assign,nonatomic)CGFloat width;
/** 是否为gif图片 */
@property(assign,nonatomic,getter=isGif)BOOL gif;

/** 图片的URl */
@property(copy,nonatomic)NSString * imageUrl;//image0
//@property(copy,nonatomic)NSString * image1;
//@property(copy,nonatomic)NSString * image_small;

/** 是否为sina加V用户 */
@property(assign,nonatomic,getter=isSina_v)BOOL sina_v;
/** 音频时长  返回的是秒 */
@property(assign,nonatomic)NSInteger  voicetime;
/** 播放次数 */
@property(assign,nonatomic)NSInteger playcount;
/** 视频时长 */
@property(assign,nonatomic)NSInteger videotime;


/** 最热评论数组  */
@property(nonatomic,strong)NSArray * top_cmt;



//辅助属性
// @property _cellHeight  get  set
/** Cell的高度 */
@property(assign,nonatomic,readonly)CGFloat cellHeight;
/** 是否为大图 */
@property(assign,nonatomic,getter=isBigImage)BOOL bigImage;
/** 图片下载进度 */
@property(assign,nonatomic)CGFloat pictureProgress;
/** 图片控件的frame */
@property(assign,nonatomic,readonly)CGRect pictureViewFrame;
/** 声音控件的frame */
@property(assign,nonatomic,readonly)CGRect voiceViewFrame;
/** 视频控件的frame */
@property(assign,nonatomic,readonly)CGRect videoViewFrame;
/** 图片下载完毕 */
@property(assign,nonatomic,getter=isLoadImageFinish)BOOL loadImageFinish;




@end
