//
//  zkLoginVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/11.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkLoginVC.h"
#import "zkLoginV.h"
#import "zkRegistV.h"
#import "zkforgetMMVC.h"
@interface zkLoginVC ()<zkLoginVDelegate,zkRegistVDelegate>

/**  */
@property(nonatomic,strong)zkLoginV *LoginVV;
/**  */
@property(nonatomic,strong)zkRegistV *registVV;
/**  */
@property(nonatomic,strong)UIView *blueVOne;
@property(nonatomic,strong)UIView *blueVTwo;
@end



@implementation zkLoginVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
     self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    [self setV];
    [self setLoginV];
    
}


- (void)setV {
    
    UIButton * backBt =[UIButton buttonWithType:UIButtonTypeCustom];
    backBt.frame = CGRectMake(15, sstatusHeight + 7 , 30, 30);
    backBt.tag = 100;
    [backBt addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBt setImage:[UIImage imageNamed:@"cross"] forState:UIControlStateNormal];
    [self.view addSubview:backBt];

    UIImageView * imgV =[[UIImageView alloc] initWithFrame:CGRectMake((ScreenW - 100)/2, sstatusHeight + 50, 100, 100)];
    imgV.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:imgV];
    
    UIButton * loginBt =[UIButton buttonWithType:UIButtonTypeCustom];
    loginBt.frame = CGRectMake(0, CGRectGetMaxY(imgV.frame) + 20, (ScreenW - 1)/2, 40);
    [loginBt setTitle:@"登录" forState:UIControlStateNormal];
    loginBt.titleLabel.font = [UIFont systemFontOfSize:15];
    [loginBt setTitleColor:CharacterBlackColor30 forState:UIControlStateNormal];
    loginBt.layer.cornerRadius = 0;
    loginBt.tag = 101;
    [loginBt addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    loginBt.clipsToBounds = YES;
    [self.view addSubview:loginBt];

    UIButton * registBt =[UIButton buttonWithType:UIButtonTypeCustom];
    registBt.frame = CGRectMake((ScreenW - 1)/2, CGRectGetMaxY(imgV.frame) + 20, (ScreenW - 1)/2, 40);
    [registBt setTitle:@"注册" forState:UIControlStateNormal];
    registBt.titleLabel.font = [UIFont systemFontOfSize:15];
    [registBt addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [registBt setTitleColor:CharacterBlackColor30 forState:UIControlStateNormal];
    registBt.layer.cornerRadius = 0;
    registBt.tag = 102;
    registBt.clipsToBounds = YES;
    [self.view addSubview:registBt];
    
 
    
 
}

- (void)setLoginV {
    
    self.blueVOne = [[UIView alloc] init];
    _blueVOne.backgroundColor = BlueColor;
    _blueVOne.size = CGSizeMake(40, 3);
    _blueVOne.centerX = (ScreenW - 1)/4;
    _blueVOne.mj_y = sstatusHeight + 210;
    [self.view addSubview:_blueVOne];
    
    self.LoginVV = [[zkLoginV alloc] initWithFrame:CGRectMake(0, sstatusHeight + 213, ScreenW, ScreenH - 250)];
    self.LoginVV.delegate = self;
    [self.view addSubview:self.LoginVV];
    
    self.blueVTwo = [[UIView alloc] init];
    _blueVTwo.backgroundColor = BlueColor;
    _blueVTwo.centerX = (ScreenW - 1)/4 * 3 + 1 +  ScreenW;
    _blueVTwo.size = CGSizeMake(40, 3);
    _blueVTwo.mj_y = sstatusHeight + 210;
    [self.view addSubview:self.blueVTwo];

    self.registVV = [[zkRegistV alloc] initWithFrame:CGRectMake(ScreenW, sstatusHeight + 213, ScreenW, ScreenH - 250)];
    self.registVV.delegate = self;
    [self.view addSubview:self.registVV];
    
}



- (void)backAction:(UIButton *)button {
    if (button.tag == 100) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }else  if (button.tag == 101) {
        //点击的是登录
        [UIView animateWithDuration:0.2 animations:^{
            self.LoginVV.mj_x = 0;
            self.blueVOne.centerX = (ScreenW - 1) / 4;
            self.registVV.mj_x = ScreenW;
            self.blueVTwo.centerX = (ScreenW - 1) / 4 * 3 + 1 + ScreenW;
        }];
        
        
    }else {
       //点击的是注册
        [UIView animateWithDuration:0.2 animations:^{
            self.LoginVV.mj_x = -ScreenW;
            self.blueVOne.centerX = (ScreenW - 1) / 2 - ScreenW;
            self.registVV.mj_x = 0;
            self.blueVTwo.centerX = (ScreenW - 1) / 4 * 3 + 1 ;
        }];
        
        
        
    }
   
}



#pragma mark --- 点击登录 和注册的代理 ----
- (void)didClickLoginBt:(UIButton *)button number:(NSString *)numbreStr mima:(NSString *)mimaStr {
    if (button.tag == 102) {
        //点击的是忘记密码
        zkforgetMMVC * vc =[[zkforgetMMVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (button.tag == 103){
        //点击的是登录
        
        [self loginAction:self.LoginVV.numberV.leftTF.text mimaStr:self.LoginVV.mimaV.leftTF.text];
    }
 
}



- (void)didClickRegistBt:(UIButton *)button number:(NSString *)numberStr code:(NSString *)codeStr mima:(NSString *)mimaStr{
    if (button.tag == 101) {
        //点击的是用户协议
    }else if (button.tag == 102) {
        //点击的是注册
         [self regsisterWithPhone:numberStr code:codeStr mima:mimaStr];
    }
    
    
}

//注册
- (void)regsisterWithPhone:(NSString *)numberStr code:(NSString *)codeStr mima:(NSString *)mimaStr {
    
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:[zkURL getRegisterURL] parameters:@{@"phone":numberStr,@"code":codeStr,@"password":mimaStr} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"code"] integerValue] == 200) {
            [SVProgressHUD dismiss];
            UIButton * button = [UIButton new];
            button.tag = 101;
            [self backAction:button];
            self.LoginVV.numberV.leftTF.text = numberStr;
            self.LoginVV.mimaV.leftTF.text = mimaStr;

        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

//登录
- (void)loginAction:(NSString *)numberStr mimaStr:(NSString *)mimaStr {
    if (numberStr.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
//    if (mimaStr.length < 6 || mimaStr.length > 10)
//    {
//        [SVProgressHUD showErrorWithStatus:@"请输入6-10位字母加数字的密码"];
//        return;
//    }
     [SVProgressHUD show];
    [zkRequestTool networkingPOST:[zkURL getLoginURL] parameters:@{@"phone":numberStr,@"password":mimaStr,@"deviceId":deviceID} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if ([responseObject[@"code"] integerValue] == 200) {
            [SVProgressHUD dismiss];
            [zkSignleTool shareTool].session_token = [NSString stringWithFormat:@"Bearer %@",responseObject[@"result"][@"token"]];
            zkUserInfoModel * model = [zkUserInfoModel mj_objectWithKeyValues:responseObject[@"result"][@"userInfo"]];
            [zkSignleTool shareTool].userInfoModel = model;
            [zkSignleTool shareTool].isLogin = YES;
            
            [[zkSignleTool shareTool] uploadDeviceTokenWith:[zkSignleTool shareTool].deviceToken];
            
            [self dismissViewControllerAnimated:YES completion:nil];
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
