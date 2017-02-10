//
//  HKBar.m
//  百思不得姐--001
//
//  Created by Mask on 16/7/4.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "HKBar.h"

@implementation HKBar


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}


-(void)setFrame:(CGRect)frame
{
    frame.size.height += 200;
    
    [super setFrame:frame];
}
@end
