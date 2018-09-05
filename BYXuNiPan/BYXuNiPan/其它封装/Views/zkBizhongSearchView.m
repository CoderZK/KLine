//
//  zkBizhongSearchView.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/16.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkBizhongSearchView.h"



@implementation zkBizhongSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
 
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, ScreenW - 30, 20)];
        lb.textColor = CharacterColor50;
        lb.font = kFont(15);
        lb.text = @"搜索记录";
        [self addSubview:lb];
        
        self.headView =[[UIView alloc] initWithFrame:CGRectMake(0, 35, ScreenW, 150)];
        _headView.backgroundColor = [UIColor whiteColor];
        
        self.clearBt = [UIButton buttonWithType:UIButtonTypeCustom];
        self.clearBt.frame = CGRectMake(15, 20, ScreenW - 30, 40);
        [self.clearBt setTitle:@"清除历史" forState:UIControlStateNormal];
        [self.clearBt setTitleColor:CharacterBlackColor30 forState:UIControlStateNormal];
        [self.clearBt addTarget:self action:@selector(clearAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.clearBt];
        
    }
    return self;
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    _dataArr = dataArr;

     [self.headView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (self.dataArr.count == 0) {
        self.clearBt.hidden = YES;
       
        return;
    }
    self.clearBt.hidden = NO;
    CGFloat totalW = 0;
    NSInteger number = 1;
    CGFloat btH = 30;
    CGFloat spaceW = 15;
    CGFloat spaceH = 15;
    
    for (int i = 0 ; i < dataArr.count; i++) {
       
        UIButton * button =[UIButton new];
        button.tag = 100+i;
        [button setTitleColor:CharacterBlackColor30 forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage imageNamed:@"zk_aihaochange"] forState:UIControlStateNormal];
//        [button setBackgroundImage:[UIImage imageNamed:@"zk_aihao"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.borderWidth = 0.6;
        button.layer.borderColor = CharacterColor50.CGColor;
        button.layer.cornerRadius = 3;
        button.clipsToBounds = YES;
        button.titleLabel.font =[UIFont systemFontOfSize:14];
        NSString * str = [NSString stringWithFormat:@"%@",self.dataArr[i]];
      
        [button setTitle:str forState:UIControlStateNormal];
        CGFloat width =[str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}].width + 20 + spaceW;
        
        button.x = 15  + totalW;
        button.y = 20+(number-1) *(btH+spaceH);
        button.height =btH;
        button.width = width -spaceW;
        totalW = button.x + button.width ;
        
        if(totalW  > ScreenW - 15) {
            totalW = 0;
            number +=1;
            button.x = 15  + totalW;
            button.y =20+ (number-1) *(btH + spaceH);
            button.height = btH;
            button.width = width -spaceW;
            totalW = button.x + button.width ;
        }
        [_headView addSubview:button];

        
        
    }
//    _headView.backgroundColor =[UIColor redColor];
    _headView.height = 5 + number * (btH + spaceH);
    self.clearBt.mj_y = _headView.height + 40;
    [self addSubview:_headView];
    
}

-(void)btnClick:(UIButton *)button{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didClickBiZhongWithStr:)]) {
        [self.delegate didClickBiZhongWithStr:self.dataArr[button.tag - 100]];
    }
}

- (void)clearAction:(UIButton *)button {
    
    [zkSignleTool shareTool].serachBiZhong = [NSMutableArray array];
    self.dataArr = @[].mutableCopy;
    
}

@end
