//
//  HKCommentHeaderView.m
//  百思不得姐--001
//
//  Created by Mask on 16/7/13.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "HKCommentHeaderView.h"
@interface HKCommentHeaderView ()

/** 文字标签  */
@property(nonatomic,weak)UILabel * label;

@end

@implementation HKCommentHeaderView


-(void)setTitle:(NSString *)title
{
    _title = [title copy];
    self.label.text = title;
}
+(instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString * ID = @"comment";
    HKCommentHeaderView * header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) {
        header = [[HKCommentHeaderView alloc]initWithReuseIdentifier:ID];
    }
    return header;
}


-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = HKGlobalColor;
        //创建label
        UILabel * label =[[UILabel alloc]init];
        label.x = HKTopicCellMargin;
        label.width = 200;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        label.textColor = HKRGBColor(67, 67, 67);
        //添加label
        [self.contentView addSubview:label];
        self.label = label;
    }
    return self;
}

@end
