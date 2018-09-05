//
//  zkOneBtcChiCangModel.m
//  BYXuNiPan
//
//  Created by zk on 2018/8/13.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkOneBtcChiCangModel.h"

@implementation zkOneBtcChiCangModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}

- (void)setRecords:(NSMutableArray<zkOneBtcChiCangModel *> *)records {
    _records = [zkOneBtcChiCangModel mj_objectArrayWithKeyValuesArray:records];
}

@end
