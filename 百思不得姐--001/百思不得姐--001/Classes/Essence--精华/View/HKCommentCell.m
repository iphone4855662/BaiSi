//
//  HKCommentCell.m
//  百思不得姐--001
//
//  Created by Mask on 16/7/13.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "HKCommentCell.h"
#import "HKComment.h"
#import "HKUser.h"
#import <UIImageView+WebCache.h>
#import "UIImageView+HKExtension.h"

@interface HKCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;

@end

@implementation HKCommentCell

-(void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setComment:(HKComment *)comment
{
    _comment = comment;
    //设置数据
    [self.profileImageView setHeader:comment.user.profile_image];
    self.sexView.image = [comment.user.sex isEqualToString:HKUserSexMale]? [UIImage imageNamed:@"Profile_manIcon"]:[UIImage imageNamed:@"Profile_womanIcon"];
    self.contentLabel.text = comment.content;
    self.nameLabel.text = comment.user.username;
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    
    if (comment.voiceuri.length) {
        self.voiceBtn.hidden = NO;
        [self.voiceBtn setTitle:[NSString stringWithFormat:@"%zd''",comment.voicetime] forState:(UIControlStateNormal)];
    }else{
        self.voiceBtn.hidden = YES;
    }
}

@end
