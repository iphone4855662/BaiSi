//
//  HKComment.h
//  百思不得姐--001
//
//  Created by Mask on 16/7/11.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  HKUser;
@interface HKComment : NSObject

/** 评论内容 */
@property(copy,nonatomic)NSString * content;
/** 点赞数 */
@property(assign,nonatomic)NSInteger like_count;
/** 音频时长 */
@property(assign,nonatomic)NSInteger voicetime;
/** 用户  */
@property(nonatomic,strong)HKUser * user;
/** 音频文件路径 */
@property(copy,nonatomic)NSString * voiceuri;
/** 用户的id */
@property(copy,nonatomic)NSString * ID;




@end
