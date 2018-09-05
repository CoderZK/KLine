//
//  zkOtherCenterModel.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/31.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkOtherCenterModel.h"

@implementation zkOtherCenterModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}

- (void)setSupportHelper:(zkDingJieShaoModel *)supportHelper {
    _supportHelper = [zkDingJieShaoModel mj_objectWithKeyValues:supportHelper];
}



- (void)setAllTopicList:(NSMutableArray<zkHomelModel *> *)allTopicList {
    _allTopicList = [NSMutableArray arrayWithArray:[zkHomelModel mj_objectArrayWithKeyValuesArray:allTopicList]];
}

- (void)setMarkeTopicList:(NSMutableArray<zkHomelModel *> *)markeTopicList {
    _markeTopicList = [NSMutableArray arrayWithArray:[zkHomelModel mj_objectArrayWithKeyValuesArray:markeTopicList]];
}

- (void)setTradeTopicList:(NSMutableArray<zkHomelModel *> *)tradeTopicList {
    _tradeTopicList = [NSMutableArray arrayWithArray:[zkHomelModel mj_objectArrayWithKeyValuesArray:tradeTopicList]];
}

- (void)setHotTopicList:(NSMutableArray<zkHomelModel *> *)hotTopicList {
    _hotTopicList = [NSMutableArray arrayWithArray:[zkHomelModel mj_objectArrayWithKeyValuesArray:hotTopicList]];
}

//@property(nonatomic,strong)NSMutableArray<zkBTCChiYouModel *> *historyEntrustList; //历史委托
//@property(nonatomic,strong)NSMutableArray<zkBTCChiYouModel *> *historyTradeList;  //成交明细
//@property(nonatomic,strong)NSMutableArray<zkBTCChiYouModel *> *holdingCoinList; //持仓明细
//@property(nonatomic,strong)NSMutableArray<zkBTCChiYouModel *> *unPayTradeList;

- (void)setHistoryTradeList:(NSMutableArray<zkBTCChiYouModel *> *)historyTradeList {
    _historyTradeList = [zkBTCChiYouModel mj_objectArrayWithKeyValuesArray:historyTradeList];
}

- (void)setHistoryEntrustList:(NSMutableArray<zkBTCChiYouModel *> *)historyEntrustList {
    _historyEntrustList = [zkBTCChiYouModel mj_objectArrayWithKeyValuesArray:historyEntrustList];
}

- (void)setHoldingCoinList:(NSMutableArray<zkBTCChiYouModel *> *)holdingCoinList {
    _holdingCoinList = [zkBTCChiYouModel mj_objectArrayWithKeyValuesArray:holdingCoinList];
}

- (void)setUnPayTradeList:(NSMutableArray<zkBTCChiYouModel *> *)unPayTradeList {
    _unPayTradeList = [zkBTCChiYouModel mj_objectArrayWithKeyValuesArray:unPayTradeList];
}

- (void)setStatisticsDataResponse:(zkUserInfoModel *)statisticsDataResponse {
    _statisticsDataResponse = [zkUserInfoModel mj_objectWithKeyValues:statisticsDataResponse];
}

@end


@implementation zkDingJieShaoModel


@end
