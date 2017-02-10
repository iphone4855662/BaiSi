//
//  HKTopicCell.h
//  百思不得姐--001
//
//  Created by Mask on 16/7/3.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HKTopic;
@interface HKTopicCell : UITableViewCell
/** 模型属性  */
@property(nonatomic,strong)HKTopic * topic;

+(instancetype)cell;
@end
