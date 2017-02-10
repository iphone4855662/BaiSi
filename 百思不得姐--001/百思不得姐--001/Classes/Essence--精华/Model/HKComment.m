//
//  HKComment.m
//  百思不得姐--001
//
//  Created by Mask on 16/7/11.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "HKComment.h"

@implementation HKComment

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"ID"] = @"id";
    return dict;
}
@end
