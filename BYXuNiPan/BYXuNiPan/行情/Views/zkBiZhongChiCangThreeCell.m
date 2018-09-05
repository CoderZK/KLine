//
//  zkBiZhongChiCangThreeCell.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/20.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkBiZhongChiCangThreeCell.h"

@implementation zkBiZhongChiCangThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.viewUpV.hidden = self.viewDownV.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(zkOneBtcChiCangModel *)model {
    _model = model;
    NSString * str = @"";
    if ([model.direction isEqualToString:@"buy"]) {
        self.pointImgV.image =[UIImage imageNamed:@"point"];
        self.timeImgeV.image = [UIImage imageNamed:@"arrows"];
        
        str = [NSString stringWithFormat:@"买入%@个,成交价%@,仓位占比:%0.2f%%",model.tradeAmount,model.price,[model.positionPercent floatValue]];
        
    }else {
        self.pointImgV.image =[UIImage imageNamed:@"point2"];
        self.timeImgeV.image = [UIImage imageNamed:@"arrows2"];
        str = [NSString stringWithFormat:@"卖出%@个,成交价%@,份额比例:%0.2f%%",model.tradeAmount,model.price,[model.positionPercent floatValue]];
    }
    self.timeLB.text = model.tradeTime;
    self.contentLB.text = str;
    
}


@end
