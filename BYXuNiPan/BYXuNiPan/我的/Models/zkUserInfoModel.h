//
//  zkUserInfoModel.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/24.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface zkUserInfoModel : NSObject
@property(nonatomic,strong)NSString *ID;//用户ID
@property(nonatomic,strong)NSString *userPic;//用户头像
@property(nonatomic,strong)NSString *nickName;//用户昵称
@property(nonatomic,strong)NSString *sign; //用户签名
@property(nonatomic,strong)NSString *followCount;//订阅数量
@property(nonatomic,strong)NSString *fansCount;//粉丝数量
@property(nonatomic,strong)NSString *holdLxcCount; //自选股数量
@property(nonatomic,strong)NSString *wallet; //钱包
@property(nonatomic,strong)NSString *totalAssets; //总资产
@property(nonatomic,strong)NSString *totalRank;//累计排名
@property(nonatomic,strong)NSString *totalProfit;//累计收益
@property(nonatomic,strong)NSString *dayRank; //日排名
@property(nonatomic,strong)NSString *dayProfit; //日收益lv
@property(nonatomic,strong)NSString *weekRank; //周排名
@property(nonatomic,strong)NSString *weekProfit; //周收益率
@property(nonatomic,strong)NSString *principal; //本金
@property(nonatomic,strong)NSString *operation ; //日操作次数
@property(nonatomic,strong)NSString *phone; //手机号
@property(nonatomic,strong)NSString *unReadMsgCount; //未读数量
@property(nonatomic,strong)NSDictionary *statisticsDataResponse;


@end
