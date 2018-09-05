//
//  zkQianBaoModel.h
//  BYXuNiPan
//
//  Created by zk on 2018/8/17.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface zkQianBaoModel : NSObject
@property(nonatomic,strong)NSString *createBy;//创建人
@property(nonatomic,strong)NSString *createByNickName;//昵称
@property(nonatomic,strong)NSString *createDate;//创建时间
@property(nonatomic,strong)NSString *payType;// 1 LXC 2金币 3 支付宝支付 4 微信 5 刷卡
@property(nonatomic,strong)NSString *tradeType;//1平台发放奖励 2 订阅交易 3 模拟盘交易
@property(nonatomic,strong)NSString *ID;//
@property(nonatomic,strong)NSString *remark;//备注
@property(nonatomic,strong)NSString *tradePrice;//交易价格
@property(nonatomic,strong)NSString *tradeUser; //交易方的ID
@property(nonatomic,strong)NSString *tradeUserNickName;//交易方的昵称
@end
