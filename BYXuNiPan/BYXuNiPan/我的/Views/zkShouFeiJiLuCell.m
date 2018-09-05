//
//  zkShouFeiJiLuCell.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/17.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkShouFeiJiLuCell.h"

@implementation zkShouFeiJiLuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.confirmBt.layer.shadowOffset = CGSizeMake(1, 2);
    self.confirmBt.layer.shadowColor= BlueColor.CGColor;
    self.confirmBt.layer.shadowOpacity = 0.8;
}

- (void)setModel:(zkShouFuJiLumodel *)model {
    _model = model;
    self.titleLB.text = model.title;
    self.typeLB.text = model.payType;
    self.timeLB.text = [NSString stringWithTime:model.payTime];
    self.eargingLB.text = model.money;
    self.rightLB.text = model.stateText;
    self.rightLB.hidden = NO;
    self.confirmBt.hidden = YES;
    if ([model.state integerValue] == 1) {
        self.rightLB.textColor = BlueColor;
    }else if ([model.state integerValue] == 2)  {
        self.rightLB.textColor = CharacterBlackColor30;
        self.rightLB.hidden = YES;
        self.confirmBt.hidden = NO;
    }else {
        self.rightLB.textColor = CharacterBlackColor30;
    }
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
