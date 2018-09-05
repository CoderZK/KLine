//
//  zkBtcRankModel.m
//  BYXuNiPan
//
//  Created by zk on 2018/8/13.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkBtcRankModel.h"

@implementation zkBtcRankModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}

- (void)setBitBean:(NSArray<zkBtcRankModel *> *)bitBean {
    _bitBean = [zkBtcRankModel mj_objectArrayWithKeyValuesArray:bitBean];
}

- (void)setRankListResponse:(zkBtcRankModel *)rankListResponse {
    _rankListResponse = [zkBtcRankModel mj_objectWithKeyValues:rankListResponse];
}

@end
