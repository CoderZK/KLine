//
//  zkOtherCenterModel.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/31.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "zkBTCChiYouModel.h"
@class zkDingJieShaoModel;
@interface zkOtherCenterModel : NSObject

@property(nonatomic,strong)NSString *ID; //用户ID
@property(nonatomic,strong)NSString *myHome; //是否是自己 1 是
@property(nonatomic,strong)NSString *fansCount;//粉丝数
@property(nonatomic,strong)NSString *followCount; //订阅量
@property(nonatomic,strong)NSString *userPic; //用户头像
@property(nonatomic,strong)NSString *sign; //用户签名
@property(nonatomic,strong)NSString *nickName; //用户昵称
@property(nonatomic,strong)NSString *phone; //用户手机号
@property(nonatomic,strong)NSString *holdLxcCount; //自选股数量
@property(nonatomic,strong)NSString *wallet;  //钱包
@property(nonatomic,strong)NSString *totalAmount; //总资产
@property(nonatomic,strong)NSString *principal; //本金
@property(nonatomic,strong)NSString *accumulatedRanking; //累计排名
@property(nonatomic,strong)NSString *accumulatedIncome; //累计收益
@property(nonatomic,strong)NSString *dailyIncome; //日收益
@property(nonatomic,strong)NSString *dailyOperateCount; //日操纵
@property(nonatomic,strong)NSString *dailyRanking; //日排名
@property(nonatomic,strong)NSString *weekRanking; //周排名
@property(nonatomic,strong)NSString *weekIncome; //周收益
@property(nonatomic,strong)NSString *followFlag; //是否订阅 (1是 0 否)
@property(nonatomic,strong)NSString *followFreeFlag; //用户是否免费 (1是 0 否)
@property(nonatomic,strong)zkUserInfoModel *statisticsDataResponse;
@property(nonatomic,strong)NSMutableArray<zkBTCChiYouModel *> *historyEntrustList; //历史委托
@property(nonatomic,strong)NSMutableArray<zkBTCChiYouModel *> *historyTradeList;  //成交明细
@property(nonatomic,strong)NSMutableArray<zkBTCChiYouModel *> *holdingCoinList; //持仓明细
@property(nonatomic,strong)NSMutableArray<zkBTCChiYouModel *> *unPayTradeList; //未成交明细
@property(nonatomic,strong)NSMutableArray<zkHomelModel *> *allTopicList;//所有帖子
@property(nonatomic,strong)NSMutableArray<zkHomelModel *> *tradeTopicList;//交易忒自
@property(nonatomic,strong)NSMutableArray<zkHomelModel *> *markeTopicList;//行情帖子
@property(nonatomic,strong)NSMutableArray<zkHomelModel *> *hotTopicList;//精选忒自
@property(nonatomic,strong)zkDingJieShaoModel *supportHelper;

@end


@interface zkDingJieShaoModel:NSObject

@property(nonatomic,strong)NSString *profile; //订阅简介
@property(nonatomic,strong)NSString *price; //订阅价格
@property(nonatomic,strong)NSString *lxcPrice; //订阅价格
@property(nonatomic,strong)NSString *freeFlag; //是否收费
@property(nonatomic,strong)NSString *effectiveTime; //有效时间
@property(nonatomic,strong)NSString *subjectCount; //主题数量
@property(nonatomic,strong)NSString *interactCount; //互动数
@property(nonatomic,strong)NSString *tradeCount; //交易数
@property(nonatomic,strong)NSString *fansCount;//粉丝数量
@property(nonatomic,strong)NSArray *fansUserIdList;//粉丝ID
@property(nonatomic,strong)NSArray *fansUserPicList;//粉丝头像ID


@end


