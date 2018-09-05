//
//  zkOtherOneCell.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/13.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkOtherOneCell.h"

@implementation zkOtherOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.headBt setBackgroundImage:[UIImage imageNamed:@"369"] forState:UIControlStateNormal];
    self.headBt.layer.cornerRadius = 22.5;
    self.headBt.clipsToBounds = YES;
    
    self.dingYueBt.layer.shadowOffset=CGSizeMake(1, 3);
    self.dingYueBt.layer.shadowColor = BlueColor.CGColor;
    self.dingYueBt.layer.shadowOpacity = 0.8;


    
    
}

- (void)setModel:(zkOtherCenterModel *)model {
    _model = model;
    self.titleLB.text = model.nickName;
    self.contentLB.text = model.sign;
    [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:model.userPic] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    if ([model.myHome integerValue] == 1 || [model.followFlag integerValue] == 1) {
        self.dingYueBt.hidden = YES;
    }else {
        self.dingYueBt.hidden = NO;
    }
    NSInteger fans = [model.fansCount integerValue];
    if (fans > 10000) {
        self.fensiLb.text = [NSString stringWithFormat:@"%0.1f万",fans/10000.0];
    }else {
        self.fensiLb.text = model.fansCount;
    }
    
    NSInteger ziXuan = [model.holdLxcCount integerValue];
    if (ziXuan > 10000) {
        self.ziXuanLB.text = [NSString stringWithFormat:@"%0.1f万",ziXuan/10000.0];
    }else {
        self.ziXuanLB.text = model.holdLxcCount;
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
