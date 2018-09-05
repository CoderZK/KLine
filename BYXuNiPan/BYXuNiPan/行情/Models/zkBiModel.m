//
//  zkBiModel.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/30.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkBiModel.h"

@implementation zkBiModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}

- (void)setKline:(zkBiModel *)kline {
    _kline = [zkBiModel mj_objectWithKeyValues:kline];
}

@end
