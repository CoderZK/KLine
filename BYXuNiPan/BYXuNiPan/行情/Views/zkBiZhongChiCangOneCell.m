//
//  zkBiZhongChiCangOneCell.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/20.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkBiZhongChiCangOneCell.h"

@implementation zkBiZhongChiCangOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headBt.layer.cornerRadius = 20;
    self.headBt.clipsToBounds = YES;
    self.guanZhuLB.textColor = BlueColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
