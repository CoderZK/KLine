//
//  zkURL.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/21.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkURL.h"




@implementation zkURL
/** 发送验证码 */
+ (NSString *)getSendCodeURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/userInfo/send"];
}
/** 用户注册 */
+ (NSString *)getRegisterURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/userInfo/register"];
}
/** 退出登录 */
+ (NSString *)getLoginOutURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/userInfo/logout"];
}
/** 登录 */
+ (NSString *)getLoginURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/userInfo/login"];
}
/** 用户信息 */
+ (NSString *)getUserInfoURL {
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/userInfo/detail"];
}
/** 用户钱吗 */
+ (NSString *)getUserWalletURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/userInfo/auth/wallet"];
}
/** 验证验证码 */
+ (NSString *)getValidCodeURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/userInfo/auth/changePhoneValidOldPhone"];
}
/** 修改资料 */
+ (NSString *)getUpdateBaseDateURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/userInfo/auth/updateBaseData"];
}
/** 修改密码 */
+ (NSString *)getPwdChangeURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/userInfo/pwdChange"];
}
/**  */
+ (NSString *)getPhoneChangeURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/userInfo/auth/changePhone"];
}
/** 上传文件 */
+ (NSString *)getUploadFileURL{
     return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/auth/uploadFile"];
}
/** 发帖 */
+ (NSString *)getFaTieURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/topicInfo/auth/saveOrUpdate"];
}
/** 增加二维码 */
+ (NSString *)getAddPayQrcodeeURL{
     return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/auth/userFollowPayQrcode/add"];
}
/** 删除二维码 */
+ (NSString *)getFDeletePayQrcodeURL{
     return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/auth/userFollowPayQrcode/delete"];
}
/** 二维码详情*/
+ (NSString *)getDetailPayQrcodeURL{
     return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/auth/userFollowPayQrcode/detail"];
}
/** 二维码列表 */
+ (NSString *)getPayQrcodeListURL{
     return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/auth/userFollowPayQrcode/list"];
}
/** 修改二维码 */
+ (NSString * )getUpdatePayQrcodeURL{
     return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/auth/userFollowPayQrcode/update"];
}
/** 获取订阅设置详情 */
+ (NSString *)getUserSetUpDetailURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/auth/userFollowSetUp/detail"];
}
/** 更新订阅设置 */
+ (NSString * )getUserSetUpUpdateURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/auth/userFollowSetUp/update"];
}
/** 获取发帖列表 */
+ (NSString * )getTopicInfoListURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/topicInfo/list"];
}
/** 获取发帖详情 */
+ (NSString * )getTopicInfoDetailURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/topicInfo/detail"];
}
/** 点赞 */
+ (NSString * )getAddZanURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/topicSupport/auth/add"];
}
/** 点赞列表 */
+ (NSString * )getZanListURL{
   return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/topicSupport/list"];
}
/** 添加评论 */
+ (NSString * )getAddPingLunURL{
   return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/topicReply/auth/saveOrUpdate"];
}
/** 获取唯独消息 */
+ (NSString * )getNewListURL {
   return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/auth/userMsg/unReadCount"];
}

/** 获取消息列表 */
+ (NSString * )getUserMsgListURL {
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/auth/userMsg/list"];
}

/** 用户订阅 */
+ (NSString * )getAddDingYueURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/userFollow/auth/add"];
}
/**  取消订阅*/
+ (NSString * )getCancelDingYueURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/userFollow/auth/cancel"];
}
/** 获取我的订阅或者 我的粉丝 */
+ (NSString * )getUserFollowURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/userFollow/list"];
}

/** 确认收款 */
+ (NSString * )getUserFollowIncomeConfirmURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/auth/userFollowIncome/confirm"];
}
/** 删除收入记录 */
+ (NSString * )getUserFollowIncomeDeleteURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/auth/userFollowIncome/delete"];
}
/**  订阅收入详情*/
+ (NSString * )getUserFollowIncomeDetailURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/auth/userFollowIncome/detail"];
}
/** 订阅收入列表*/
+ (NSString * )getUserFollowIncomeListURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/auth/userFollowIncome/list"];
}
/** 评论详情 */
+ (NSString * )getTopicReplyDetailURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/topicReply/detail"];
}

+ (NSString * )getTopicReplyListURL {
    
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/topicReply/list"];
    
}

/** 增加意见反馈 */
+ (NSString * )getAuthAddURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/feedBack/auth/add"];
}
/**  意见反馈详情详情*/
+ (NSString * )getAuthDetailURL{
     return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/feedBack/detail"];
}
/** 意见反馈列表列表*/
+ (NSString * )getAuthListURL{
     return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/feedBack/getListOrderReadCountDesc"];
}

/** 获取推送设置*/
+ (NSString * )getUserPushlURL{
     return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/auth/userPushSetUp/detail"];
}
/** 更新推送*/
+ (NSString * )getUserPushUpdateURL{
     return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/auth/userPushSetUp/update"];
}
/** 搜索接口*/
+ (NSString * )getSearchURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/search"];
}
/** 轮播图*/
+ (NSString * )getBannerListURL{
     return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/bannerInfo/list"];
}
/** 轮播图详情*/
+ (NSString * )getBannerDetailURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/bannerInfo/detail"];
}

/** 加入自选*/
+ (NSString * )getAddMyBitURL{
     return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/market/addMyBit"];
}
/** 全部*/
+ (NSString * )getAllBitURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/market/allBitType"];
}
/**币种详情*/
+ (NSString * )getBitDetailURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/market/bitDetail"];
}
/** 删除自选*/
+ (NSString * )getDeleMyBitURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/market/delMyBit"];
}
/** 查看自选*/
+ (NSString * )getChaKanZiXuanURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/market/getMyBitMarketData"];
}
/**搜索币种*/
+ (NSString * )getSelectBitURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/market/selectBit"];
}
/**他人的个人中心*/
+ (NSString * )getUserInfoHomeURL {
    
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/userInfo/home"];
}

/**获取支付订阅费用*/
+ (NSString * )getUserPayConfirmURL{
     return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/userFollow/auth/payConfirm"];
}
/** 设为已读 */
+ (NSString *)getUserMsgDoReadURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/auth/userMsg/doRead"];
}
/**上传Um 用的token */
+ (NSString * )getsaveUPushTokenURL {
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/userTokenInfo/saveUPushToken"];
}

/** 获取买入卖出详情 */
+ (NSString * )getTeadeInfoURL{
     return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/trade/info"];
}
/** 现价买入卖出 */
+ (NSString * )getTradeLimitURL{
     return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/trade/limit"];
}
/**市价买入卖出*/
+ (NSString * )getTradeMarketURL{
     return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/trade/market"];
}
/**持仓历史 */
+ (NSString * )getTradeHistoryURL{
     return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/trade/history"];
}
/**持仓明细 */
+ (NSString * )getTradeBitDetailURL{
     return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/trade/bitDetail"];
}
/**取消订单 */
+ (NSString * )getTradeCancelURL{
     return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/trade/cancel"];
}
/**清除交易 */
+ (NSString * )getUserInfoAuthTradeURL{
      return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/userInfo/auth/deleteUserAccountTrade"];
}

/**币种新闻详情 */
+ (NSString * )getBTCNewDetailURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/newsInfo/detail"];
}
/**币种新闻列表 */
+ (NSString * )getBTCNewsInfoURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/newsInfo/list"];
}
/**对某一条新闻的看空和看涨 */
+ (NSString * )getBTCNewsSupportURL{
   return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/newsInfo/support"];
}
/**平台奖励说明 */
+ (NSString * )getByTypURL{
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/rule/getByType"];
}
/**获取单个的持仓明细部分 */
+ (NSString * )getTradePositionDetailURL {
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/trade/positionDetail"];
}
/*牛人榜 */
+ (NSString * )getTradeRankListURL{
     return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/trade/rankList"];
}

/*点赞列表*/
+ (NSString * )gettopicSupportListURL {
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/topicSupport/list"];
}
/*邀请好友*/
+ (NSString * )getShareSettingURL{
    
    return [NSString stringWithFormat:@"%@%@",BaseURL,@"/mobile/shareSetting/detail"];
}

@end
