//
//  zkBiZhongChiCangTwoCell.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/20.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkBiZhongChiCangTwoCell.h"

@implementation zkBiZhongChiCangTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(zkOneBtcChiCangModel *)model {
    _model = model;
    self.biZhongNameLB.text = [self.model.bitName uppercaseString];
    self.jiaGeLB.text = model.currentPrice;
    //涨跌
    CGFloat zhangDie = [model.riseFall floatValue];
    if (zhangDie> 0) {
        self.desLB.textColor = GreenColor;
    }else if (zhangDie == 0){
        self.desLB.textColor = CharacterGrayColor102;
    }else {
        self.desLB.textColor = RedColor;
    }
    self.desLB.text = [NSString stringWithFormat:@"%0.4f",[model.riseFall floatValue]];
    self.zhangDieCon.constant = [[NSString stringWithFormat:@"%0.4f",[model.riseFall floatValue]] getWidhtWithFontSize:14];
    
    //涨跌幅
    CGFloat zhangdiefu = [model.riseFallPercent floatValue];
    if (zhangdiefu> 0) {
        self.zhangDieFuLb.textColor = GreenColor;
    }else if (zhangdiefu == 0){
        self.zhangDieFuLb.textColor = CharacterGrayColor102;
    }else {
        self.zhangDieFuLb.textColor = RedColor;
    }
     self.zhangDieFuLb.text = [NSString stringWithFormat:@"%0.4f%%",zhangdiefu];
    
    //盈亏
    CGFloat yingkui = [model.earnLoss floatValue];
    if (yingkui> 0) {
        self.yingKuiLB.textColor = GreenColor;
    }else if (yingkui == 0){
        self.yingKuiLB.textColor = CharacterGrayColor102;
    }else {
        self.yingKuiLB.textColor = RedColor;
    }
    self.yingKuiLB.text = [NSString stringWithFormat:@"%0.2f",yingkui];
    
    //盈亏率
    CGFloat yingkuilv = [model.earnLossPercent floatValue];
    if (yingkuilv> 0) {
        self.shouYiLB.textColor = GreenColor;
    }else if (yingkuilv == 0){
        self.shouYiLB.textColor = CharacterGrayColor102;
    }else {
        self.shouYiLB.textColor = RedColor;
    }
    self.shouYiLB.text = [NSString stringWithFormat:@"%0.2f%%",yingkuilv];
    
    //最新市值
    self.shiZhiLB.text = [NSString stringWithFormat:@"%0.2f亿",[model.marketValue floatValue]];
    //每股成本
    self.meiGuChengBenLB.text = [NSString stringWithFormat:@"%0.2f",[model.costPerThigh floatValue]];
    //持仓数量
     self.chiCangLB.text = [NSString stringWithFormat:@"%0.2f",[model.amount floatValue]];
    //kemai
    self.numberLB.text = [NSString stringWithFormat:@"%0.2f",[model.canSellAmount floatValue]];
    //仓位
    self.cangWeiLB.text = [NSString stringWithFormat:@"%0.2f%%",[model.positionLevel floatValue]];
    //时间
    if (model.createPositionTime.length >= 10) {
      self.timeLB.text = [model.createPositionTime substringToIndex:10];
    }else {
        self.timeLB.text = @"";
    }
    
}


@end
