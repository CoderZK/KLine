//
//  zkSettingCell.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/16.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkSettingCell.h"

@implementation zkSettingCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.swiftOn.transform = CGAffineTransformMakeScale(0.8, 0.8);
    self.swiftOn.hidden = YES;
}

- (void)setHidenRightImgV:(BOOL)hidenRightImgV {
    _hidenRightImgV = hidenRightImgV;
    self.rightImageV.hidden = hidenRightImgV;
    if (hidenRightImgV) {
        self.rightCon.constant = 15;
    }else {
        self.rightCon.constant = 40;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
