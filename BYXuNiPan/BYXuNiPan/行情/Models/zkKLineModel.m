//
//  zkKLineModel.m
//  BYXuNiPan
//
//  Created by zk on 2018/8/7.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkKLineModel.h"

@implementation zkKLineModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}

- (void)setKline:(zkKLineModel *)kline {
    _kline = [zkKLineModel mj_objectWithKeyValues:kline];
}

@end
