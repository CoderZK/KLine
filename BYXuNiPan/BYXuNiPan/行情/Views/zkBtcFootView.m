//
//  zkBtcFootView.m
//  BYXuNiPan
//
//  Created by zk on 2018/8/10.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkBtcFootView.h"

@interface zkBtcFootView()
@property(nonatomic,strong)UILabel *contentLB; //内容
@property(nonatomic,strong)UIView *detaiiV; // 中间部分的价格
@property(nonatomic,strong)UIView *jiayisuoView;//上架的交易所
@property(nonatomic,strong)UIView *xiangGuanView;
@end

@implementation zkBtcFootView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = WhiteColor;
        [self initCOntentLb];
        [self initDetailV];
        [self initJiaoYiView];
        [self initXiangGuan];
        
    }
    return self;
}
- (void)initCOntentLb {
    self.contentLB =[[UILabel alloc] initWithFrame:CGRectMake(15, 15, ScreenW - 30, 20)];
    self.contentLB.textColor = CharacterColor50;
    self.contentLB.text = @"4826";
    self.contentLB.numberOfLines = 0;
    self.contentLB.font = kFont(14);
    [self addSubview:self.contentLB];
    
    self.zhanKaiBt  =[UIButton buttonWithType:UIButtonTypeCustom];
    self.zhanKaiBt.frame = CGRectMake(ScreenW - 15 - 50, 35, 50, 20);
    [self.zhanKaiBt setTitle:@"展开" forState:UIControlStateNormal];
    self.zhanKaiBt.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.zhanKaiBt setTitleColor:BlueColor forState:UIControlStateNormal];
    self.zhanKaiBt.hidden = YES;
    [self addSubview:self.zhanKaiBt];
    
}

- (void)initDetailV {
    
    self.detaiiV = [[UIView alloc] initWithFrame:CGRectMake(0, 55, ScreenW, 360)];
    [self addSubview:self.detaiiV];
    NSArray * titleArr = @[@"排名",@"市值",@"现存流通量",@"总量",@"研发者",@"ICO时间",@"ICO成本",@"区块时间",@"上架交易所"];
    for (int i = 0 ; i < titleArr.count; i++) {
        zkBtcFootNeiView * neiV = [[zkBtcFootNeiView alloc] initWithFrame:CGRectMake(0, i*40, ScreenW, 40)];
        neiV.leftLB.text = titleArr[i];
        neiV.tag = 100+i;
        if (i == titleArr.count - 1) {
            neiV.lineV.hidden = YES;
        }
        [self.detaiiV addSubview:neiV];
    }
}

- (void)setModel:(zkBTCDetailModel *)model {
    _model = model;
    self.contentLB.text = model.introd;
    CGFloat height = [@"获取字的高度" getHeightWithFontSize:14 Widht:9999];
    
    CGFloat contentH = [model.introd getHeightWithFontSize:13 Widht:ScreenW - 30];
    if (contentH > 3*height) {
        self.zhanKaiBt.hidden = NO;
        if (model.isZhanKai) {
            self.contentLB.mj_h = contentH;
            [self.zhanKaiBt setTitle:@"收起" forState:UIControlStateNormal];
        }else {
            self.contentLB.mj_h = 3*height;
            [self.zhanKaiBt setTitle:@"更多" forState:UIControlStateNormal];
        }
        self.zhanKaiBt.mj_y = CGRectGetMaxY(self.contentLB.frame);
        self.detaiiV.mj_y = CGRectGetMaxY(self.zhanKaiBt.frame) +5;
    }else {
        self.zhanKaiBt.hidden = YES;
        self.contentLB.mj_h = contentH;
        self.detaiiV.mj_y = CGRectGetMaxY(self.contentLB.frame) +5;
    }
    
    zkBtcFootNeiView * v0 = (zkBtcFootNeiView *)[self.detaiiV viewWithTag:100];
    zkBtcFootNeiView * v1 = (zkBtcFootNeiView *)[self.detaiiV viewWithTag:101];
    zkBtcFootNeiView * v2 = (zkBtcFootNeiView *)[self.detaiiV viewWithTag:102];
    zkBtcFootNeiView * v3 = (zkBtcFootNeiView *)[self.detaiiV viewWithTag:103];
    zkBtcFootNeiView * v4 = (zkBtcFootNeiView *)[self.detaiiV viewWithTag:104];
    zkBtcFootNeiView * v5 = (zkBtcFootNeiView *)[self.detaiiV viewWithTag:105];
    zkBtcFootNeiView * v6 = (zkBtcFootNeiView *)[self.detaiiV viewWithTag:106];
    zkBtcFootNeiView * v7 = (zkBtcFootNeiView *)[self.detaiiV viewWithTag:107];
    zkBtcFootNeiView * v8 = (zkBtcFootNeiView *)[self.detaiiV viewWithTag:108];

    
    v0.rightLB.text = model.rank;
    v1.rightLB.text = [NSString stringWithFormat:@"$%@亿",model.marketValue];
    v2.rightLB.text = model.circulatingSupply;
    v3.rightLB.text = model.totalSupply;
    v4.rightLB.text = model.development;
    v5.rightLB.text = model.publishTime;
    v6.rightLB.text = model.icoCost;
    v7.rightLB.text = model.blockTime;
   
    
    NSArray * arr = @[];
    if (model.exchange.length > 0 && ![model.exchange isEqualToString:@""]) {
        arr = [model.exchange componentsSeparatedByString:@","];
    }
    
     v8.rightLB.text = [NSString stringWithFormat:@"%lu",(unsigned long)arr.count];
    [self setDataArr:arr];
    
    NSArray * arrTuwo = @[];
    if (model.link.length > 0 && ![model.link isEqualToString:@""]) {
        arrTuwo = [model.link componentsSeparatedByString:@","];
    }
    [self setXiangGuanArr:arrTuwo];
    self.jiayisuoView.mj_y = CGRectGetMaxY(self.detaiiV.frame)+5;
    self.xiangGuanView.mj_y = CGRectGetMaxY(self.jiayisuoView.frame) + 10;
    if (arrTuwo.count == 0) {
        self.footViewHeight = CGRectGetMaxY(self.jiayisuoView.frame) + 10;
    }else {
        self.footViewHeight = CGRectGetMaxY(self.xiangGuanView.frame) ;
    }
    
}


- (void)initJiaoYiView {
    
    self.jiayisuoView  = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.detaiiV.frame)+5, ScreenW, 0.01)];
    [self addSubview:self.jiayisuoView];
 
    
    
}

- (void)initXiangGuan{
    
    self.xiangGuanView =  [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.self.jiayisuoView.frame), ScreenW, 0.01)];
    [self addSubview:self.xiangGuanView];
 
}

//设置相关的链家
- (void)setXiangGuanArr:(NSArray *)dataArr {
    [self.xiangGuanView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (dataArr.count == 0) {
        self.xiangGuanView.mj_h = 0;
        return;
    }
    UILabel * lb =[[UILabel alloc] initWithFrame:CGRectMake(15, 0 , ScreenW - 30, 20)];
    lb.text = @"相关链接";
    lb.font =[UIFont systemFontOfSize:13];
    lb.textColor = CharacterGrayColor102;;
    [lb sizeToFit];
    [_xiangGuanView addSubview:lb];

    CGFloat btH = 20;
    CGFloat btW = (ScreenW - 30 - 40)/3;
    CGFloat spaceH = 10;
    for (int i = 0 ; i < dataArr.count; i++) {
        UIButton * button =[UIButton new];
        button.tag = 100+i;
        [button setTitleColor:CharacterBlackColor30 forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.borderWidth = 0.6;
        button.layer.borderColor = CharacterColor50.CGColor;
        button.layer.cornerRadius = 3;
        button.clipsToBounds = YES;
        button.titleLabel.font =[UIFont systemFontOfSize:14];
        NSString * str = [NSString stringWithFormat:@"%@",dataArr[i]];
        NSArray * arr = [str componentsSeparatedByString:@"#"];
        [button setTitle:[arr firstObject] forState:UIControlStateNormal];
        button.mj_x = 15 + i % 3 *(btW + 20);
        button.mj_y = CGRectGetMaxY(lb.frame) + 15 + (btH + spaceH) * (i/3);
        button.size = CGSizeMake(btW, btH);
         [_xiangGuanView addSubview:button];
        _xiangGuanView.mj_h = CGRectGetMaxY(button.frame) + 15;
       
    }
 
    
}



//设置上架的交易所
- (void)setDataArr:(NSArray *)dataArr {

    [self.jiayisuoView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (dataArr.count == 0) {
        self.jiayisuoView.mj_h = 0;
        return;
    }

    CGFloat totalW = 0;
    NSInteger number = 1;
    CGFloat btH = 20;
    CGFloat spaceW = 15;
    CGFloat spaceH = 10;
    
    for (int i = 0 ; i < dataArr.count; i++) {
        
        UIButton * button =[UIButton new];
        button.tag = 1000+i;
        [button setTitleColor:CharacterBlackColor30 forState:UIControlStateNormal];
        //        [button setBackgroundImage:[UIImage imageNamed:@"zk_aihaochange"] forState:UIControlStateNormal];
        //        [button setBackgroundImage:[UIImage imageNamed:@"zk_aihao"] forState:UIControlStateSelected];
//        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.borderWidth = 0.6;
        button.layer.borderColor = CharacterColor50.CGColor;
        button.layer.cornerRadius = 3;
        button.clipsToBounds = YES;
        button.titleLabel.font =[UIFont systemFontOfSize:14];
        NSString * str = [NSString stringWithFormat:@"%@",dataArr[i]];
        
        [button setTitle:str forState:UIControlStateNormal];
        CGFloat width =[str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}].width + 20 + spaceW;
        
        button.x = 15  + totalW;
        button.y = 0+(number-1) *(btH+spaceH);
        button.height =btH;
        button.width = width -spaceW;
        totalW = button.x + button.width ;
        
        if(totalW  > ScreenW - 15) {
            totalW = 0;
            number +=1;
            button.x = 15  + totalW;
            button.y =00+ (number-1) *(btH + spaceH);
            button.height = btH;
            button.width = width -spaceW;
            totalW = button.x + button.width ;
        }
        [_jiayisuoView addSubview:button];
        
        
        
    }
    //    _headView.backgroundColor =[UIColor redColor];
    _jiayisuoView.height = 5 + number * (btH + spaceH);

}


- (void)btnClick:(UIButton *)button {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickLinkIndex:Link:)]) {
        
        NSArray * arr = [self.model.link componentsSeparatedByString:@","];
        NSString * str = arr[button.tag - 100];
        NSArray * arrTwo = [str componentsSeparatedByString:@"#"];
        [self.delegate didClickLinkIndex:button.tag - 100  Link:[arrTwo lastObject]];
    }
    
    
}

@end



//内部的view
@implementation zkBtcFootNeiView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        self.leftLB =[[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 20)];
        self.leftLB.textColor = CharacterGrayColor102;
        self.leftLB.text = @"4826";
        self.leftLB.font = kFont(13);
        [self addSubview:self.leftLB];
        
        self.rightLB = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, ScreenW - 135, 20)];
        self.rightLB.textColor = CharacterColor50;
        self.rightLB.text = @"4jasnf;j";
        self.rightLB.textAlignment = 2;
        self.rightLB.font = kFont(13);
        [self addSubview:self.rightLB];
        
        self.lineV  =[[UIView alloc] initWithFrame:CGRectMake(15, self.mj_h - 0.5, ScreenW - 30, 0.5)];
        self.lineV.backgroundColor = lineBackColor;
        [self addSubview: self.lineV];
        
    }
    return self;
}

@end


