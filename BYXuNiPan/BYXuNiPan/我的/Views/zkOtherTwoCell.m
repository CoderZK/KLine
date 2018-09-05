//
//  zkOtherTwoCell.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/13.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkOtherTwoCell.h"

@implementation zkOtherTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(zkUserInfoModel *)model {
    _model = model;
    
    double all = [model.totalAssets doubleValue];
    
    self.allMoneyLB.text = [NSString stringWithFormat:@"%0.2f",all];
    CGFloat aa = [model.totalRank integerValue];
    if (aa > 10000) {
       self.allRankingLB.text = [NSString stringWithFormat:@"累计排名(%0.1f万名)",aa/10000.0];
    }else {
      self.allRankingLB.text = [NSString stringWithFormat:@"累计排名(%@名)",model.totalRank];
    }
    self.allRatioLB.text = [NSString stringWithFormat:@"%0.2f%%",[model.totalProfit floatValue] ];
    
    //日收益排名
    CGFloat day = [model.dayRank integerValue];
    if (day > 10000) {
        self.dayRankingLB.text = [NSString stringWithFormat:@"日(%0.1f万名)",day/10000.0];
    }else {
        self.dayRankingLB.text = [NSString stringWithFormat:@"日(%@名)",model.dayRank];
    }
     self.dayRationLB.text = [NSString stringWithFormat:@"%0.2f%%",[model.dayProfit floatValue] ];
    
    
    //周排名
    CGFloat week = [model.weekRank integerValue];
    if (week > 10000) {
        self.weekRankingLB.text = [NSString stringWithFormat:@"周(%0.1f万名)",week/10000.0];
    }else {
        self.weekRankingLB.text = [NSString stringWithFormat:@"周(%@名)",model.weekRank];
    }
    //周收益
    self.weekRationLB.text = [NSString stringWithFormat:@"%0.2f%%",[model.weekProfit floatValue]];
    
    //本金
    self.capitalNumberLB.text = model.principal;
    //日操作
    self.dayOpcationLB.text = [NSString stringWithFormat:@"%0.2f次",[model.operation floatValue]];
    
}


- (void)setModelTwo:(zkOtherCenterModel *)modelTwo {
    _modelTwo = modelTwo;
    
    self.allMoneyLB.text = modelTwo.totalAmount;
    CGFloat aa = [modelTwo.accumulatedRanking integerValue];
    if (aa > 10000) {
        self.allRankingLB.text = [NSString stringWithFormat:@"累计排名(%0.1f万名)",aa/10000.0];
    }else {
        self.allRankingLB.text = [NSString stringWithFormat:@"累计排名(%@名)",modelTwo.accumulatedRanking];
    }
    self.allRatioLB.text = [NSString stringWithFormat:@"%0.2f%%",[modelTwo.accumulatedIncome floatValue] * 100 ];
    
    CGFloat day = [modelTwo.dailyRanking integerValue];
    if (day > 10000) {
        self.dayRankingLB.text = [NSString stringWithFormat:@"日(%0.1f万名)",day/10000.0];
    }else {
        self.dayRankingLB.text = [NSString stringWithFormat:@"日(%@名)",modelTwo.dailyRanking];
    }
    self.dayRationLB.text = [NSString stringWithFormat:@"%0.2f%%",[modelTwo.dailyIncome floatValue] * 100 ];
    
    
    CGFloat week = [modelTwo.weekRanking integerValue];
    if (week > 10000) {
        self.weekRankingLB.text = [NSString stringWithFormat:@"日(%0.1f万名)",week/10000.0];
    }else {
        self.weekRankingLB.text = [NSString stringWithFormat:@"日(%@名)",modelTwo.weekRanking];
    }
    self.weekRationLB.text = [NSString stringWithFormat:@"%0.2f%%",[modelTwo.weekIncome floatValue] * 100 ];
    
    self.capitalNumberLB.text = modelTwo.principal;
    self.dayOpcationLB.text = [NSString stringWithFormat:@"%0.2f次",[modelTwo.dailyOperateCount floatValue]];
//    self.capitalNumberLB.text = ;
    
}


@end
