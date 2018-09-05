//
//  zkZhangDieFuView.m
//  BYXuNiPan
//
//  Created by zk on 2018/8/6.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkZhangDieFuView.h"

@implementation zkZhangDieFuView


- (UILabel *)private_createLabel
{
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:13];
    //    label.width = 40;
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
    return label;
}
@end
