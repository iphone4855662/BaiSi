//
//  HKCommentCell.h
//  百思不得姐--001
//
//  Created by Mask on 16/7/13.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HKComment;
@interface HKCommentCell : UITableViewCell
/** 评论模型  */
@property(nonatomic,strong)HKComment * comment;
@end
