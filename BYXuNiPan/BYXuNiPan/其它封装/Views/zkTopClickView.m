//
//  zkTopClickView.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/16.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkTopClickView.h"

@interface zkTopClickView() <zkTopNeiViewDelegate>

@end

@implementation zkTopClickView

- (instancetype)initWithFreame:(CGRect)frame alignmentArr:(NSArray *)alignmentArr titleArr:(NSArray *)titleArr {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat ww = (ScreenW - 30) / titleArr.count;
        for (int i = 0 ; i < titleArr.count; i++) {
            
            zkTopNeiView * vv = [[zkTopNeiView alloc] initWithFrame:CGRectMake(15 + i * ww, (frame.size.height - 30)/2, ww, 30)];
            vv.tag = 200 + i;
            vv.AlignmentType = [alignmentArr[i] integerValue];
            vv.titleStr = titleArr[i];
            vv.delegate = self;
            [self addSubview:vv];
            
        }
        
    }
    self.backgroundColor = WhiteColor;
    return self;
}

- (void)didSelectButton:(UIButton *)button view:(zkTopNeiView *)view times:(NSInteger)times {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(clickTopChooseIndex:times:)]) {
        [self.delegate clickTopChooseIndex:view.tag - 200 times:times];
    }
    
}

@end





@interface zkTopNeiView()
@property(nonatomic,assign)NSInteger selectTimes;
@property(nonatomic,strong)UILabel *titleLB;
@property(nonatomic,strong)UIButton *leftBt;
@property(nonatomic,strong)UIImageView *upImageV;
@property(nonatomic,strong)UIImageView *downImageV;

@end

@implementation zkTopNeiView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        self.selectTimes = 0;
        self.titleLB  = [[UILabel alloc] initWithFrame:self.bounds];
        self.titleLB.font = kFont(13);
       
        self.titleLB.textColor = RGB(140, 140, 140);
        [self addSubview:self.titleLB];

        [self.leftBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        self.leftBt.mj_h = 25;
        self.upImageV = [[UIImageView alloc] init];
        self.upImageV.size = CGSizeMake(7, 7);
        [self addSubview:self.upImageV];
        self.upImageV.image = [UIImage imageNamed:@"up_n"];
        self.upImageV.mj_y = self.centerY - 7.5;
        
        
        self.downImageV = [[UIImageView alloc] init];
        self.downImageV.size = CGSizeMake(7, 7);
        self.downImageV.mj_y = self.centerY + 0.5;
        self.downImageV.image = [UIImage imageNamed:@"down_n"];
        [self addSubview:self.downImageV];
        
        
        self.leftBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftBt.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.leftBt.tag = 100;
        [self.leftBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
//        self.leftBt.backgroundColor =[UIColor redColor];
        [self addSubview:self.leftBt];
    
        self.clipsToBounds = YES;
        
    }
    return self;
}

- (void)setAlignmentType:(NSInteger)AlignmentType {
    _AlignmentType = AlignmentType;
}

- (void)setTitleStr:(NSString *)titleStr {
    
    if (self.AlignmentType == 0) {
       
    
        self.titleLB.text = titleStr;
        [self.titleLB sizeToFit];
        
        self.titleLB.mj_x = 0;
        self.titleLB.centerY = self.centerY;
        
        self.upImageV.mj_x = CGRectGetMaxX(self.titleLB.frame) + 5;
        self.downImageV.mj_x = CGRectGetMaxX(self.titleLB.frame) + 5;
        
        self.leftBt.mj_x = 0;
        self.leftBt.mj_w = self.titleLB.width + 15;
        self.leftBt.centerY = self.centerY;

    }else if (self.AlignmentType == 1) {
        self.titleLB.text = titleStr;
        [self.titleLB sizeToFit];
        self.titleLB.mj_x = self.mj_w / 2 -self.titleLB.mj_w  ;
        self.titleLB.centerY = self.centerY;
        self.upImageV.mj_x = CGRectGetMaxX(self.titleLB.frame) + 5;
        self.downImageV.mj_x = CGRectGetMaxX(self.titleLB.frame) + 5;
        
        self.leftBt.mj_w = self.titleLB.width + 15;
        self.leftBt.centerY = self.centerY;
        self.leftBt.mj_x = self.mj_w / 2 - self.leftBt.mj_w / 2;
      
        
    }else {
        
        self.titleLB.text = titleStr;
        [self.titleLB sizeToFit];
        self.titleLB.centerY = self.centerY;
        self.titleLB.mj_x = self.frame.size.width - 7 - 5 - self.titleLB.mj_w;
        self.upImageV.mj_x = CGRectGetMaxX(self.titleLB.frame) + 5;
        self.downImageV.mj_x = CGRectGetMaxX(self.titleLB.frame) + 5;
        
        self.leftBt.mj_w = self.titleLB.width + 15;
        self.leftBt.mj_x = self.frame.size.width - self.leftBt.width;
        
    }
    
}

- (void)clickAction:(UIButton *)button {
    self.selectTimes = self.selectTimes % 3 + 1;
    if (self.selectTimes% 3  == 0) {
        self.titleLB.textColor = RGB(140, 140, 140);
        self.upImageV.image = [UIImage imageNamed:@"up_n"];
        self.downImageV.image = [UIImage imageNamed:@"down_n"];
    }else {
        self.titleLB.textColor = RGB(36, 101, 237);
        if (self.selectTimes % 3 == 1) {
            self.upImageV.image = [UIImage imageNamed:@"up_n"];
            self.downImageV.image = [UIImage imageNamed:@"down_p"];
        }else {
            self.upImageV.image = [UIImage imageNamed:@"up_p"];
            self.downImageV.image = [UIImage imageNamed:@"down_n"];
        }
    }
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didSelectButton:view:times:)]) {
        [self.delegate didSelectButton:button view:self times:(self.selectTimes % 3)];
    }
    
    
}

- (void)setIsSelect:(BOOL)isSelect {
    _isSelect = isSelect;
    self.titleLB.textColor = RGB(140, 140, 140);
    self.upImageV.image = [UIImage imageNamed:@"up_n"];
    self.downImageV.image = [UIImage imageNamed:@"down_n"];
    
}


@end
