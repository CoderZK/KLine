//
//  zkYiJianFanKuiDetailVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/8/7.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkYiJianFanKuiDetailVC.h"

@interface zkYiJianFanKuiDetailVC ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation zkYiJianFanKuiDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.isComeJiangLi) {
        self.navigationItem.title = @"活跃奖励说明";
        [SVProgressHUD show];
        [zkRequestTool networkingGET:[zkURL getByTypURL] parameters:@{@"type":@"1"} success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
                [self.webView loadHTMLString:[NSString stringWithFormat:@"%@",responseObject[@"result"][@"content"]] baseURL:nil];
            }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
                [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
            }else {
                [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {

        }];


    }
    if (self.isComeYiJian){
        [SVProgressHUD show];
        self.navigationItem.title = self.model.question;
        [self.webView loadHTMLString:_model.answer baseURL:nil];
    }

    if (self.isComeBannar ) {

        [SVProgressHUD show];
        self.navigationItem.title = @"详情";
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
//        [self.webView loadHTMLString:self.urlStr baseURL:[NSURL URLWithString:@"http://"]];
    }
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
