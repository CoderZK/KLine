//
//  zkChengJiaoLiShiCell.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/14.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkChengJiaoLiShiCell.h"

@implementation zkChengJiaoLiShiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitleArr:(NSArray *)titleArr {
    
    _titleArr = titleArr;
    self.TypeLB.text = titleArr[0];
    self.biZhongLB.text = titleArr[1];
    self.weiTuoLB.text = titleArr[2];
    self.numberLB.text = titleArr[3];
    self.timeLB.text = titleArr[4];
    
}

- (void)setModel:(zkBTCChiYouModel *)model {
    _model = model;
    //买卖
    if ([model.type integerValue] == 1 || [model.type integerValue] == 3) {
        self.TypeLB.text = @"买";
    }else {
        self.TypeLB.text = @"卖";
    }
    //币种
    self.biZhongLB.text= [model.bitName uppercaseString];
    
    //持仓价
    if (model.price.length >= 6) {
        self.weiTuoLB.text = [model.finalPrice substringToIndex:6];
    }else {
        self.weiTuoLB.text = model.finalPrice;
    }

    //持仓数量
    CGFloat amount = [model.amount floatValue];
    NSString * str = @"";
    if (amount > 10000) {
        str = [NSString stringWithFormat:@"%0.1f万",amount/10000];
    }else if (amount > 100) {
        str = [NSString stringWithFormat:@"%0.1f",amount];
    }else if (amount >= 0) {
        str = [NSString stringWithFormat:@"%0.2f",amount];
    }else {
        str = [NSString stringWithFormat:@"%0.3f",amount];
    }
    self.numberLB.text = str;
    self.timeLB.text = [NSString getTimeMMddWithTime:model.updateTime];
}


@end
