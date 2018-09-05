//
//  zkSearchTieZiCell.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/19.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkSearchTieZiCell.h"

@implementation zkSearchTieZiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headBt.layer.cornerRadius = 22.5;
    self.headBt.clipsToBounds = YES;
    self.titleLB.textColor = OrangeColor;
}

- (void)setModel:(zkSearchModel *)model {
    _model = model;
    [self.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:model.createByUserPic] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    self.titleLB.text = model.createByNickName;
    self.timeLB.text = [NSString stringWithTime:model.createDate];
    self.contentLB.text = model.profile;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
