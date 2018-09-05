//
//  zkOneBtcChiCangModel.h
//  BYXuNiPan
//
//  Created by zk on 2018/8/13.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface zkOneBtcChiCangModel : NSObject
@property(nonatomic,strong)NSString *name; //名字
@property(nonatomic,strong)NSString *userId; //名字
@property(nonatomic,strong)NSString *imge; //名字
@property(nonatomic,strong)NSString *ID;  //币种ID
@property(nonatomic,strong)NSString *canSellAmount;//持仓数量
@property(nonatomic,strong)NSString *bitName;  //必中名字
@property(nonatomic,strong)NSString *totalPercent;//总收益率
@property(nonatomic,strong)NSString *totalWeekPercent; //七日收益率
@property(nonatomic,strong)NSString *currentPrice; //持仓价
@property(nonatomic,strong)NSString *riseFall; //涨跌额
@property(nonatomic,strong)NSString *riseFallPercent;//盈亏额
@property(nonatomic,strong)NSString *earnLoss; //盈亏
@property(nonatomic,strong)NSString *positionLevel;//仓位
@property(nonatomic,strong)NSString *positionPercent;;//买卖站的仓位
@property(nonatomic,strong)NSString *earnLossPercent; //收益率
@property(nonatomic,strong)NSString *marketValue; //最新市值
@property(nonatomic,strong)NSString *costPerThigh; //每股成本
@property(nonatomic,strong)NSString *amount; //总量
@property(nonatomic,strong)NSString *createPositionTime;//时间
@property(nonatomic,strong)NSMutableArray<zkOneBtcChiCangModel *>*records;

//调仓记录用

@property(nonatomic,strong)NSString *tradeAmount; //交易数量
@property(nonatomic,strong)NSString *direction; //买卖
@property(nonatomic,strong)NSString *price; //成交价
@property(nonatomic,strong)NSString *sharePercent; //仓位比例
@property(nonatomic,strong)NSString *tradeTime;//交易时间

@end
