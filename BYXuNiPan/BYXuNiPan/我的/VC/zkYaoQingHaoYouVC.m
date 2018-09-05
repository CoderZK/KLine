//
//  zkYaoQingHaoYouVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/17.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkYaoQingHaoYouVC.h"
#import <Photos/Photos.h>
@interface zkYaoQingHaoYouVC ()
@property (weak, nonatomic) IBOutlet UIWebView *textV;
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property(nonatomic,strong)NSString *contentStr;
@property(nonatomic,strong)NSString *imgStr;
@end

@implementation zkYaoQingHaoYouVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.title = @"邀请好友";
    [self getData];
}


- (void)getData {
    
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }

    [zkRequestTool networkingPOST:[zkURL getShareSettingURL] parameters:@{@"userId":[zkSignleTool shareTool].userInfoModel.ID} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            
            [self.imgV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",responseObject[@"result"][@"img"]]] placeholderImage:[UIImage imageNamed:@"bg4"] options:SDWebImageRetryFailed];
            self.contentStr = [NSString stringWithFormat:@"%@",responseObject[@"result"][@"content"]];
            self.imgStr = [NSString stringWithFormat:@"%@",responseObject[@"result"][@"img"]];
            [self.textV loadHTMLString:[NSString stringWithFormat:@"%@",responseObject[@"result"][@"content"]] baseURL:nil];
            
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 700) {
            
            [self showAlertWithKey:@"700" message:nil];
            
        } else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
    
}


- (IBAction)clickAction:(UIButton *)sender {
    if (sender.tag == 100) {
        //保存图片
        if ([self isCanUsePicture ]) {
            
            [self loadImageFinished:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.imgStr]]]];
            
        }else {
            [SVProgressHUD showErrorWithStatus:@"请在iPhone的""设置-隐私-相册""中允许访问相册"];
        }
        
    }else if (sender.tag == 101) {
        //分享
          [self shareWithSetPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession)] withUrl:@"123" shareModel:nil];
        
    }else {
        //复制
        UIPasteboard * pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.contentStr;
        
    }
    
}


- (void)loadImageFinished:(UIImage *)image
{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        //写入图片到相册
        PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
        NSLog(@"success = %d, error = %@", success, error);
        
    }];
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
