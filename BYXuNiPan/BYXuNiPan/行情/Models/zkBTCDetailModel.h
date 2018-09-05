//
//  zkBTCDetailModel.h
//  BYXuNiPan
//
//  Created by zk on 2018/8/10.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface zkBTCDetailModel : NSObject
@property(nonatomic,strong)NSString *ID;//这一条新闻的ID
@property(nonatomic,strong)NSString *blockchain;
@property(nonatomic,strong)NSString *circulatingSupply; //流通量
@property(nonatomic,strong)NSString *introd; //介绍
@property(nonatomic,strong)NSString *isAdd; //是否添加了
@property(nonatomic,strong)NSString *marketValue; //市值
@property(nonatomic,strong)NSString *name; //名字
@property(nonatomic,strong)NSString *publishTime;//发行时间
@property(nonatomic,strong)NSString *rank; //排名
@property(nonatomic,strong)NSString *totalSupply; //发行总量
@property(nonatomic,strong)NSString *website; //官网
@property(nonatomic,strong)NSString *whitePaper; //表皮书
@property(nonatomic,strong)NSString *development; //研发者
@property(nonatomic,strong)NSString *icoCost; //成本
@property(nonatomic,strong)NSString *blockTime; //区块时间
@property(nonatomic,strong)NSString *exchange; //上架交易所
@property(nonatomic,strong)NSString *link; //相关链接





@property(nonatomic,assign)BOOL isZhanKai;
@end
