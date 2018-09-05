//
//  zkMaiMaiView.m
//  BYXuNiPan
//
//  Created by zk on 2018/8/1.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkMaiMaiView.h"

@implementation zkMaiMaiView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WhiteColor;
        self.buyBt  =[UIButton buttonWithType:UIButtonTypeCustom];
        self.buyBt.frame = CGRectMake(0, 0, ScreenW / 4 , 45);
        self.buyBt.backgroundColor = RGB(255, 129, 39);
        [self.buyBt setTitle:@"买入" forState:UIControlStateNormal];
        self.buyBt.titleLabel.font = [UIFont systemFontOfSize:14];
        self.buyBt.tag = 100;
        [self.buyBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.buyBt setTitleColor:WhiteColor forState:UIControlStateNormal];
        [self addSubview:self.buyBt];
        
        self.sellBt  =[UIButton buttonWithType:UIButtonTypeCustom];
        self.sellBt.frame = CGRectMake(ScreenW / 4, 0, ScreenW / 4 , 45);
        self.sellBt.backgroundColor = BlueColor;
        [self.sellBt setTitle:@"卖出" forState:UIControlStateNormal];
        self.sellBt.titleLabel.font = [UIFont systemFontOfSize:14];
        self.sellBt.tag = 101;
        [self.sellBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.sellBt setTitleColor:WhiteColor forState:UIControlStateNormal];
        [self addSubview:self.sellBt];
        
        
        self.pingLunBt  =[UIButton buttonWithType:UIButtonTypeCustom];
        self.pingLunBt.frame = CGRectMake( ScreenW / 2, 0, ScreenW / 4 , 45);
        self.pingLunBt.titleLabel.font = [UIFont systemFontOfSize:14];
        self.pingLunBt.tag = 102;
        [self.pingLunBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.pingLunBt setTitleColor:WhiteColor forState:UIControlStateNormal];
        [self addSubview:self.pingLunBt];
        UIImageView * imgV = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenW / 4 - 24) / 2, 5, 24, 24)];
        imgV.image = [UIImage imageNamed:@"tab_comments"];
        [self.pingLunBt addSubview:imgV];
        UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 29, ScreenW / 4, 16)];
        lb.textColor = CharacterGrayColor102;
        lb.font = kFont(12);
        lb.textAlignment = NSTextAlignmentCenter;
        lb.text = @"评论";
        [self.pingLunBt addSubview:lb];
        
        

        self.ziXunBt  =[UIButton buttonWithType:UIButtonTypeCustom];
        self.ziXunBt.frame = CGRectMake(ScreenW / 4 * 3, 0, ScreenW / 4 , 45);
        self.ziXunBt.titleLabel.font = [UIFont systemFontOfSize:14];
        self.ziXunBt.tag = 103;
        [self.ziXunBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.ziXunBt setTitleColor:WhiteColor forState:UIControlStateNormal];
        [self addSubview:self.ziXunBt];
        
        self.addV = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenW / 4 - 24) / 2, 5, 24, 24)];
        self.addV.image = [UIImage imageNamed:@"tab_plus"];
        [self.ziXunBt addSubview:self.addV];
        self.addLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 29, ScreenW / 4, 16)];
        self.addLB.textColor = CharacterGrayColor102;
        self.addLB.font = kFont(12);
        self.addLB.textAlignment = NSTextAlignmentCenter;
        self.addLB.text = @"加自选";
        [self.ziXunBt addSubview:self.addLB];
        
        
        
        
        
    }
    return self;
}

- (void)clickAction:(UIButton *)button {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickBuyOrSellIndex:with:)]) {
        [self.delegate didClickBuyOrSellIndex:button.tag - 100 with:button];
    }
}

@end
