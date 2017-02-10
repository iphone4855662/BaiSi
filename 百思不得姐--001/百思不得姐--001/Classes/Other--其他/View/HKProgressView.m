//
//  HKProgressView.m
//  百思不得姐--001
//
//  Created by Mask on 16/7/8.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "HKProgressView.h"

@implementation HKProgressView


-(void)awakeFromNib
{
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

-(void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    NSString * text = [NSString stringWithFormat:@"%.0f%%",progress * 100];
    //将text里面的-号处理掉
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
}
@end
