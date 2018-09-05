//
//  zkSystemNotificationCell.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/12.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkSystemNotificationCell.h"

@implementation zkSystemNotificationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(zkMessageModel *)model {
    _model = model;

    self.titleLB.text = model.title;
    self.contentLB.text = model.profile;
    self.timeLb.text = [NSString stringWithTime:model.createDate];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
