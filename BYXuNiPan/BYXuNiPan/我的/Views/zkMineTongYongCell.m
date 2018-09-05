//
//  zkMineTongYongCell.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/14.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkMineTongYongCell.h"

@implementation zkMineTongYongCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.redV.layer.cornerRadius = 2;
    self.redV.clipsToBounds = YES;
    self.redV.backgroundColor = RedColor;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
