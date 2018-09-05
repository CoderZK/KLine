//
//  zkHomelModel.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/24.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkHomelModel.h"

@implementation zkHomelModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}

- (void)setHotReplyList:(NSMutableArray<zkHomelModel *> *)hotReplyList {
    _hotReplyList = [NSMutableArray arrayWithArray:[zkHomelModel mj_objectArrayWithKeyValuesArray:hotReplyList]];
}

- (void)setReplyList:(NSMutableArray<zkHomelModel *> *)replyList {
    _replyList =[NSMutableArray arrayWithArray:[zkHomelModel mj_objectArrayWithKeyValuesArray:replyList]]; ;
}

@end


//@implementation zkPLNModel
//
//+ (NSDictionary *)mj_replacedKeyFromPropertyName {
//    return @{@"ID":@"id"};
//}
//
//@end
