//
//  HKTopicPictureView.h
//  百思不得姐--001
//
//  Created by Mask on 16/7/6.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HKTopic;
@interface HKTopicPictureView : UIView

+(instancetype)pictureView;

/** 模型数据  */
@property(nonatomic,strong)HKTopic * topic;
@end
