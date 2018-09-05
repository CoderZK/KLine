//
//  zkOtherCenterFootView.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/31.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkOtherCenterFootView.h"

@interface zkOtherCenterFootView()
@property(nonatomic,strong)UIView *OneV;
@property(nonatomic,strong)UIView *jieSaoView;
@property(nonatomic,strong)UIView *zanV,*zanTouXiangV;

@property(nonatomic,strong)UIView *headV;
@property(nonatomic,strong)UIView *moneyV;

@end

@implementation zkOtherCenterFootView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        [self initOneV];
        [self initJieShaoV];
        [self initZanV];
        [self initShouFeiV];
        self.backgroundColor = WhiteColor;
    }
    return self;
}

- (void)initOneV {
    
    CGFloat ww = 80;
    CGFloat space = (ScreenW - 3*ww) / 6;
    NSArray * arr = @[@"主题",@"交易",@"互动"];
    self.OneV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 85)];
    for (int i = 0 ; i < 3 ; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 100+i;
        button.frame = CGRectMake(space + (2*space +ww) * i, 5, ww, ww);
        [self.OneV addSubview:button];
        
        UIImageView * imgV = [[UIImageView alloc] initWithFrame:CGRectMake(14.75, 5, 50.5, 45)];
        imgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"theme%d",i]];
        [button addSubview:imgV];
        
        UILabel * lb  =[[UILabel alloc] initWithFrame:CGRectMake(0, 55 , ww, 20)];
        lb.font =[UIFont systemFontOfSize:14];
        lb.textAlignment = 1;
        lb.tag = 200+i;
        lb.text = arr[i];
        lb.textColor = CharacterGrayColor102;
        [button addSubview:lb];
        
        
    }
    
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 85.4, ScreenW, 0.6)];
    backV.backgroundColor = lineBackColor;
    [self.OneV addSubview:backV];
    [self addSubview:self.OneV];
}


- (void)initJieShaoV {
    self.jieSaoView = [[UIView alloc] initWithFrame:CGRectMake(0, 90, ScreenW, 150)];
    UILabel * lb  =[[UILabel alloc] initWithFrame:CGRectMake(15, 5 , ScreenW - 30, 20)];
    lb.font =[UIFont boldSystemFontOfSize:15];
    lb.textAlignment = 0;
    lb.text = @"星球介绍";
    lb.textColor = CharacterBlackColor30;
    [self.jieSaoView addSubview:lb];
    
    UILabel * lb1  =[[UILabel alloc] initWithFrame:CGRectMake(15, 30 , ScreenW - 30, 20)];
    lb1.font =kFont(14);
    lb1.numberOfLines = 0;
    lb1.text = @"绍";
    lb1.textColor = CharacterGrayColor102;
    lb1.tag = 100;
    [self.jieSaoView addSubview:lb1];
    
    [self addSubview:self.jieSaoView];
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 149.4, ScreenW, 0.6)];
    backV.backgroundColor = lineBackColor;
    backV.tag = 101;
    [self.jieSaoView addSubview:backV];
    

}

- (void)initZanV {
    
    self.zanV = [[UIView alloc] initWithFrame:CGRectMake(0, 240, ScreenW, 150)];
    UILabel * lb  =[[UILabel alloc] initWithFrame:CGRectMake(15, 8 , ScreenW - 30, 20)];
    lb.font =[UIFont boldSystemFontOfSize:15];
    lb.textAlignment = 0;
    lb.text = @"他们也在";
    [lb sizeToFit];
    lb.textColor = CharacterBlackColor30;
    [self.zanV addSubview:lb];
    UILabel * lb2  =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(lb.frame), 8 , ScreenW - 30, 20)];
    lb2.font =[UIFont boldSystemFontOfSize:15];
    lb2.textAlignment = 0;
    lb2.text = @"(150)";
    [lb2 sizeToFit];
    lb2.tag = 100;
    lb2.textColor = CharacterGrayColor102;
    
    [self.zanV addSubview:lb2];

    self.headV = [[UIView alloc] initWithFrame:CGRectMake(15, 30, ScreenW - 30, 10)];
    [self.zanV addSubview:self.headV];
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 149.4, ScreenW, 0.6)];
    backV.backgroundColor = lineBackColor;
    backV.tag = 101;
    [self.zanV addSubview:backV];
    
    [self addSubview:self.zanV];
    
}

- (void)initShouFeiV {
    
    self.moneyV = [[UIView alloc] initWithFrame:CGRectMake(0, 390, ScreenW, 36)];
    UILabel * lb  =[[UILabel alloc] initWithFrame:CGRectMake(15, 8 , 80, 20)];
    lb.font =[UIFont boldSystemFontOfSize:15];
    lb.textAlignment = 0;
    lb.text = @"付费须知";
    lb.textColor = CharacterBlackColor30;
    [self.moneyV addSubview:lb];
    
    UILabel * lb1  =[[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 15 - 150, 8 , 150, 20)];
    lb1.font =[UIFont boldSystemFontOfSize:15];
    lb1.numberOfLines = 0;
    lb1.text = @"500LXC/年";
    lb1.textColor = [UIColor redColor];
    lb1.tag = 100;
    [self.moneyV addSubview:lb1];
    [self addSubview:self.moneyV];
    
    
    
}

- (void)setModel:(zkOtherCenterModel *)model {
    _model = model;
    
    UILabel * lb0 = (UILabel *)[self.OneV viewWithTag:200];
    UILabel * lb1 = (UILabel *)[self.OneV viewWithTag:201];
    UILabel * lb2 = (UILabel *)[self.OneV viewWithTag:202];
    lb0.text = [NSString stringWithFormat:@"主题%@",model.supportHelper.subjectCount];
    lb1.text = [NSString stringWithFormat:@"交易%@",model.supportHelper.tradeCount];
    lb2.text = [NSString stringWithFormat:@"互动%@",model.supportHelper.interactCount];
    
    UILabel * lb3 = (UILabel *)[self.jieSaoView viewWithTag:100];
    lb3.attributedText = [model.supportHelper.profile getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterGrayColor102];
    lb3.mj_h = [model.supportHelper.profile getHeigtWithFontSize:14 lineSpace:3 width:ScreenW - 30];
    UIView * v3 = (UIView *)[self.jieSaoView viewWithTag:101];
    v3.mj_y = CGRectGetMaxY(lb3.frame) + 10;
    self.jieSaoView.mj_h = CGRectGetMaxY(v3.frame);
    
    
    self.zanV.mj_y = CGRectGetMaxY(self.jieSaoView.frame);
    UILabel * lb = (UILabel *)[self.zanV viewWithTag:100];
    lb.text = [NSString stringWithFormat:@"(成员%@)",model.supportHelper.fansCount];
    [lb sizeToFit];
    [self setZanArr:model.supportHelper.fansUserPicList];
    
    UIView * lineV = (UIView *)[self.zanV viewWithTag:101];
    lineV.mj_y = CGRectGetMaxY(self.headV.frame) + 15;
    self.zanV.mj_h = CGRectGetMaxY(lineV.frame);

    
    self.moneyV.mj_y = CGRectGetMaxY(self.zanV.frame);
    UILabel * moneyLB = (UILabel *)[self.moneyV viewWithTag:100];
    moneyLB.textAlignment = 2;
    moneyLB.text = [NSString stringWithFormat:@"%@ LXC/年",model.supportHelper.price];
    self.footHeight = CGRectGetMaxY(self.moneyV.frame);
    
    
    
}

- (void)tapInView:(UITapGestureRecognizer *)tap {
    
    UIImageView * imgV = (UIImageView *)tap.view;
    NSInteger tag = imgV.tag - 100;
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didclickZanheadWithIndex:)]) {
        [self.delegate didclickZanheadWithIndex:tag - 100];
    }
    
}


- (void)setZanArr:(NSArray *)arr {
    
    [self.headV.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    

    CGFloat ww = (ScreenW - 30 - 6*10 ) / 7.0;
    CGFloat space = 10;
    if (arr.count == 0) {
        self.headV.mj_h = 0;
        return;
    }
    if (arr.count >= 21) {
        self.headV.mj_h = ww * 3 + 20;
    }else {
        if (arr.count % 7 ==0) {
            self.headV.mj_h = ww * (arr.count /7) + space *(arr.count / 7 -1);
        }else {
           self.headV.mj_h = ww * (arr.count / 7 + 1 ) + space *(arr.count / 7 );
        }
    }
    NSInteger count = arr.count > 21 ? 21 : arr.count;
    for (int i = 0 ; i < count; i++) {
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.headV addSubview:button];
        button.mj_x = (i % 7) *(ww + space);
        button.mj_y = (i / 7) * (ww + space);
        button.size = CGSizeMake(ww, ww);
        button.layer.cornerRadius = ww/2.0;
        button.clipsToBounds = YES;
        button.tag = 1000+i;
       
        [button addTarget:self action:@selector(clickHeadAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i < 20) {
           [button sd_setBackgroundImageWithURL:[NSURL URLWithString:arr[i]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
        }else {
            [button setBackgroundImage:[UIImage imageNamed:@"nav_more2"] forState:UIControlStateNormal];
        }

    }
    
    
}

- (void)clickHeadAction:(UIButton *)button {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didclickZanheadWithIndex:)]) {
        [self.delegate didclickZanheadWithIndex:button.tag - 1000];
    }
    
    
}

@end
