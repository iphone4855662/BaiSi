//
//  HKShowPictureController.m
//  百思不得姐--001
//
//  Created by Mask on 16/7/8.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "HKShowPictureController.h"
#import "HKTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import "HKProgressView.h"

@interface HKShowPictureController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/** 图片  */
@property(nonatomic,weak)UIImageView * imageView;
@property (weak, nonatomic) IBOutlet HKProgressView *progressView;

@end

@implementation HKShowPictureController



- (void)viewDidLoad {
    [super viewDidLoad];
    //立刻显示进度值
    [self.progressView setProgress:self.topic.pictureProgress animated:YES];
    //添加图片
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss:)]];
    self.imageView = imageView;
    [self.scrollView addSubview:imageView];
    
    //图片尺寸
    imageView.width = ScreenWidth;
    //H / W == h / w  H / W * w
    imageView.height = self.topic.height/self.topic.width * imageView.width;
    if (imageView.height > ScreenHeight) {//ScrollView可以滚动
        imageView.x = 0;
        imageView.y = 0;
        self.scrollView.contentSize = CGSizeMake(0, imageView.height);
    }else{
        imageView.x = 0;
        imageView.centerY = ScreenHeight * 0.5;
    }
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.imageUrl] placeholderImage:nil options:kNilOptions progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.topic.pictureProgress = 1.0 *receivedSize / expectedSize;
        [self.progressView setProgress:self.topic.pictureProgress animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        //隐藏
        self.progressView.hidden = YES;
    }];
    
}

//保存到相册
- (IBAction)save:(id)sender {
    //将图片写入相册
    if (self.imageView.image) {
        UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(haha:hehe:heihei:), nil);
    }else{
        [SVProgressHUD showErrorWithStatus:@"图片没有下载完毕"];
    }
}

- (void)haha:(UIImage *)image hehe:(NSError *)error heihei:(void *)contextInfo{
    
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"图片保存失败!!"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }
}



//自杀
- (IBAction)dismiss:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
