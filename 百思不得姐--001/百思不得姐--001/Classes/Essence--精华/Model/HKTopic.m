//
//  HKTopic.m
//  百思不得姐--001
//
//  Created by Mask on 16/7/1.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "HKTopic.h"
#import "NSDate+HKExtension.h"
#import <MJExtension.h>
#import "HKComment.h"
#import "HKUser.h"


@implementation HKTopic
{
    CGFloat _cellHeight;
    CGRect _pictureViewFrame;
}

//告诉框架 数组里面装的是什么东西!!
+(NSDictionary *)mj_objectClassInArray
{
    return @{
      @"top_cmt":[HKComment class]
      };
}

//告诉字典转模型框架.你的模型里面哪一个属性 对应服务器的某一个字段!!
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"imageUrl"] = @"image0";
    dict[@"gif"] = @"is_gif";
    dict[@"ID"] = @"id";
    return dict;
}


-(NSString *)create_time
{
    // 发帖时间: 2016-07-02 17:53:36  NSString
    NSDateFormatter * fmt = [[NSDateFormatter alloc]init];
    //y:年  M:月  d:天  H:时  m:分  s:秒
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate * create = [fmt dateFromString:_create_time];
    if (create.isThisYear) {//就是今年
        if (create.isToday) {//今天
            NSDateComponents * cmps = [[NSDate date] dateFrom:create];
            if(cmps.hour >= 1){//其他的情况
                return [NSString stringWithFormat:@"%zd小时以前",cmps.hour];
            }else if(cmps.minute >= 1){//一小时以内
                return [NSString stringWithFormat:@"%zd分钟以前",cmps.minute];
            }else{//一分钟以内
                return @"刚刚";
            }
        }else if (create.isYesterday){//昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        }else{//其他时间
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
        
    }else{//不是今年!!
        return _create_time;
    }
    return @"不合法时间";
}



//cell高度
-(CGFloat)cellHeight
{
    //判断
    if(!_cellHeight){
        /** ====================计算Cell的高度  ==========================*/
        CGFloat lableW = [UIScreen mainScreen].bounds.size.width - 4 * HKTopicCellMargin;
        //文字lable的高度
        CGSize MaxSize = CGSizeMake(lableW, MAXFLOAT);
        CGFloat lableH = [self.text boundingRectWithSize:MaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        //p文字帖子的高度
        _cellHeight = lableH + HKTopicCellTextY + 2 * HKTopicCellMargin + HKTopicCellBottomBarH ;
      
        if (self.type == HKTopicTypePicture) {//是图片
            //计算图片控件的Frame
            CGFloat pictureX = HKTopicCellMargin;
            CGFloat pictureY = HKTopicCellTextY + HKTopicCellMargin + lableH;
            CGFloat pictureW = (ScreenWidth - 4 * HKTopicCellMargin);
            CGFloat pictureH = self.height/self.width * pictureW;
            //大图处理
            if (pictureH >= HKTopicCellPictureMaxH) {//大图
                self.bigImage = YES;
                pictureH = HKTopicCellPictureDefaultH;
            }
            //显示的图片frame
            _pictureViewFrame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            //cell的高度!
            _cellHeight += pictureH +  HKTopicCellMargin;
        }else if (self.type == HKTopicTypeVoice){//音频
            //计算frame
            CGFloat voiceX = HKTopicCellMargin;
            CGFloat voiceY = HKTopicCellTextY + HKTopicCellMargin + lableH;
            CGFloat voiceW = (ScreenWidth - 4 * HKTopicCellMargin);
            CGFloat voiceH = self.height/self.width * voiceW;
            _voiceViewFrame = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            //cell
            _cellHeight += voiceH + HKTopicCellMargin;
        }else if (self.type == HKTopicTypeVideo){//视频
            //计算frame
            CGFloat videoX = HKTopicCellMargin;
            CGFloat videoY = HKTopicCellTextY + HKTopicCellMargin + lableH;
            CGFloat videoW = (ScreenWidth - 4 * HKTopicCellMargin);
            CGFloat videoH = self.height/self.width * videoW;
            _videoViewFrame = CGRectMake(videoX, videoY, videoW, videoH);
            //cell
            _cellHeight += videoH + HKTopicCellMargin;
        }
        
        //计算最热评论高度
        HKComment * cmt = self.top_cmt.firstObject;
        if (cmt) {//有最热评论
            NSString * commentText = [NSString stringWithFormat:@"%@ : %@",cmt.user.username,cmt.content];
            CGFloat contentH = [commentText boundingRectWithSize:MaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
            _cellHeight += HKTopicCellTopCmtTitleH + HKTopicCellMargin + contentH;
        }
    }
    return _cellHeight;
}
@end
