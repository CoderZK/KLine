//
//  zkChiCangMingXiCell.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/14.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkChiCangMingXiCell.h"

@implementation zkChiCangMingXiCell

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
    self.chiCangLB.text = titleArr[1];
    self.biZhongLB.text = titleArr[0];
    self.chiCangJiaLB.text = titleArr[2];
    self.nowJiaLB.text = titleArr[3];
    self.earningsLB.text = titleArr[4];
    
}


- (void)setModel:(zkBTCChiYouModel *)model {
    _model = model;
    self.biZhongLB.text = [model.bitName uppercaseString];
    CGFloat amount = [model.amount floatValue];
    //持仓比例
    NSString * str = @"";
    if (amount > 10000) {
        str = [NSString stringWithFormat:@"%0.1f万(%0.2f%%)",amount/10000,[model.percent floatValue]];
    }else if (amount > 100) {
        str = [NSString stringWithFormat:@"%0.1f(%0.2f%%)",amount,[model.percent floatValue]];
    }else if (amount >= 0) {
        str = [NSString stringWithFormat:@"%0.2f(%0.2f%%)",amount,[model.percent floatValue]];
    }else {
        str = [NSString stringWithFormat:@"%0.3f(%0.2f%%)",amount,[model.percent floatValue]];
    }
    self.chiCangLB.text = str;
    
    //持仓价
    if (model.avgPrice.length >= 6) {
        self.chiCangJiaLB.text = [model.avgPrice substringToIndex:6];
    }else {
        self.chiCangJiaLB.text = model.avgPrice;
    }
    
    //当前价格
    if (model.currentprice.length >= 6) {
        self.nowJiaLB.text = [model.currentprice substringToIndex:6];
    }else {
        self.nowJiaLB.text = model.currentprice;
    }
    //收益lv
    CGFloat earn = [model.earnPercent floatValue];
    if (earn > 0) {
         self.earningsLB.textColor = GreenColor;
    }else if (earn == 0){
        self.earningsLB.textColor = CharacterGrayColor102;
    }else {
        self.earningsLB.textColor = RedColor;
    }
    self.earningsLB.text = [NSString stringWithFormat:@"%0.2f%%",earn];
    
    
}

@end
