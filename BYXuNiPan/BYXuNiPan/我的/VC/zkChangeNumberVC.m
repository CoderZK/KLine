//
//  zkChangeNumberVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/23.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkChangeNumberVC.h"

@interface zkChangeNumberVC ()
@property (weak, nonatomic) IBOutlet UILabel *left1LB;
@property (weak, nonatomic) IBOutlet UILabel *left2LB;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *timeBt;
@property (weak, nonatomic) IBOutlet UIButton *yanZhengAction;
@property(nonatomic,strong)NSTimer *timer;
/** 注释 */
@property(nonatomic,assign)NSInteger number;
@property(nonatomic,assign)BOOL isTwoStep;
@end

@implementation zkChangeNumberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"换绑手机";
    self.view.backgroundColor =[UIColor groupTableViewBackgroundColor];
    self.yanZhengAction.layer.cornerRadius = 22.5;
    self.yanZhengAction.clipsToBounds = YES;
    [self.timeBt setTitle:@"发送验证码" forState:UIControlStateNormal];
    [self.yanZhengAction setTitle:@"完成" forState:UIControlStateNormal];
    self.phoneTF.userInteractionEnabled = NO;
    self.phoneTF.text = [zkSignleTool shareTool].userInfoModel.phone;
    
}

- (IBAction)sendCodeAction:(UIButton *)sender {
    
    [self sendCode];
    
}
//验证
- (IBAction)yanZhengAction:(id)sender {
    
    if (self.isTwoStep) {
        if (self.phoneTF.text.length != 11) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
            return;
        }
        if (self.codeTF.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
            return;
        }
        [self changePhoneAction:self.phoneTF.text code:self.codeTF.text];
    }else {
        //第一步
        if (self.phoneTF.text.length != 11) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
            return;
        }
        [self yanZhengPhoneAction:self.phoneTF.text code:self.codeTF.text];
        
    }
    
    
}

- (void)sendCode {
    if (self.phoneTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    if (self.phoneTF.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
        return;
    }
    
    NSString * url = [NSString stringWithFormat:@"%@/%@",[zkURL getSendCodeURL],self.phoneTF.text];
    
    
    [SVProgressHUD show];
    [zkRequestTool networkingGET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] integerValue] == 200) {
            [SVProgressHUD showSuccessWithStatus:@"发送验证码成功"];
//            self.codeTF.text = [NSString stringWithFormat:@"%@",responseObject[@"result"]];
            [self timeAction];
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}

//验证验证码
- (void)yanZhengPhoneAction:(NSString *)phoneStr code:(NSString *)codeStr {
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:[zkURL getValidCodeURL] parameters:@{@"code":self.codeTF.text,@"phone":phoneStr} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
             [SVProgressHUD dismiss];
            [self.timer invalidate];
            self.timer = nil;
            [self.timeBt setTitle:@"发送验证码" forState:UIControlStateNormal];
            self.phoneTF.text = @"";
            self.codeTF.text = @"";
            self.phoneTF.userInteractionEnabled = YES;
            self.timeBt.userInteractionEnabled = YES;
            self.left1LB.text = @"新手机";
            [self.yanZhengAction setTitle:@"绑定新手机号" forState:UIControlStateNormal];
            self.isTwoStep = YES;
            
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
}

//验证验证码
- (void)changePhoneAction:(NSString *)phoneStr code:(NSString *)codeStr {
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:[zkURL getPhoneChangeURL] parameters:@{@"code":self.codeTF.text,@"phone":phoneStr} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            [SVProgressHUD showSuccessWithStatus:@"更换手机号成功"];
            zkUserInfoModel * model =  [zkSignleTool shareTool].userInfoModel;
            model.phone = phoneStr;
            [zkSignleTool shareTool].userInfoModel = model;
            [zkSignleTool shareTool].session_token = [NSString stringWithFormat:@"Bearer %@",responseObject[@"result"]];
            if (self.sendPhoneBlock != nil) {
                self.sendPhoneBlock(phoneStr);
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
}


- (void)timeAction {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStar) userInfo:nil repeats:YES];
    self.timeBt.userInteractionEnabled = NO;
    self.number = 60;
    
    
}

- (void)timerStar {
    _number = _number -1;
    if (self.number > 0) {
        [self.timeBt setTitle:[NSString stringWithFormat:@"%lds后重发",_number] forState:UIControlStateNormal];
    }else {
        [self.timeBt setTitle:@"重新发送" forState:UIControlStateNormal];
        [self.timer invalidate];
        self.timer = nil;
        self.timeBt.userInteractionEnabled = YES;
    }
    
    
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
