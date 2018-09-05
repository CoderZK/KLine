//
//  zkHangQingCell.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/16.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkHangQingCell.h"

@implementation zkHangQingCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.rankingLB.backgroundColor = PMBlue123;
    self.rankingLB.layer.cornerRadius = 1;
    self.rankingLB.clipsToBounds = YES;
    [self.earningBt setBackgroundImage:[UIImage imageNamed:@"kuang1"] forState:UIControlStateNormal];
    
}

- (void)setModel:(zkBiModel *)model {
    _model = model;
    self.biZhongLB.text = [NSString stringWithFormat:@"%@(%@)",[model.bitName uppercaseString],model.bitCnName];
    self.nowJiaGeLB.text = model.cny;
    self.shiZhiTwoLB.text = [NSString stringWithFormat:@"$%@",model.price];
    self.shiZhiLB.text = [NSString stringWithFormat:@"市值%@亿",model.marketValue];
    [self.earningBt setTitle:[NSString stringWithFormat:@"%0.2f%%",[model.increase floatValue]] forState:UIControlStateNormal];
    CGFloat ss = [model.increase floatValue];
    if (ss > 0) {
        [self.earningBt setBackgroundImage:[UIImage imageNamed:@"kuang1"] forState:UIControlStateNormal];
         [self.earningBt setTitle:[NSString stringWithFormat:@"+%0.2f%%",[model.increase floatValue]] forState:UIControlStateNormal];
    }else if (ss == 0) {
        [self.earningBt setBackgroundImage:[UIImage imageNamed:@"kuang3"] forState:UIControlStateNormal];
    }else {
        [self.earningBt setBackgroundImage:[UIImage imageNamed:@"kuang2"] forState:UIControlStateNormal];
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
