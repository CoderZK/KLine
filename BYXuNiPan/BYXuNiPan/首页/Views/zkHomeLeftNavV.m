//
//  zkHomeLeftNavV.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/11.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkHomeLeftNavV.h"

@interface zkHomeLeftNavV()
/** 注释 */
@property(nonatomic,strong)UIButton *leftBt ,*rightBt;
/**  */
@property(nonatomic,strong)UIView *blueV;

/** 注释 */
@property(nonatomic,assign)CGFloat w;

@end

@implementation zkHomeLeftNavV

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
       
        self.leftBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftBt.frame = CGRectMake(0, 0, frame.size.width/2, frame.size.height - 2);
        self.leftBt.titleLabel.font  = kFont(16);
        [self.leftBt setTitleColor:DarkBlueColor forState:UIControlStateNormal];
        _leftBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _leftBt.tag = 1;
        [_leftBt setTitle:@"关注" forState:UIControlStateNormal];
        [_leftBt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftBt];
        
        
        self.rightBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBt.frame = CGRectMake(frame.size.width/2, 0, frame.size.width/2, frame.size.height - 2);
        self.rightBt.titleLabel.font  = kFont(16);
        [self.rightBt setTitleColor:DarkBlueColor forState:UIControlStateNormal];
        self.rightBt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        self.rightBt.tag = 2;
        [self.rightBt setTitle:@"推荐" forState:UIControlStateNormal];
        [self.rightBt addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.rightBt];
        
        _w = [@"推荐" getSizeWithMaxSize:CGSizeMake(200, 60) withFontSize:16].width;
        
        self.blueV = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width - self.w, frame.size.height - 2, self.w, 2)];
        self.blueV.backgroundColor = DarkBlueColor;
        self.blueV.layer.cornerRadius = 1;
        self.blueV.clipsToBounds = YES;
        [self addSubview:self.blueV];
        
        
    }
    return self;
}

- (void)click:(UIButton *)button {
    
    if (button.tag == 1) {
        [UIView animateWithDuration:0.2 animations:^{
            self.blueV.mj_x = 0;
        }];
    }else {
        [UIView animateWithDuration:0.2 animations:^{
            self.blueV.mj_x = self.frame.size.width - self.w;
        }];
        
    }
    
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didSelectLeftNavWithIndex:)]) {
        [self.delegate didSelectLeftNavWithIndex:button.tag];
    }
    
    
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    if (selectIndex == 1) {
        [UIView animateWithDuration:0.2 animations:^{
            self.blueV.mj_x = 0;
        }];
    }else {
        [UIView animateWithDuration:0.2 animations:^{
            self.blueV.mj_x = self.frame.size.width - self.w;
        }];
        
    }
    
    
    
}

@end
