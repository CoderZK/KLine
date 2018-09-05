//
//  zkShouFuJiLumodel.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/26.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface zkShouFuJiLumodel : NSObject
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,assign)BOOL income;
@property(nonatomic,strong)NSString *money;
@property(nonatomic,strong)NSString *nickName;
@property(nonatomic,strong)NSString *payTime;
@property(nonatomic,assign)BOOL showConfirmButton;
@property(nonatomic,strong)NSString *state;//1 待对方收款 2 带自己收款 3 已完成
@property(nonatomic,strong)NSString *stateText;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *payType;
@property(nonatomic,strong)NSString *userId;
@property(nonatomic,strong)NSString *orderNo;
//@property(nonatomic,strong)NSString *totalAmount; //总资产
//@property(nonatomic,strong)NSString *accumulatedRanking;//累计排名
//@property(nonatomic,strong)NSString *accumulatedIncome;//累计收益
//@property(nonatomic,strong)NSString *dailyRanking; //日排名
//@property(nonatomic,strong)NSString *dailyIncome; //日收益lv
//@property(nonatomic,strong)NSString *weekRanking; //周排名
//@property(nonatomic,strong)NSString *weekIncome; //周收益率
//@property(nonatomic,strong)NSString *principal; //本金
//@property(nonatomic,strong)NSString *dailyOperateCount ; //日操作次数
//@property(nonatomic,strong)NSString *phone; //手机号
@end
