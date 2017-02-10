//
//  UIView+HKExtension.h
//  百思不得姐--001
//
//  Created by Mask on 16/6/28.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HKExtension)
/** X坐标 */
@property(assign,nonatomic)CGFloat x;
/** Y坐标 */
@property(assign,nonatomic)CGFloat y;
/** 宽度 */
@property(assign,nonatomic)CGFloat width;
/** 高度 */
@property(assign,nonatomic)CGFloat height;
//完善  两个属性  centerX  centerY
/** 中心 */
@property(assign,nonatomic)CGFloat centerX;
@property(assign,nonatomic)CGFloat centerY;

/** 尺寸 */
@property(assign,nonatomic)CGSize size;

/**
 *  判断控件是否真正的显示在屏幕上
 */
-(BOOL)isShowingOnWindow;


@end
