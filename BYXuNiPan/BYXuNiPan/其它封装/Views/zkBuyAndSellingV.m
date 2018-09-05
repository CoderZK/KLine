//
//  zkBuyAndSellingV.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/18.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkBuyAndSellingV.h"

@interface zkBuyAndSellingV ()
@property(nonatomic,strong)UIView *whiteV;
@property(nonatomic,strong)UIView *alertV,*buySellV,*leiXingV,*priceV,*numberV,*footV;
@property(nonatomic,strong)UILabel *canUseNumberLB,*shouXuLB;
@property(nonatomic,strong)UIButton *buyOrSellBt;
@property(nonatomic,assign)NSInteger selectIndex,buyOrSellIndex,xianOrShiIndex; //selectIndex 为仓库的选择
@property(nonatomic,strong)UITextField *numberTF,*priceTF;
@end


@implementation zkBuyAndSellingV

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.whiteV = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH, ScreenW, 345)];
        self.whiteV.backgroundColor = WhiteColor;
        [self addSubview:_whiteV];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        
        [self addGestureRecognizer:tap];
     
        [self setBuyOrSell];
        [self setShouXuV];
        [self setCang];
        [self setNumberVVV];
        [self setPirceVV];
        [self setLeiXingVV];
        [self setbuysellVV];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        
    }
    return self;
}

//设置买卖
- (void)setBuyOrSell {
    
    self.footV = [[UIView alloc] initWithFrame:CGRectMake(0, self.whiteV.mj_h - 160 , ScreenW, 160)];
    self.footV.backgroundColor = [UIColor whiteColor];
    [self.whiteV addSubview:self.footV];

    self.buyOrSellBt =[UIButton buttonWithType:UIButtonTypeCustom];
    self.buyOrSellBt.frame = CGRectMake(15, self.footV.mj_h - 40 - 15, ScreenW - 30, 40);
    [self.buyOrSellBt setBackgroundImage:[UIImage imageNamed:@"zk_blue"] forState:UIControlStateNormal];
    [self.buyOrSellBt setTitle:@"买入" forState:UIControlStateNormal];
    self.buyOrSellBt.titleLabel.font = [UIFont systemFontOfSize:16];
    self.buyOrSellBt.tag = 104;
    [self.buyOrSellBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.buyOrSellBt setTitleColor:WhiteColor forState:UIControlStateNormal];
    self.buyOrSellBt.layer.cornerRadius = 4;
    self.buyOrSellBt.clipsToBounds = YES;
    self.buyOrSellBt.tag = 104;
    [self.footV addSubview:self.buyOrSellBt];

}

//谁知 可用和 手续费
- (void)setShouXuV {
    
    UILabel * lb1  =[[UILabel alloc] initWithFrame:CGRectMake(15, self.footV.mj_h - 65 - 20  , 45, 20)];
    lb1.font =[UIFont systemFontOfSize:13];
    lb1.textColor = CharacterGrayColor102;
    lb1.text = @"手续费:";
    [self.footV addSubview:lb1];
    
    self.shouXuLB = [[UILabel alloc] initWithFrame:CGRectMake(60, CGRectGetMinY(lb1.frame) , ScreenW - 60-15, 20)];
    self.shouXuLB.font =[UIFont systemFontOfSize:13];
    self.shouXuLB.textColor = CharacterGrayColor102;
    self.shouXuLB.text = @"0.2%";
    [self.footV addSubview:self.shouXuLB];
    
    
    UILabel * lb2  =[[UILabel alloc] initWithFrame:CGRectMake(15, self.footV.mj_h - 65 - 20 - 25 , 45, 20)];
    lb2.font =[UIFont systemFontOfSize:15];
    lb2.textColor = CharacterBlackColor30;
    lb2.text = @"可用:";
    [self.footV addSubview:lb2];
    
    self.canUseNumberLB = [[UILabel alloc] initWithFrame:CGRectMake(60, CGRectGetMinY(lb2.frame) , ScreenW - 60-15, 20)];
    self.canUseNumberLB.font =[UIFont systemFontOfSize:15];
    self.canUseNumberLB.textColor = CharacterBlackColor30;
    self.canUseNumberLB.text = @"10000.00 RMB";
    [self.footV addSubview:self.canUseNumberLB];
    
}


- (void)setCang {

    NSArray * arr =@[@"1/4",@"1/3",@"1/2",@"全仓"];
    CGFloat space = 10;
    CGFloat ww = (ScreenW - 30 - 30) /4;
    CGFloat hh = 30;
    for (int i = 0 ; i< arr.count; i++) {

        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15 + i * (space + ww), self.footV.mj_h -  110  - 10 - 30, ww, hh);
        button.tag = 100+i;
        [button setBackgroundImage:[UIImage imageNamed:@"zk_blue"] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"zk_white"] forState:UIControlStateNormal];
        [button setTitleColor:WhiteColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:BlueColor forState:UIControlStateNormal];
        button.layer.cornerRadius = 3;
        button.clipsToBounds = YES;
        button.layer.borderColor = BlueColor.CGColor;
        button.layer.borderWidth = 1.0;
        [self.footV addSubview:button];

    }

}

- (void)setNumberVVV {
    
    self.numberV = [[UIView alloc] initWithFrame:CGRectMake(0, self.whiteV.mj_h - 160 - 45, ScreenW, 45)];
    self.numberV.backgroundColor = WhiteColor;
    
    UILabel * lb2  =[[UILabel alloc] initWithFrame:CGRectMake(15, 12.5 , 50, 20)];
    lb2.font =[UIFont systemFontOfSize:15];
    lb2.textColor = CharacterBlackColor30;
    lb2.text = @"数量";
    lb2.tag = 300;
    [self.numberV addSubview:lb2];
    
    self.numberTF = [[UITextField alloc] initWithFrame:CGRectMake(70, 7.5, ScreenW - 85, 30)];
    self.numberTF.font = kFont(14);
    self.numberTF.keyboardType = UIKeyboardTypeDecimalPad;
    self.numberTF.placeholder = @"请输入数量";
    [self.numberV addSubview:self.numberTF];
    
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(15, 44.4, ScreenW - 30 , 0.6)];
    backV.backgroundColor = lineBackColor;
    [self.numberV addSubview:backV];
    [self.whiteV addSubview:self.numberV];
    
}

- (void)setPirceVV {
    
    self.priceV = [[UIView alloc] initWithFrame:CGRectMake(0, 95, ScreenW, 45)];
    self.priceV.backgroundColor = WhiteColor;
    
    UILabel * lb2  =[[UILabel alloc] initWithFrame:CGRectMake(15, 12.5 , 50, 20)];
    lb2.font =[UIFont systemFontOfSize:15];
    lb2.textColor = CharacterBlackColor30;
    lb2.text = @"价格";
    [self.priceV addSubview:lb2];
    
    self.priceTF = [[UITextField alloc] initWithFrame:CGRectMake(70, 7.5, ScreenW - 85, 30)];
    self.priceTF.font = kFont(14);
    self.priceTF.keyboardType = UIKeyboardTypeDecimalPad;
    self.priceTF.placeholder = @"请输入价格";
    [self.priceV addSubview:self.priceTF];
    
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(15, 44.4, ScreenW - 30 , 0.6)];
    backV.backgroundColor = lineBackColor;
    [self.priceV addSubview:backV];
    [self.whiteV addSubview:self.priceV];
    
}

- (void)setLeiXingVV {
    
    self.leiXingV = [[UIView alloc] initWithFrame:CGRectMake(0, 50, ScreenW, 45)];
    self.leiXingV.backgroundColor = WhiteColor;
    
    UILabel * lb2  =[[UILabel alloc] initWithFrame:CGRectMake(15, 12.5 , 45, 20)];
    lb2.font =[UIFont systemFontOfSize:15];
    lb2.textColor = CharacterBlackColor30;
    lb2.text = @"类型";
    [self.leiXingV addSubview:lb2];
    NSArray * arr = @[@"限价单",@"市价单"];
    for (int i = 0 ; i < 2; i++) {
        
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(60 + 100 * i, 5, 100, 35);
        [button setImage:[UIImage imageNamed:@"select_n"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"select_p"] forState:UIControlStateSelected];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:CharacterBlackColor30 forState:UIControlStateNormal];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 8)];
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 105 + i;
        if (i == 0) {
            button.selected = YES;
        }
        [self.leiXingV addSubview:button];

        
        
    }

    
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(15, 44.4, ScreenW - 30 , 0.6)];
    backV.backgroundColor = lineBackColor;
    [self.leiXingV addSubview:backV];

    [self.whiteV addSubview:self.leiXingV];
    
}


- (void)setbuysellVV {
    
    self.buySellV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    self.buySellV.backgroundColor = WhiteColor;
    self.alertV = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 30, 3)];
    self.alertV.backgroundColor = BlueColor;
    [self.buySellV addSubview: self.alertV];
    NSArray * arr = @[@"买入",@"卖出"];
    for (int i = 0  ; i < arr.count; i++) {
        
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((ScreenW / 2 - 60)/2 + ScreenW / 2 * i, 7.5, 60, 35);
        [button setTitle:arr[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:CharacterBlackColor30 forState:UIControlStateNormal];
        [button setTitleColor:BlueColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 107 + i;
        if (i == 0) {
            button.selected = YES;
            button.mj_x = ScreenW / 2 - 60 -35;
            self.alertV.centerX = button.centerX;
        }else {
            button.mj_x = ScreenW / 2 + 35;
        }
        [self.buySellV addSubview:button];
        
    }
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(15, 49.4, ScreenW - 30 , 0.6)];
    backV.backgroundColor = lineBackColor;
    [self.buySellV addSubview:backV];
    
    UIButton * button1 =[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(ScreenW - 15 - 35 , 7.5, 35, 35);
    [button1 setImage:[UIImage imageNamed:@"cross"] forState:UIControlStateNormal];
    button1.tag = 109;
    [button1 addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    button1.layer.cornerRadius = 0;
    button1.clipsToBounds = YES;
    [self.buySellV addSubview:button1];

    
    
    [self.whiteV addSubview:self.buySellV];
    
}

- (void)clickAction:(UIButton *)button {
    if (button.tag <104) {
//        if (button.tag != self.selectIndex) {
//            self.selectIndex = button.tag;
//            [self setSelect:button];
//        }
       
         [self setSelect:button];
        
    }else if (button.tag == 104) {
        //最新面的买入卖出
        
        if (self.numberTF.text.length == 0 || [self.numberTF.text floatValue] == 0) {
            [SVProgressHUD showErrorWithStatus:@"请输入买入的数量"];
            return;
        }
        
        if (self.xianOrShiIndex == 0) {
            if (self.priceTF.text.length == 0 || [self.priceTF.text floatValue] == 0) {
                [SVProgressHUD showErrorWithStatus:@"请输入价格"];
                return;
            }
        }
        
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didBuyOrSellV:xianJiaOrShiJia:number:priceStr:)]) {
            [self.delegate didBuyOrSellV:self.buyOrSellIndex xianJiaOrShiJia:self.xianOrShiIndex number:self.numberTF.text priceStr:self.priceTF.text];
        }

    }else if (button.tag == 105) {
        //限价单
        button.selected = YES;
        UIButton * bt = (UIButton *)[self.whiteV viewWithTag:106];
        bt.selected = NO;
        self.priceV.hidden = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.whiteV.mj_h = 345;
            self.whiteV.mj_y  = ScreenH - 345;
            self.footV.mj_y = 185;
            self.numberV.mj_y = 140;
        }];
        self.xianOrShiIndex = 0;
        if (self.buyOrSellIndex == 0) {
            UILabel * lb = (UILabel *)[self.numberV viewWithTag:300];
            lb.text = @"数量";
            self.numberTF.text = @"";
        }
    }else if (button.tag == 106) {
        //市价单
        button.selected = YES;
        UIButton * bt = (UIButton *)[self.whiteV viewWithTag:105];
        bt.selected = NO;
        self.priceV.hidden = YES;
       
        [UIView animateWithDuration:0.2 animations:^{
            self.whiteV.mj_h = 300;
            self.whiteV.mj_y  = ScreenH - 300;
            self.footV.mj_y = 140;
            self.numberV.mj_y = 95;
        }];
        self.xianOrShiIndex = 1;
         UILabel * lb = (UILabel *)[self.numberV viewWithTag:300];
        if (self.buyOrSellIndex == 0) {
            lb.text = @"交易额";
            self.numberTF.text = self.moneyStr;
        }else {
            lb.text = @"数量";
            self.numberTF.text = self.bitNumberStr;
        }
    }else if (button.tag == 107) {
        //买入
         self.canUseNumberLB.text = [NSString stringWithFormat:@"%0.2f USDT",[self.moneyStr floatValue]];
        button.selected = YES;
        UIButton * bt = (UIButton *)[self.whiteV viewWithTag:108];
        bt.selected = NO;
        [UIView animateWithDuration:0.2 animations:^{
            self.alertV.centerX = button.centerX;
        }];
        [self.buyOrSellBt setTitle:@"买入" forState:UIControlStateNormal];
        self.buyOrSellIndex = 0;
        
        if (self.xianOrShiIndex == 1) {
            UILabel * lb = (UILabel *)[self.numberV viewWithTag:300];
            lb.text = @"交易额";
            self.numberTF.text = self.moneyStr;
        }
        
    }else if (button.tag == 108) {
        //卖出
        self.canUseNumberLB.text = [NSString stringWithFormat:@"%0.2f",[self.bitNumberStr floatValue]];
        button.selected = YES;
        UIButton * bt = (UIButton *)[self.whiteV viewWithTag:107];
        bt.selected = NO;
        
        [UIView animateWithDuration:0.2 animations:^{
            self.alertV.centerX = button.centerX;
        }];
         [self.buyOrSellBt setTitle:@"卖出" forState:UIControlStateNormal];
        self.buyOrSellIndex = 1;
        
        UILabel * lb = (UILabel *)[self.numberV viewWithTag:300];
        lb.text = @"数量";
        self.numberTF.text = self.bitNumberStr;
    }else if (button.tag == 109){
        [self diss];
    }
    
    
    
}

- (void)setPricStr:(NSString *)pricStr {
    _pricStr = pricStr;
    self.priceTF.text = pricStr;
}

- (void)setMoneyStr:(NSString *)moneyStr {
    _moneyStr = moneyStr;
    
}

- (void)setBitNumberStr:(NSString *)bitNumberStr {
    _bitNumberStr = bitNumberStr;
}

- (void)setSelect:(UIButton *)button {
//    for (int i = 100; i < 104; i++) {
//        UIButton * button = (UIButton *)[self.whiteV viewWithTag:i];
//        if (button.tag == self.selectIndex) {
//            button.selected = YES;
//        }else{
//            button.selected = NO;
//        }
//    }
    if (self.buyOrSellIndex == 0 ) {
        //买入
        if (self.xianOrShiIndex == 0) {
            //限价
            if (self.priceTF.text.length == 0) {
                [SVProgressHUD showErrorWithStatus:@"请输入价格"];
                return;
            }
            CGFloat allMoney = [self.moneyStr floatValue] * 0.998;
            CGFloat allNumber = allMoney /[self.priceTF.text floatValue];
            self.numberTF.text = [NSString stringWithFormat:@"%0.4f",allNumber / (104 - button.tag)];
        }else {
            CGFloat allMoney = [self.moneyStr floatValue];
            self.numberTF.text = [NSString stringWithFormat:@"%0.4f",allMoney / (104 - button.tag)];
        }
    }else {
        self.numberTF.text = [NSString stringWithFormat:@"%0.4f",[self.bitNumberStr floatValue] / (104 - button.tag)];
    }
 
    
}


- (void)show {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        self.whiteV.mj_y = ScreenH - 350;
    }];
}

- (void)showWithMaiMai:(BOOL)isBuy {
    UIButton * button = [UIButton new];
    if (isBuy) {
        self.canUseNumberLB.text = [NSString stringWithFormat:@"%0.2f USDT",[self.moneyStr floatValue]];
        button = (UIButton *)[self.buySellV viewWithTag:107];
    }else {
         button = (UIButton *)[self.buySellV viewWithTag:108];
         self.canUseNumberLB.text = [NSString stringWithFormat:@"%0.2f",[self.bitNumberStr floatValue]];
    }
    [self clickAction:button];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        self.whiteV.mj_y = ScreenH - 350;
    }];
}

- (void)diss {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.backgroundColor =[UIColor colorWithWhite:0 alpha:0];
        self.whiteV.mj_y = ScreenH;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    NSNotification * notification = [[NSNotification alloc] initWithName:@"kaishi" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}

- (void)tap:(UITapGestureRecognizer *)tap {
    
    CGPoint point = [tap locationInView:self];
    if (point.y < ScreenH - self.whiteV.mj_h) {
        [self diss];
    }
    
    
    
    
}


//键盘将要出现
- (void)handleKeyboardWillShow:(NSNotification *)paramNotification
{
    NSLog(@"键盘即将出现");
    NSValue *value = [[paramNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];//使用UIKeyboardFrameBeginUserInfoKey,会出现切换输入法时获取的搜狗键盘不对.
    CGRect keyboardRect = [value CGRectValue];
    CGFloat keyboardH = keyboardRect.size.height;
    NSLog(@"键盘高度:%f", keyboardH);
    self.whiteV.transform = CGAffineTransformMakeTranslation(0, -keyboardH + 160);
}

//键盘将要隐藏
- (void)handleKeyboardWillHide:(NSNotification *)paramNotification
{
    NSLog(@"键盘即将隐藏");
    self.whiteV.transform = CGAffineTransformIdentity;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    [self.whiteV endEditing:YES];
}


@end
