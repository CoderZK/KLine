//
//  zkTextV.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/11.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkTextV.h"

@implementation zkTextV


- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        self.leftTF = [[UITextField alloc] initWithFrame:CGRectMake(15, (frame.size.height - 20)/2.0, ScreenW - 30-60, 20)];
        self.leftTF.font = kFont(14);
        self.leftTF.secureTextEntry = YES;
        [self addSubview:self.leftTF];
        
        self.rightBt =[UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBt.frame = CGRectMake(ScreenW - 12 -30,  (frame.size.height - 30)/2.0, 30, 30);
        [self.rightBt setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
         [self.rightBt setBackgroundImage:[UIImage imageNamed:@"open"] forState:UIControlStateSelected];
        self.rightBt.layer.cornerRadius = 0;
        self.rightBt.clipsToBounds = YES;
        [self addSubview:self.rightBt];
        [self.rightBt addTarget:self action:@selector(rightACtion:) forControlEvents:UIControlEventTouchUpInside];
        
        self.lineV =[[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 0.5, ScreenW, 0.5)];
        self.lineV.backgroundColor = lineBackColor;
        [self addSubview:self.lineV];
        
    }
    return self;
}

- (void)rightACtion:(UIButton *)button {
    self.leftTF.secureTextEntry = button.selected;
    button.selected = !button.selected; 
}



@end
