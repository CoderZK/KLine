//
//  zkNewsOneCell.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/12.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkNewsOneCell.h"

@implementation zkNewsOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.numberLB.layer.cornerRadius = 10;
    self.numberLB.clipsToBounds = YES;

}

- (void)setNumberStr:(NSString *)numberStr {
    self.numberLB.hidden = NO;
    _numberStr = numberStr;
    self.numberLB.text = numberStr;
    CGFloat ww = [numberStr getWidhtWithFontSize:13] + 10;
    if (numberStr.length == 1) {
        ww = 20;
    }
    if ([numberStr isEqualToString:@"0"] || numberStr.length == 0) {
        self.numberLB.hidden = YES;
    }
    self.widthConstraint.constant = ww;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
