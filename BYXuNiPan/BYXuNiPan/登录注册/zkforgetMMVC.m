//
//  zkforgetMMVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/11.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkforgetMMVC.h"
#import "zkRegistV.h"
@interface zkforgetMMVC ()
@property(nonatomic,strong)zkRegistV *VV;
@end

@implementation zkforgetMMVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isXiuGaiMiMa) {
        self.navigationItem.title = @"修改密码";
    }else {
        self.navigationItem.title = @"忘记密码";
    }
   
    
    zkRegistV * v = [[zkRegistV alloc] initWithFrame:CGRectMake(0, sstatusHeight + 44, ScreenW, 150)];
    self.VV = v;
    [self.view addSubview:v];
    
    
    UIButton * loginBt =[UIButton buttonWithType:UIButtonTypeCustom];
    loginBt.frame = CGRectMake(20, CGRectGetMaxY(self.VV.frame) + 30, ScreenW - 40, 45);
    loginBt.layer.cornerRadius = 22.5;
    loginBt.clipsToBounds = YES;
    [loginBt setTitle:@"完成" forState:UIControlStateNormal];
    [loginBt setBackgroundImage:[UIImage imageNamed:@"zk_blue"] forState:UIControlStateNormal];
    loginBt.titleLabel.font = kFont(18);
    loginBt.tag = 102;
    [loginBt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBt];
    
    
}

- (void)click:(UIButton *)button {
    
    if (self.VV.phoneV.leftTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
        return;
    }
    if (self.VV.phoneV.leftTF.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        return;
    }
    if (self.VV.codeV.leftTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    
//    if (self.VV.miMaOneV.leftTF.text.length <6 || self.VV.miMaOneV.leftTF.text.length > 10) {
//        [SVProgressHUD showErrorWithStatus:@"请输入6-10位字母加数字的密码"];
//        return;
//    }
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:[zkURL getPwdChangeURL] parameters:@{@"phone":self.VV.phoneV.leftTF.text,@"code":self.VV.codeV.leftTF.text,@"newPassword":self.VV.miMaOneV.leftTF.text} success:^(NSURLSessionDataTask *task, id responseObject) {

        if ([responseObject[@"code"] integerValue] == 200) {
            [SVProgressHUD showSuccessWithStatus:@"修改密码成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [self.navigationController popViewControllerAnimated:YES];
            });
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        
        
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
