//
//  zkBTCChiYouModel.h
//  BYXuNiPan
//
//  Created by zk on 2018/8/10.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface zkBTCChiYouModel : NSObject
@property(nonatomic,strong)NSString *amount; //数量
@property(nonatomic,strong)NSString *currentprice;//当前价
@property(nonatomic,strong)NSString *earnPercent; //收益率
@property(nonatomic,strong)NSString *percent; //占比例
@property(nonatomic,strong)NSString *avgPrice; //持仓价
@property(nonatomic,strong)NSString *bitName;  //必中名字
@property(nonatomic,strong)NSString *userId;

@property(nonatomic,strong)NSString *finalPrice;//成交价

//未成交的
@property(nonatomic,strong)NSString *price; //委托价
@property(nonatomic,strong)NSString *status; //是否成交  1 未成交  2 已成交  3 已撤销
@property(nonatomic,strong)NSString *type; //1 3买 2 4 卖
@property(nonatomic,strong)NSString *ID;  //币种ID
@property(nonatomic,strong)NSString *createTime;
@property(nonatomic,strong)NSString *updateTime;



@end
