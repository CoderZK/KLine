//
//  zkSearchBiZhongCell.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/16.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkSearchBiZhongCell.h"

@implementation zkSearchBiZhongCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(zkBiModel *)model {
    _model = model;
    self.titleLB.text = [NSString stringWithFormat:@"%@(%@)",[model.baseCurrency uppercaseString],model.cnName];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
