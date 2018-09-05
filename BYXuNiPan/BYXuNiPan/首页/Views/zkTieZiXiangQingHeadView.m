//
//  zkTieZiXiangQingHeadView.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/20.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkTieZiXiangQingHeadView.h"

@interface zkTieZiXiangQingHeadView ()
@property(nonatomic,strong)UIButton *headBt;  //头像
@property(nonatomic,strong)UILabel *titleLB; //昵称
@property(nonatomic,strong)UILabel *signLB;   //签名
@property(nonatomic,strong)UILabel *contentLB;
@property(nonatomic,strong)UIView *zanView;
@property(nonatomic,strong)UIButton *zanBt,*shareBt,*xianDanBt;
@property(nonatomic,strong)UIView *xiaDanV,*picsView;



@end

@implementation zkTieZiXiangQingHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds = YES;
        
        self.backgroundColor = WhiteColor;
        self.headBt =[UIButton buttonWithType:UIButtonTypeCustom];
        self.headBt.frame = CGRectMake(15, 15, 45, 45);
        [self.headBt setBackgroundImage:[UIImage imageNamed:@"369"] forState:UIControlStateNormal];
        self.headBt.layer.cornerRadius = 22.5;
        self.headBt.clipsToBounds = YES;
        self.headBt.tag = 203;
        [self.headBt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.headBt];
        
        //
        //        self.imgV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 40, 25, 13)];
        //        [self.headBt addSubview:self.imgV];
        
        self.titleLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headBt.frame) + 10 , 15, ScreenW - CGRectGetMaxX(self.headBt.frame) - 10 - 15  , 20)];
        self.titleLB.font = [UIFont systemFontOfSize:14];
        self.titleLB.text = @"牛的一比";
        self.titleLB.textColor = OrangeColor;
        [self addSubview:self.titleLB];
        
        self.contentLB = [[UILabel alloc] initWithFrame:CGRectMake(15 , CGRectGetMaxY(self.headBt.frame) + 10, ScreenW - 30  , 20)];
        self.contentLB.font = [UIFont systemFontOfSize:14];
        self.contentLB.text = @"牛的一比";
        self.contentLB.numberOfLines = 0;
        self.contentLB.textColor = CharacterColor50;
        [self addSubview:self.contentLB];
        
        
        self.picsView = [[UIView alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(self.titleLB.frame), ScreenW - 85, 20)];
        
        for (int i = 0 ; i < 9 ; i ++) {
            
            UIImageView * imageView= [[UIImageView alloc] init];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            imageView.tag = i+100;
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInView:)];
            tap.cancelsTouchesInView = YES;//设置成NO表示当前控件响应后会传播到其他控件上，默认为YES
            [imageView addGestureRecognizer:tap];
            [self.picsView addSubview:imageView];
        }
        
        [self addSubview:self.picsView];
        
        
        self.signLB = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headBt.frame) + 10, 40, ScreenW - CGRectGetMaxX(self.headBt.frame) - 10 - 15 , 16)];
        self.signLB.textColor = CharacterGrayColor102;
        self.signLB.font = kFont(13);
        self.signLB.text = @"2018-09-28";
        [self addSubview:self.signLB];
        
        
        //下单的view
        self.xiaDanV = [[UIView alloc] initWithFrame:CGRectMake(70, 75, ScreenW - 85 , 64)];
        UIButton *right2 = [UIButton buttonWithType:UIButtonTypeCustom];
        right2.frame = CGRectMake(ScreenW - 85 - 60, 0, 60, 25);
        right2.backgroundColor = BlueColor;
        [right2 setTitle:@"下单" forState:UIControlStateNormal];
        right2.titleLabel.font = kFont(14);
        right2.tag = 1;
        [right2 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        right2.tag = 201;
        right2.layer.shadowOffset = CGSizeMake(1, 2);
        right2.layer.shadowColor = BlueColor.CGColor;
        right2.layer.shadowOpacity = 0.8;
//        [self.xiaDanV addSubview:right2];
        
        for (int i = 0; i < 3; i++) {
            
            UILabel * lllb =[[UILabel alloc] initWithFrame:CGRectMake(0, i * (18 +5) , ScreenW - 85 - 60, 18)];
            lllb.font =[UIFont systemFontOfSize:14];
            lllb.text = @"豆腐块青 19.2645814";
            lllb.tag = 100+i;
            lllb.textColor = CharacterBlackColor30;
            [self.xiaDanV addSubview:lllb];
            
            
        }
        
        [self addSubview:self.xiaDanV];
        
        
        //点赞的人群
        self.zanView =[[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.xiaDanV.frame) + 15, ScreenW - 30, 0)];
//        self.zanView.backgroundColor = [UIColor greenColor];
        [self addSubview:self.zanView];
        [self setZanRenYuan:@[@"文件覅就",@"地方那个",@"二",@"瑞",@"得对你",@"诶诶看见",@"文件覅就",@"地方那个",@"二",@"瑞",@"得对你",@"诶",@"文件覅就",@"地方那个",@"二",@"瑞",@"得对你",@"诶诶看见"]];
        
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(ScreenW/2 - 85 - 20, CGRectGetMaxY(self.zanView.frame) +  22.5, 85, 25);
        [button setImage:[UIImage imageNamed:@"praise_n"] forState:UIControlStateNormal];
        [button setTitle:@"赞" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:CharacterGrayColor102 forState:UIControlStateNormal];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 200;
        button.layer.cornerRadius = 12.5;
        button.clipsToBounds = YES;
        button.layer.borderColor = CharacterGrayColor102.CGColor;
        button.layer.borderWidth = 1.0;
        self.zanBt = button;
        [self addSubview:button];

        UIButton * button1 =[UIButton buttonWithType:UIButtonTypeCustom];
        button1.frame = CGRectMake(ScreenW/2 + 20, CGRectGetMaxY(self.zanView.frame) +  22.5, 85, 25);
        [button1 setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        [button1 setBackgroundImage:[UIImage imageNamed:@"zk_blue"] forState:UIControlStateNormal];
        [button1 setTitle:@"分享" forState:UIControlStateNormal];
        button1.titleLabel.font = [UIFont systemFontOfSize:14];
        [button1 setTitleColor:WhiteColor forState:UIControlStateNormal];
        button1.layer.cornerRadius = 12.5;
        button1.clipsToBounds = YES;
        button1.tag = 202;
        [button1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        self.shareBt = button1;
        [self addSubview:button1];
        
        UIButton * button2 =[UIButton buttonWithType:UIButtonTypeCustom];
        button2.frame = CGRectMake(ScreenW/2 - 85 - 20, CGRectGetMaxY(self.zanView.frame) +  22.5, 85, 25);
//        [button2 setImage:[UIImage imageNamed:@"praise_n"] forState:UIControlStateNormal];
        [button2 setTitle:@"下单" forState:UIControlStateNormal];
        button2.titleLabel.font = [UIFont systemFontOfSize:14];
        [button2 setTitleColor:OrangeColor forState:UIControlStateNormal];
        button2.layer.cornerRadius = 12.5;
        button2.clipsToBounds = YES;
        button2.tag = 201;
        [button2 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        button2.layer.borderColor = OrangeColor.CGColor;
        button2.layer.borderWidth = 1.0;
        self.xianDanBt = button2;
        [self addSubview:button2];
        
        UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        
        [self addGestureRecognizer:tap];
        

    }
    return self;
}

- (void)setType:(NSInteger)type {
    _type = type;
    if (type == 2) {
        //帖子
        self.xianDanBt.hidden = NO;
        self.zanBt.mj_x = ScreenW/ 2 - 40 - 85 - 20;
        self.xianDanBt.mj_x = ScreenW/ 2 - 40;
        self.shareBt.mj_x = ScreenW/ 2 + 40 + 20;
    }else {
        self.xianDanBt.hidden = YES;
        self.zanBt.mj_x = ScreenW/2 -85 - 20;
        self.shareBt.mj_x = ScreenW/2 + 20;
    }
}

//点击整体
- (void)tap:(UITapGestureRecognizer *)tap {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickZanOrXiaDanOrShare:)]) {
        [self.delegate didClickZanOrXiaDanOrShare:100];
    }
    
    
}

//设置点赞人数
- (void)setZanRenYuan:(NSArray *)arr {
    
    [self.zanView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (arr.count == 0) {
        self.zanView.mj_h = 0;
    }
    NSString * str = [NSString stringWithFormat:@"等%ld人觉得很赞",arr.count]; 
    CGFloat lastW = [str getWidhtWithFontSize:14];
    
    CGFloat ww = 0;
    CGFloat yy = 0;
    NSInteger lines = 1;
    for (int i = 0 ; i < arr.count; i++) {
        if (lines > 3) {
            break;
        }
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.mj_x = ww;
        button.mj_y = yy;
        button.tag = i+1000;
        [button addTarget:self action:@selector(zanClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[NSString stringWithFormat:@"%@、",arr[i]] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:YellowColor forState:UIControlStateNormal];
        if (i == 0) {
            [button setImage:[UIImage imageNamed:@"praise_p"] forState:UIControlStateNormal];
        }
        [button sizeToFit];
        button.mj_h = 20;
        ww = ww + button.width;
        
        if (ww > ScreenW - 30 - lastW && lines == 3) {
            [button setTitle:str forState:UIControlStateNormal];
            [button setTitleColor:CharacterBlackColor30 forState:UIControlStateNormal];
            button.width = lastW;
            [self.zanView addSubview:button];
            break;
        }else if (ww > ScreenW - 30 ){
            button.mj_x = 0;
            button.mj_y = 20 * lines;
            yy = 20* lines;
            button.mj_h = button.mj_h ;
            ww = button.width;
            lines = lines + 1;
            
        }
        
        [self.zanView addSubview:button];
        self.zanView.mj_h = 20*lines;
        
        self.mj_h  = CGRectGetMaxY(self.zanView.frame)  +  70;
        
    }
    
}

- (void)setModel:(zkHomelModel *)model {
    _model = model;
    
    [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:model.createByUserPic] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"]];
    self.titleLB.text = model.createByNickName;
    self.signLB.text = [NSString stringWithTime:model.createDate];
    
    
    if ([model.type integerValue] == 2){
        //交易
        self.picsView.hidden = YES;
        self.contentLB.hidden = YES;
        self.xiaDanV.hidden = NO;
        self.xianDanBt.hidden = NO;
        self.shareBt.hidden = YES;
        self.zanBt.mj_x = ScreenW/2 -85 - 20;
        self.xianDanBt.mj_x = ScreenW/2 + 20;
        
//
//        self.zanBt.mj_x = ScreenW/ 2 - 40 - 85 - 20;
//        self.xianDanBt.mj_x = ScreenW/ 2 - 40;
        self.zanView.mj_y = CGRectGetMaxY(self.xiaDanV.frame) + 15;
        NSString * strTwo = @"";
        if ([model.tradeType integerValue] == 0) {
            //卖出
            strTwo = [NSString stringWithFormat:@"卖出%@",model.coinName];
        }else {
            //买入
            strTwo = [NSString stringWithFormat:@"买入%@",model.coinName];
        }
        NSMutableAttributedString * att = [strTwo getMutableAttributeStringWithFont:14 lineSpace:0 textColor:CharacterBlackColor30 textColorTwo:BlueColor nsrange:NSMakeRange(2, strTwo.length - 2)];
        UILabel * lb1 = (UILabel *)[self.xiaDanV viewWithTag:100];
        UILabel * lb12 = (UILabel *)[self.xiaDanV viewWithTag:101];
        UILabel * lb13 = (UILabel *)[self.xiaDanV viewWithTag:102];
        lb1.attributedText = att;
        lb12.text = [NSString stringWithFormat:@"成交价格 %@",model.tradePrice];
        lb13.text = [NSString stringWithFormat:@"成交价量 %@",model.tradeNum];
     } else {
        self.contentLB.hidden = NO;
        self.contentLB.attributedText = [model.content getMutableAttributeStringWithFont:14 lineSpace:4 textColor:CharacterColor50];
        self.contentLB.mj_h = [model.content getHeigtWithFontSize:14 lineSpace:4 width:ScreenW - 30];
        self.xiaDanV.hidden = YES;
        self.xianDanBt.hidden = YES;
        self.picsView.hidden = NO;
        self.picsView.mj_y = CGRectGetMaxY(self.contentLB.frame) + 8;
        [self setImgViews:model.imgList];
         if (model.imgList.count == 0) {
            self.zanView.mj_y = CGRectGetMaxY(self.contentLB.frame) + 10;
         }else {
            self.zanView.mj_y = CGRectGetMaxY(self.picsView.frame) + 15;
         }
        
        self.zanBt.mj_x = ScreenW/2 -85 - 20;
        self.shareBt.mj_x = ScreenW/2 + 20;
         
         self.zanBt.hidden = YES;
         self.shareBt.hidden = YES;
        

     }
    
    if (model.supportFlag) {
        [self.zanBt setImage:[UIImage imageNamed:@"praise_p"] forState:UIControlStateNormal];
    }else {
         [self.zanBt setImage:[UIImage imageNamed:@"praise_n"] forState:UIControlStateNormal];
    }
    
    
    if (model.supportNickNames.length == 0) {
        [self setZanRenYuan:@[]];
    }else {
        [self setZanRenYuan:[model.supportNickNames componentsSeparatedByString:@","]];
    }
    self.shareBt.mj_y = self.zanBt.mj_y = self.xianDanBt.mj_y = CGRectGetMaxY(self.zanView.frame) + 20;

    if ([model.type integerValue] == 1 || [model.type integerValue] == 3) {
        self.headHeight = CGRectGetMaxY(self.zanView.frame) + 20;
    }else {
       self.headHeight = CGRectGetMaxY(self.zanBt.frame) + 20;
    }
    
    
}

//图片的设定
- (void)setImgViews:(NSArray *)arr {
    //    arr = @[@"http://img.zcool.cn/community/0142135541fe180000019ae9b8cf86.jpg@1280w_1l_2o_100sh.png",@"http://img.zcool.cn/community/0117e2571b8b246ac72538120dd8a4.jpg"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (NSInteger i = arr.count; i < 9; i++) {
            UIImageView * imgV = [self.picsView viewWithTag:100+i];
            imgV.hidden = YES;
        }
    });
    
    if (arr.count == 0 ) {
        self.picsView.mj_h = 0;
        return;
    }
    
    CGFloat space = 8;
    CGFloat ww = (ScreenW - 85 - 20) / 3;
    CGFloat hh = 0;
    for (int i = 0 ; i < arr.count; i++) {
        UIImageView * imgV = [self.picsView viewWithTag:100+i];
        imgV.hidden = NO;
        [imgV sd_setImageWithURL:[NSURL URLWithString:arr[i]]];
        if (arr.count == 1) {
            //一张图片的布局
            imgV.size = CGSizeMake(ww, ww);
            imgV.x = 0;
            imgV.mj_y = 0;
            hh = ww;
            
        }else if (arr.count == 4) {
            //四张的布局
            imgV.size = CGSizeMake(ww, ww);
            imgV.x = (ww + space) * (i % 2);
            imgV.y = (ww + space) * (i / 2);
            hh = CGRectGetMaxY(imgV.frame);
            
        }else {
            imgV.size = CGSizeMake(ww, ww);
            imgV.x = (ww + space) * (i % 3);
            imgV.y = (ww + space) * (i / 3);
            hh = CGRectGetMaxY(imgV.frame);
        }
        [imgV sd_setImageWithURL:[NSURL URLWithString:arr[i]] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    }
    self.picsView.mj_h = hh;
    
}

- (void)zanClickAction :(UIButton *)button {
    
    NSLog(@"---\n%ld",button.tag);
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickZanPeopleWithID:andIsAll:)]) {
        BOOL isall = NO;
        if ([button.titleLabel.text isEqualToString:[NSString stringWithFormat:@"等%@人觉得很赞",self.model.supportCount]]) {
            isall = YES;
        }
        NSArray * arr = [self.model.supportUserIds componentsSeparatedByString:@","];
        
        [self.delegate didClickZanPeopleWithID:arr[button.tag - 1000] andIsAll:isall];
    }
    
    
    
}

- (void)click:(UIButton *)button {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickZanOrXiaDanOrShare:)]) {
        
        [self.delegate didClickZanOrXiaDanOrShare:button.tag-200];
    }
    
}

- (void)tapInView:(UITapGestureRecognizer *)tap {
    
    UIImageView * imgV = (UIImageView *)tap.view;
    NSInteger tag = imgV.tag - 100;
    //    zkPhotoShowVC * vc = [[zkPhotoShowVC alloc] initWithArray:@[] index:tag];
    
    [[zkPhotoShowVC alloc] initWithArray:self.model.imgList index:tag];
    
}


@end
