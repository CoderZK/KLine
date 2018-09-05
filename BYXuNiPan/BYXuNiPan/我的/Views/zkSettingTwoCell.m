//
//  zkSettingTwoCell.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/17.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkSettingTwoCell.h"

@implementation zkSettingTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.leftImageV.layer.cornerRadius = 17.5;
    self.leftImageV.clipsToBounds = YES;
    self.rightImgV.hidden = YES;
    self.titleLBRightCon.constant = 15;
    self.rightLB.hidden = YES;
}

- (void)setType:(NSInteger)type {
    _type = type;
    if (type == 1) {
        self.imgVwidthCon.constant = 40;
        self.imgHeightCon.constant = 40;
        self.leftImageV.layer.cornerRadius = 20;
        self.rightImgV.hidden = NO;
        self.titleLBRightCon.constant = 40;
        self.headWidthCon.constant = 40;
        self.headHeightCon.constant = 40;
    }else if (type == 2) {
        self.imgVwidthCon.constant = 45;
        self.imgHeightCon.constant = 45;
        self.leftImageV.layer.cornerRadius = 22.5;
        self.rightImgV.hidden = NO;
        self.titleLBRightCon.constant = 40;
        self.headWidthCon.constant = 45;
        self.headHeightCon.constant = 45;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
