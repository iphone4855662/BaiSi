//
//  HKCommentHeaderView.h
//  百思不得姐--001
//
//  Created by Mask on 16/7/13.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKCommentHeaderView : UITableViewHeaderFooterView
/** 文字 */
@property(copy,nonatomic)NSString * title;

+(instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
