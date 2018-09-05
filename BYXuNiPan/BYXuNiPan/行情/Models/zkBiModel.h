//
//  zkBiModel.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/30.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface zkBiModel : NSObject
@property(nonatomic,strong)NSString *bitName;//币种
@property(nonatomic,strong)NSString *baseCurrency;//币种
@property(nonatomic,strong)NSString *ch;//
@property(nonatomic,strong)NSString *bitCnName;//币种中文名
@property(nonatomic,strong)NSString *cnName;//币种中文名
@property(nonatomic,strong)NSString *price;//价格
@property(nonatomic,strong)NSString *cny; //美元价格
@property(nonatomic,strong)NSString *increase;//涨跌幅
@property(nonatomic,strong)NSString *marketValue;//市值
@property(nonatomic,strong)zkBiModel *kline;
@property(nonatomic,strong)NSString *amount;//成交量
@property(nonatomic,strong)NSString *close;//收盘价
@property(nonatomic,strong)NSString *count; //成交笔数
@property(nonatomic,strong)NSString *high;//最高价
@property(nonatomic,strong)NSString *ID;//k线ID //或者币种ID
@property(nonatomic,strong)NSString *low; //最低价
@property(nonatomic,strong)NSString *open;//开盘价
@property(nonatomic,strong)NSString *vol;//成交额
@property(nonatomic,strong)NSString *isAdd;//成交额
@end
