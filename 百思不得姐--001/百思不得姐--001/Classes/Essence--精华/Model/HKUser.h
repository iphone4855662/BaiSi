//
//  HKUser.h
//  百思不得姐--001
//
//  Created by Mask on 16/7/11.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKUser : NSObject

/** 头像URL */
@property(copy,nonatomic)NSString * profile_image;
/** 用户名 */
@property(copy,nonatomic)NSString * username;
/** 性别 */
@property(copy,nonatomic)NSString * sex;

@end
