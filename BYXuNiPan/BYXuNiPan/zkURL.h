//
//  zkURL.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/21.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BaseURL @"http://47.105.124.39/lianxice-admin"
#define stocketURL @"ws://47.105.124.39:8765/lianxice-admin"

//#define stocketURL @"ws://192.168.1.120:8765"
//#define BaseURL @"http://192.168.1.120"

//#define stocketURL @"ws://192.168.1.120:8765"
//#define BaseURL @"http://192.168.1.110:80"


@interface zkURL : NSObject

/** 发送验证码 */
+ (NSString *)getSendCodeURL;
/** 用户注册 */
+ (NSString *)getRegisterURL;
/** 退出登录 */
+ (NSString *)getLoginOutURL;
/** 登录 */
+ (NSString *)getLoginURL;
/** 用户信息 */
+ (NSString *)getUserInfoURL;
/** 设为已读 */
+ (NSString *)getUserMsgDoReadURL;
/** 用户钱吗 */
+ (NSString *)getUserWalletURL;
/** 验证验证码 */
+ (NSString *)getValidCodeURL;
/** 修改资料 */
+ (NSString *)getUpdateBaseDateURL;
/** 修改密码 */
+ (NSString *)getPwdChangeURL;
/** 修改密码 */
+ (NSString *)getPhoneChangeURL;
/** 上传手机 */
+ (NSString *)getUploadFileURL;
/** 发帖 */
+ (NSString * )getFaTieURL;


/** 增加二维码 */
+ (NSString *)getAddPayQrcodeeURL;
/** 删除二维码 */
+ (NSString *)getFDeletePayQrcodeURL;
/** 二维码详情*/
+ (NSString *)getDetailPayQrcodeURL;
/** 二维码列表 */
+ (NSString *)getPayQrcodeListURL;
/** 修改二维码 */
+ (NSString * )getUpdatePayQrcodeURL;
/** 获取订阅设置详情 */
+ (NSString *)getUserSetUpDetailURL;
/** 更新订阅设置 */
+ (NSString * )getUserSetUpUpdateURL;
/** 获取发帖列表 */
+ (NSString * )getTopicInfoListURL;
/** 获取发帖列表 */
+ (NSString * )getTopicInfoDetailURL;
/** 评论详情 */
+ (NSString * )getTopicReplyDetailURL;
/** 评论列表 */
+ (NSString * )getTopicReplyListURL;

/** 点赞 */
+ (NSString * )getAddZanURL;
/** 点赞列表 */
+ (NSString * )getZanListURL;
/** 添加评论 */
+ (NSString * )getAddPingLunURL;
/** 获取唯独消息 */
+ (NSString * )getNewListURL;
/** 获取消息列表 */
+ (NSString * )getUserMsgListURL;


/** 用户订阅 */
+ (NSString * )getAddDingYueURL;
/**  取消订阅*/
+ (NSString * )getCancelDingYueURL;
/** 获取我的订阅或者 我的粉丝 */
+ (NSString * )getUserFollowURL;


/** 确认收款 */
+ (NSString * )getUserFollowIncomeConfirmURL;
/** 删除收入记录 */
+ (NSString * )getUserFollowIncomeDeleteURL;
/**  订阅收入详情*/
+ (NSString * )getUserFollowIncomeDetailURL;
/** 订阅收入列表*/
+ (NSString * )getUserFollowIncomeListURL;

/** 增加意见反馈 */
+ (NSString * )getAuthAddURL;
/**  意见反馈详情详情*/
+ (NSString * )getAuthDetailURL;
/** 意见反馈列表列表*/
+ (NSString * )getAuthListURL;

/** 获取推送设置*/
+ (NSString * )getUserPushlURL;
/** 更新推送*/
+ (NSString * )getUserPushUpdateURL;
/** 搜索接口*/
+ (NSString * )getSearchURL;
/** 轮播图*/
+ (NSString * )getBannerListURL;
/** 轮播图详情*/
+ (NSString * )getBannerDetailURL;


/** 加入自选*/
+ (NSString * )getAddMyBitURL;
/** 全部*/
+ (NSString * )getAllBitURL;
/** 删除自选*/
+ (NSString * )getDeleMyBitURL;
/** 查看自选*/
+ (NSString * )getChaKanZiXuanURL;
/**搜索币种*/
+ (NSString * )getSelectBitURL;
/** 币种详情 */
+ (NSString * )getBitDetailURL;
/**他人的个人中心*/
+ (NSString * )getUserInfoHomeURL;
/**获取支付订阅费用*/
+ (NSString * )getUserPayConfirmURL;
/**上传Um 用的token */
+ (NSString * )getsaveUPushTokenURL;

/** 获取买入卖出详情 */
+ (NSString * )getTeadeInfoURL;
/** 现价买入卖出 */
+ (NSString * )getTradeLimitURL;
/**市价买入卖出*/
+ (NSString * )getTradeMarketURL;
/**持仓历史 */
+ (NSString * )getTradeHistoryURL;
/**持仓明细 */
+ (NSString * )getTradeBitDetailURL;
/**取消订单 */
+ (NSString * )getTradeCancelURL;
/**清除交易 */
+ (NSString * )getUserInfoAuthTradeURL;

/**币种新闻详情 */
+ (NSString * )getBTCNewDetailURL;
/**币种新闻列表 */
+ (NSString * )getBTCNewsInfoURL;
/**对某一条新闻的看空和看涨 */
+ (NSString * )getBTCNewsSupportURL;

/**平台奖励说明 */
+ (NSString * )getByTypURL;

/**获取单个的持仓明细部分 */
+ (NSString * )getTradePositionDetailURL;
/*牛人榜 */
+ (NSString * )getTradeRankListURL;

/*点赞列表*/
+ (NSString * )gettopicSupportListURL;

/*邀请好友*/
+ (NSString * )getShareSettingURL;
@end
