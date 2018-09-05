//
//  zkLoginV.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/11.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkLoginV.h"
#import "zkTextV.h"
@interface zkLoginV()
@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation zkLoginV

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.backgroundColor = WhiteColor;
        _numberV = [[zkTextV alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
        _numberV.tag = 100;
        _numberV.rightBt.hidden = YES;
        _numberV.leftTF.secureTextEntry = NO;
        _numberV.leftTF.keyboardType = UIKeyboardTypePhonePad;
        _numberV.leftTF.placeholder = @"请输入手机号";
        [self addSubview:_numberV];
        
        _mimaV = [[zkTextV alloc] initWithFrame:CGRectMake(0, 50, ScreenW, 50)];
        _mimaV.tag = 101;
        _mimaV.leftTF.placeholder = @"请输入密码";
        [self addSubview:_mimaV];
        
        
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(ScreenW - 15 - 80, 105, 80, 45);
        [button setTitle:@"忘记密码" forState:UIControlStateNormal];
        button.titleLabel.font = kFont(14);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [button setTitleColor:CharacterBlackColor30 forState:UIControlStateNormal];
        button.tag = 102;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];

        
        UIButton * loginBt =[UIButton buttonWithType:UIButtonTypeCustom];
        loginBt.frame = CGRectMake(20, 155, ScreenW - 40, 45);
        loginBt.layer.cornerRadius = 22.5;
        loginBt.clipsToBounds = YES;
        [loginBt setTitle:@"登录" forState:UIControlStateNormal];
        loginBt.titleLabel.font = kFont(18);
        loginBt.tag = 103;
        [loginBt setBackgroundImage:[UIImage imageNamed:@"zk_blue"] forState:UIControlStateNormal];
        [loginBt addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:loginBt];

        

    }
    
    
    
    return self;
}

- (void)buttonClick:(UIButton *)button {
    if (button.tag == 103) {
        
        if (self.numberV.leftTF.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
            return;
        }
        if (self.numberV.leftTF.text.length != 11) {
            [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
            return;
        }
        
        if (self.mimaV.leftTF.text.length == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入密码"];
            return;
        }
        
        
        
    }
    
    
    if (self.delegate != nil  && [self.delegate respondsToSelector:@selector(didClickLoginBt:number:mima:)])  {
       
        [self.delegate didClickLoginBt:button number:_numberV.leftTF.text mima:_mimaV.leftTF.text];
        
    }
    
    
    
}


@end
