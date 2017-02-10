//
//  HKWebViewController.m
//  百思不得姐--001
//
//  Created by Mask on 16/7/16.
//  Copyright © 2016年 Mask. All rights reserved.
//

#import "HKWebViewController.h"

@interface HKWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *gobacke;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goOn;

@end

@implementation HKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goback:(id)sender {
    [self.webView goBack];
}
- (IBAction)goForward:(id)sender {
    [self.webView goForward];
}

- (IBAction)refresh:(id)sender {
    [self.webView reload];
}


#pragma mark - <代理>
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.gobacke.enabled = webView.canGoBack;
    self.goOn.enabled = webView.canGoForward;
}

@end
