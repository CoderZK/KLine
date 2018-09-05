//
//  zkDingYueZhiFuTwoCell.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/18.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkDingYueZhiFuTwoCell.h"

@implementation zkDingYueZhiFuTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imgV.layer.cornerRadius = 17.5;
    self.imgV.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
