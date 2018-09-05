//
//  zkSearchJiaoYiCell.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/19.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkSearchJiaoYiCell.h"

@implementation zkSearchJiaoYiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headBt.layer.cornerRadius = 22.5;
    self.headBt.clipsToBounds = YES;
    self.titleLB.textColor = OrangeColor;
    self.biZhongLB.textColor = BlueColor;
}

- (void)setModel:(zkSearchModel *)model {
    _model = model;
    [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:model.createByUserPic] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    self.titleLB.text = model.createByNickName;
    self.timeLB.text = [NSString getTimeMMddWithTime:model.createDate];
    NSString * strTwo = @"";
    if ([model.tradeType integerValue] == 0) {
        //卖出
        self.buyOrSellLB.text = @"卖出";
    }else {
        //买入
        self.buyOrSellLB.text = @"买入";

    }
//    NSMutableAttributedString * att = [strTwo getMutableAttributeStringWithFont:14 lineSpace:0 textColor:CharacterBlackColor30 textColorTwo:BlueColor nsrange:NSMakeRange(2, strTwo.length - 2)];
    self.biZhongLB.text = [model.tradeCoinName uppercaseString];
    self.biZhongLB.textColor = BlueColor;
    self.priceLB.text = [NSString stringWithFormat:@"成交价格 %@",model.tradePrice];
    self.numberLB.text = [NSString stringWithFormat:@"成交数量 %@",model.tradeNum];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
