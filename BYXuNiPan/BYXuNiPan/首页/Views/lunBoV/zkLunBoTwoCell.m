//
//  zkLunBoTwoCell.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/12.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkLunBoTwoCell.h"

@implementation zkLunBoTwoCell

- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    if (self) {
        self.imgV = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.imgV];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



@end
