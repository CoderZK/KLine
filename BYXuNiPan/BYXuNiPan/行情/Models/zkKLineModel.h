//
//  zkKLineModel.h
//  BYXuNiPan
//
//  Created by zk on 2018/8/7.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface zkKLineModel : NSObject
@property(nonatomic,strong)NSString *bitCnName;
@property(nonatomic,strong)NSString *bitName; //币种名字
@property(nonatomic,strong)NSString *ch; //获取数据的类型
@property(nonatomic,strong)NSString *cny; //人民币价格
@property(nonatomic,strong)NSString *dateStr; //时间
@property(nonatomic,strong)NSString *increase;
@property(nonatomic,strong)zkKLineModel *kline;
@property(nonatomic,strong)NSString *amount; //交易额
@property(nonatomic,strong)NSString *close; //收盘
@property(nonatomic,strong)NSString *count;
@property(nonatomic,strong)NSString *ID;
@property(nonatomic,strong)NSString *low;   //最低
@property(nonatomic,strong)NSString *open; //开盘价
@property(nonatomic,strong)NSString *high; //最高
@property(nonatomic,strong)NSString *vol;  //成交量

@property(nonatomic,strong)NSString *marketValue;
@property(nonatomic,strong)NSString *price; //价格
@property(nonatomic,strong)NSString *riseFall;
@property(nonatomic,strong)NSString *ts; //时间
@property(nonatomic,strong)NSString *type;

@end
