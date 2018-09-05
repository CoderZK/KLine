//
//  zkRegistV.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/11.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkRegistV.h"

@interface zkRegistV()

@property(nonatomic,strong)UIButton *bt1,*bt2,*timeBt;
@property(nonatomic,strong)NSTimer *timer;
/** 注释 */
@property(nonatomic,assign)NSInteger number;
@end

@implementation zkRegistV

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.backgroundColor = WhiteColor;
        _phoneV = [[zkTextV alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
        _phoneV.rightBt.hidden = YES;
        _phoneV.leftTF.secureTextEntry = NO;
        _phoneV.leftTF.placeholder = @"请输入手机号";
        [self addSubview:_phoneV];
        
        _codeV = [[zkTextV alloc] initWithFrame:CGRectMake(0, 50, ScreenW, 50)];
        _codeV.rightBt.hidden = YES;
        _codeV.leftTF.secureTextEntry = NO;
        _codeV.leftTF.placeholder = @"请输入验证码";
        [self addSubview:_codeV];
        
        
        _miMaOneV = [[zkTextV alloc] initWithFrame:CGRectMake(0, 100, ScreenW, 50)];
//        _miMaOneV.leftTF.placeholder = @"请输入6-10位字母加数字密码";
        _miMaOneV.leftTF.placeholder = @"请输入密码";
        [self addSubview:_miMaOneV];
        
        self.timeBt =[UIButton buttonWithType:UIButtonTypeCustom];
        self.timeBt.frame = CGRectMake(ScreenW - 130 - 15, 60, 130, 30);
        self.timeBt.titleLabel.font = kFont(14);
        [self.timeBt setTitleColor:BlueColor forState:UIControlStateNormal];
        [self.timeBt setTitle:@"发送验证码" forState:UIControlStateNormal];
        self.timeBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.timeBt.layer.cornerRadius = 0;
        self.timeBt.clipsToBounds = YES;
        self.timeBt.tag = 100;
        [self.timeBt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.timeBt];

        UILabel * titleB =[[UILabel alloc] initWithFrame:CGRectMake(15, 165 , 100, 20)];
        titleB.font = kFont(14);
        titleB.text = @"注册即代表同意";
        [titleB sizeToFit];
        titleB.textColor = RGB(50, 50, 50);
        [self addSubview:titleB];

        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(CGRectGetMaxX(titleB.frame) + 3 , 160, 70, 20);
        [button setTitle:@"《用户协议》" forState:UIControlStateNormal];
        [button sizeToFit];
        button.centerY = titleB.centerY;
        [button setTitleColor:RGB(6, 165, 249) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.tag = 101;
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];

        
        UIButton * loginBt =[UIButton buttonWithType:UIButtonTypeCustom];
        loginBt.frame = CGRectMake(20, 220, ScreenW - 40, 45);
        loginBt.layer.cornerRadius = 25;
        loginBt.clipsToBounds = YES;
        [loginBt setTitle:@"注册" forState:UIControlStateNormal];
        [loginBt setBackgroundImage:[UIImage imageNamed:@"zk_blue"] forState:UIControlStateNormal];
        loginBt.titleLabel.font = kFont(16);
        loginBt.tag = 102;
        [loginBt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:loginBt];
        
    }
    return self;
}

- (void)click:(UIButton *)button {
    if (button.tag == 100) {
        [self sendCode:button];
    }else if(button.tag == 101){
        if (self.delegate != nil ) {
            [self.delegate didClickRegistBt:button number:nil code:nil mima:nil];
        }
        
    }else {
        if (self.phoneV.leftTF.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
            return;
        }
        if (self.phoneV.leftTF.text.length != 11) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
            return;
        }
        if (self.codeV.leftTF.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
            return;
        }
        
        if (self.miMaOneV.leftTF.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入密码"];
            return;
        }
        
//        if (self.miMaOneV.leftTF.text.length < 6 || self.miMaOneV.leftTF.text.length > 10) {
//            [SVProgressHUD showErrorWithStatus:@"请输入正确密码"];
//            return;
//        }
        
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickRegistBt:number:code:mima:)]) {
            [self.delegate didClickRegistBt:button number:self.phoneV.leftTF.text  code:self.codeV.leftTF.text mima:self.miMaOneV.leftTF.text];
        }
        
        
    }
    
    
}


- (void)sendCode:(UIButton *)button {
    if (self.phoneV.leftTF.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入手机号"];
        return;
    }
    if (self.phoneV.leftTF.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确手机号"];
        return;
    }
    
    NSString * url = [NSString stringWithFormat:@"%@/%@",[zkURL getSendCodeURL],self.phoneV.leftTF.text];
    
    
    [SVProgressHUD show];
    [zkRequestTool networkingGET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] integerValue] == 200) {
            [SVProgressHUD showSuccessWithStatus:@"发送验证码成功"];
//            self.codeV.leftTF.text = [NSString stringWithFormat:@"%@",responseObject[@"result"]];
            [self timeAction];
        }else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
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

@end
