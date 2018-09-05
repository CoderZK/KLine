//
//  zkBtcRankModel.h
//  BYXuNiPan
//
//  Created by zk on 2018/8/13.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface zkBtcRankModel : NSObject
@property(nonatomic,strong)NSString *ID;//帖子ID
@property(nonatomic,strong)NSString *rank; //排名
@property(nonatomic,strong)NSString *remark; //个性签名
@property(nonatomic,strong)NSString *username; //名字
@property(nonatomic,strong)NSString *imge; // 图片
@property(nonatomic,strong)NSString *userId; //userId
@property(nonatomic,strong)NSString *totalProfitPercent;//累计收益
@property(nonatomic,strong)NSString *weekProfitPercent; //周收益
@property(nonatomic,strong)NSString *dayProfitPercent; //日收益
@property(nonatomic,strong)NSString *operation; //日操作
@property(nonatomic,strong)NSString *bitCount; //新买入的币种
@property(nonatomic,strong)NSString *position; //仓位
@property(nonatomic,strong)NSArray<zkBtcRankModel *> *bitBean;
//币种比例用
@property(nonatomic,strong)NSString *bitName; //币种名字
@property(nonatomic,strong)NSString *bitPercent; //比例
@property(nonatomic,strong)NSString *bitValue; //市值
@property(nonatomic,strong)NSString *totalValue;//所有币种的市值
@property(nonatomic,strong)zkBtcRankModel *bitTrade;// 最近交易
//最近交易用
@property(nonatomic,strong)NSString *type; // 1 3  买 , 24 卖,
@property(nonatomic,strong)NSString *finalPrice;//价格

@property(nonatomic,strong)zkBtcRankModel *rankListResponse;


//我的粉丝用
@property(nonatomic,strong)NSString *userPic;
@property(nonatomic,strong)NSString *nickName;
@property(nonatomic,strong)NSString *sign;




@end
