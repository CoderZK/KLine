//
//  zkMineHeadView.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/14.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkMineHeadView.h"

@interface zkMineHeadView()


@property(nonatomic,strong)UIButton *headBt ,*editBt;
@property(nonatomic,strong)UILabel *nameLB;
@property(nonatomic,strong)UILabel *signLB;



@end


@implementation zkMineHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = WhiteColor;
        
        UIImageView * imageV = [[UIImageView alloc] initWithFrame:self.bounds];
        imageV.image = [UIImage imageNamed:@"bg2"];
        [self addSubview:imageV];
        
        
        UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
        right.frame = CGRectMake(ScreenW - 35 - 10, sstatusHeight + 5.5, 35, 35);
        [right setImage:[UIImage imageNamed:@"nav_set"] forState:UIControlStateNormal];
        [right setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentRight)];
        right.tag = 100;
        [right addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:right];

        self.headBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.headBt.frame = CGRectMake(15, kScreenHSacle(95), kScreenHSacle(45), kScreenHSacle(45));
        self.headBt.layer.cornerRadius = kScreenHSacle(45) / 2.0;
        [self.headBt setBackgroundImage:[UIImage imageNamed:@"369"] forState:UIControlStateNormal];
        self.headBt.clipsToBounds = YES;
        self.headBt.layer.borderWidth = 1;
        self.headBt.layer.borderColor = WhiteColor.CGColor;
        self.headBt.tag = 101;
        [self.headBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.headBt];
        
        self.nameLB = [[UILabel alloc] initWithFrame:CGRectMake(5, kScreenHSacle(95) + kScreenHSacle(45), kScreenHSacle(45) + 20 , 20)];
        self.nameLB.font = kFont(13);
        self.nameLB.textColor = WhiteColor;
        self.nameLB.text = @"抓牛大人";
        self.nameLB.textAlignment = 1;
        [self addSubview:self.nameLB];
        
        self.signLB = [[UILabel alloc] initWithFrame:CGRectMake(kScreenHSacle(90), sstatusHeight + 44 + 5 , ScreenW - kScreenHSacle(90) - 15, 40)];
        self.signLB.numberOfLines = 2;
        self.signLB.font = kFont(14);
        self.signLB.textColor = WhiteColor;
        self.signLB.text = @"三代都是科技扶贫微积分能否立刻打开立方阿斯蒂芬拉速度发 力度轮播的是登录开发hi";
        [self addSubview:self.signLB];
        
        
        UIButton * editBt =[UIButton buttonWithType:UIButtonTypeCustom];
        editBt.frame = CGRectMake(0, kScreenHSacle(200), kScreenHSacle(60), kScreenHSacle(30));
        editBt.centerX = self.centerX;
        [editBt setTitle:@"修改>" forState:UIControlStateNormal];
        editBt.tag = 102;
        [editBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        editBt.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:editBt];

        
        CGFloat ww = (ScreenW - kScreenHSacle(95)) / 4.5;
        CGFloat s_x = kScreenHSacle(85);
        CGFloat s_y = kScreenHSacle(140);
        CGFloat s_y2 = kScreenHSacle(160);
        NSArray * arr = @[@"订阅",@"粉丝",@"自选",@"钱包"];
        NSArray * arr2 = @[@"256",@"7895.5万",@"65",@"5894.36BN"];
        for (int i = 0 ; i < arr.count ; i ++) {
            UILabel * lb =[[UILabel alloc] initWithFrame:CGRectMake(s_x + i * ww, s_y , ww, 18)];
            lb.font =[UIFont systemFontOfSize:13];
            lb.textColor = WhiteColor;
            lb.textAlignment = NSTextAlignmentCenter;
            lb.text = arr[i];
            
            UILabel * lb2 =[[UILabel alloc] initWithFrame:CGRectMake(s_x + i * ww, s_y2 , ww, 18)];
            lb2.font =[UIFont boldSystemFontOfSize:13];
            lb2.textColor = WhiteColor;
            lb2.tag = 1000 + i;
            lb2.text = arr2[i];
            lb2.textAlignment = NSTextAlignmentCenter;
            
            UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(lb.mj_x, lb.mj_y, lb.mj_w, 40);
            button.tag = 103 + i;
            [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            
            if (i+1 == arr.count) {
                lb.mj_w = 1.5 * ww;
                lb2.mj_w = 1.5 * ww;

            }
            [self addSubview:lb];
            [self addSubview:lb2];
        }
        
 
        
    }
    return self;
}

- (void)setModel:(zkUserInfoModel *)model {
    _model = model;
    [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:model.userPic] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
    self.signLB.text = model.sign;
    self.nameLB.text = model.nickName;
    
    UILabel * lb1 = (UILabel *)[self viewWithTag:1000];
    UILabel * lb12 = (UILabel *)[self viewWithTag:1001];
    UILabel * lb13 = (UILabel *)[self viewWithTag:1002];
    UILabel * lb14 = (UILabel *)[self viewWithTag:1003];
    
    if ([model.fansCount integerValue] > 10000) {
        lb1.text = [NSString stringWithFormat:@"%0.2f万",[model.followCount floatValue]/10000.0];
    }else {
        lb1.text = model.followCount;
    }
    if ([model.fansCount integerValue] > 10000) {
        lb12.text = [NSString stringWithFormat:@"%0.2f万",[model.fansCount floatValue]/10000.0];
    }else {
        lb12.text = model.fansCount;
    }
    
    if ([model.holdLxcCount integerValue] > 10000) {
        lb13.text = [NSString stringWithFormat:@"%0.2f万",[model.holdLxcCount floatValue]/10000.0];
    }else {
        lb13.text = model.holdLxcCount;
    }
    NSString * str = @"";
    if ([model.wallet floatValue] > 10000) {
        str = [NSString stringWithFormat:@"%0.2f万 LXC",[model.wallet floatValue]/10000];
    }else {
        str = [NSString stringWithFormat:@"%@ LXC",model.wallet];
    }
    
    NSAttributedString * att = [str getMutableAttributeStringWithFont:13 lineSpace:0 textColor:WhiteColor fontTwo:10 nsrange:NSMakeRange(str.length - 3, 3)];
    lb14.attributedText = att;
    lb14.textAlignment = NSTextAlignmentCenter;
}



//点击设置
- (void)clickAction:(UIButton *)button {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickHead:index:)]){
        [self.delegate didClickHead:button index:button.tag - 100];
    }
    
    
}


@end
