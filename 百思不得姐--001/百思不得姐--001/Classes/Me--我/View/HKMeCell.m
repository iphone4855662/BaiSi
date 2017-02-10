//
//  HKMeCell.m
//  百思不得姐--001
//
//  Created by Mask on 16/7/16.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "HKMeCell.h"

@implementation HKMeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:14];
        UIImageView * bgView = [[UIImageView alloc]init];
        bgView.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = bgView;
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return  self;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.width = 30;
    self.imageView.height = self.imageView.width;
    self.imageView.centerY = self.contentView.height * 0.5;
    if (self.imageView.image != nil) {
        self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + HKTopicCellMargin;
    }
}


-(void)setFrame:(CGRect)frame
{
//    NSLog(@"%@",NSStringFromCGRect(frame));
    frame.origin.y -= (35 - HKTopicCellMargin);
    [super setFrame:frame];
}

@end
