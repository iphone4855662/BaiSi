//
//  UIBarButtonItem+HKExtension.h
//  百思不得姐--001
//
//  Created by Mask on 16/6/28.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (HKExtension)

//图片\高亮图片\监听者\方法
+(instancetype)itemWithImageNamed:(NSString *)imageName target:(id)target action:(SEL)action;

//title\图片\高亮图片\监听者\方法
+(instancetype)backItemWithImageNamed:(NSString *)imageName title:(NSString *)title target:(id)target action:(SEL)action;

@end
