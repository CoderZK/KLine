//
//  zkPingLunDetailHeadView.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/27.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkPingLunDetailHeadView.h"

@interface zkPingLunDetailHeadView()
@property(nonatomic,strong)UIButton *headBt;  //头像
@property(nonatomic,strong)UILabel *titleLB; //昵称
@property(nonatomic,strong)UILabel *signLB,*contentLB;   //签名
@property(nonatomic,strong)UIButton *lookYuanWenBt;
@property(nonatomic,strong)UIImageView *zanImgV;
@property(nonatomic,strong)UILabel *zanLB;
@property(nonatomic,strong)UIButton *zanBt;


@end

@implementation zkPingLunDetailHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WhiteColor;
        self.headBt =[UIButton buttonWithType:UIButtonTypeCustom];
        self.headBt.frame = CGRectMake(15, 15, 45, 45);
        [self.headBt setBackgroundImage:[UIImage imageNamed:@"369"] forState:UIControlStateNormal];
        self.headBt.layer.cornerRadius = 22.5;
        self.headBt.clipsToBounds = YES;
        self.headBt.tag = 102;
        [self.headBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.headBt];
        
        //
        //        self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 40, 25, 13)];
        //        [self.headBt addSubview:self.imgV];
        
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headBt.frame) + 10 , 15, ScreenW - CGRectGetMaxX(self.headBt.frame) - 10 - 15 - 120 - 35 , 20)];
        self.titleLB.font = [UIFont systemFontOfSize:14];
        self.titleLB.text = @"牛的一比";
        self.titleLB.textColor = OrangeColor;
        [self addSubview:self.titleLB];
        
        self.zanImgV = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenW- 15 - 20, 15, 20, 20)];
        self.zanImgV.image =[UIImage imageNamed:@"praise_p"];
        [self addSubview:self.zanImgV];
        
        self.zanLB = [[UILabel alloc] initWithFrame:CGRectMake(ScreenW - 35 - 120 , 15, 120, 20)];
        self.zanLB.font = kFont(13);
        self.zanLB.textColor = CharacterGrayColor102;
        self.zanLB.text = @"123";
        self.zanLB.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.zanLB];
        
        self.zanBt =[UIButton buttonWithType:UIButtonTypeCustom];
        self.zanBt.frame = CGRectMake(ScreenW - 155, 15, 155, 20);
        self.zanBt.layer.cornerRadius = 0;
        self.zanBt.clipsToBounds = YES;
        self.zanBt.tag = 100;
        [self.zanBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.zanBt];

    
        
        
        self.signLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headBt.frame) + 10, 40, ScreenW - CGRectGetMaxX(self.headBt.frame) - 10 - 15 , 16)];
        self.signLB.textColor = CharacterGrayColor102;
        self.signLB.font = kFont(13);
        self.signLB.text = @"2018-09-28";
        [self addSubview:self.signLB];
        
        
        self.contentLB = [[UILabel alloc] initWithFrame:CGRectMake(70, 70, ScreenW - 85, 20)];
        self.contentLB.textColor = CharacterBlackColor30;
        self.contentLB.numberOfLines = 0;
        [self addSubview:self.contentLB];
        
        self.lookYuanWenBt =[UIButton buttonWithType:UIButtonTypeCustom];
        self.lookYuanWenBt.frame = CGRectMake(70, 60, 120, 30);
        [self.lookYuanWenBt setTitle:@"查看原内容>" forState:UIControlStateNormal];
        self.lookYuanWenBt.titleLabel.font = [UIFont systemFontOfSize:14];
        self.lookYuanWenBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.lookYuanWenBt setTitleColor:BlueColor forState:UIControlStateNormal];
        self.lookYuanWenBt.layer.cornerRadius = 0;
        self.lookYuanWenBt.clipsToBounds = YES;
        self.lookYuanWenBt.tag = 101;
        [self.lookYuanWenBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.lookYuanWenBt];
        
        UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        
        [self addGestureRecognizer:tap];
        

    }
    return self;
}


- (void)setModel:(zkHomelModel *)model {
    _model = model;
    [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:model.createByUserPic] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
    self.titleLB.text = model.createByNickName;
    self.signLB.text = [NSString stringWithTime:model.createDate];
    
    NSString * str = model.content;
    //        self.contentLB.backgroundColor = [UIColor greenColor];
    CGFloat hh = [@"谁" getSizeWithMaxSize:CGSizeMake(100, 100) withFontSize:14].height;
    self.contentLB.attributedText = [str getMutableAttributeStringWithFont:14 lineSpace:3 textColor:CharacterBlackColor30];
    CGFloat ch= [str getHeigtWithFontSize:14 lineSpace:3 width:ScreenW - 85];
    self.contentLB.mj_h = ch;
    self.lookYuanWenBt.mj_y = CGRectGetMaxY(self.contentLB.frame);
    self.height = CGRectGetMaxY(self.lookYuanWenBt.frame) + 10;
    self.headHeight = CGRectGetMaxY(self.lookYuanWenBt.frame) + 10;
    if (model.supportFlag) {
        self.zanImgV.image = [UIImage imageNamed:@"praise_p"];
    }else {
       self.zanImgV.image = [UIImage imageNamed:@"praise_n"];
    }
    self.zanLB.text = model.supportCount;
    
    
}

//点击整体
- (void)tap:(UITapGestureRecognizer *)tap {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickheadBt:index:)]) {
         [self.delegate didClickheadBt:nil index:100];
    }

}

- (void)clickAction:(UIButton *)button {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickheadBt:index:)]) {
        [self.delegate didClickheadBt:button index:button.tag - 100];
    }
    
}

@end
