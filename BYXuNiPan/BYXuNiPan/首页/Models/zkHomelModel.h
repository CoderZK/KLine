//
//  zkHomelModel.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/24.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface zkHomelModel : NSObject
@property(nonatomic,strong)NSString *ID;//帖子ID
@property(nonatomic,strong)NSString *content;//内容
@property(nonatomic,strong)NSString *createByUserPic;//用户头像
@property(nonatomic,strong)NSString *createByNickName;//用户昵称
@property(nonatomic,strong)NSString *createDate; //创建时间
@property(nonatomic,strong)NSArray *imgList;//图片
@property(nonatomic,strong)NSString *replyCount;//回复数量
@property(nonatomic,strong)NSString *supportCount; //点赞数量
@property(nonatomic,strong)NSString *supportNickNames;//点赞人
@property(nonatomic,strong)NSString *supportUserIds;//点赞人
@property(nonatomic,strong)NSString *type; //1帖子 0 货币交易
@property(nonatomic,strong)NSString *typeText; //
@property(nonatomic,strong)NSMutableArray<zkHomelModel *> *hotReplyList; //热门
@property(nonatomic,strong)NSMutableArray<zkHomelModel *> *replyList;//最新评论

@property(nonatomic,strong)NSString *tradeType; //交易类型 1 买入 0 卖出
@property(nonatomic,strong)NSString *tradePrice; // 成交价
@property(nonatomic,strong)NSString *tradeNum; // 成交数量
@property(nonatomic,strong)NSString *coinName; // 币种
@property(nonatomic,strong)NSString *coinId ; // 币种ID
@property(nonatomic,strong)NSString *phone; //
@property(nonatomic,assign)BOOL supportFlag; //是否是自己点赞了


@property(nonatomic,strong)NSString *parentId;// 副帖ID
@property(nonatomic,strong)NSString *topicId;//主贴ID

@property(nonatomic,strong)NSString *updateBy;//内容
@property(nonatomic,strong)NSString *updateDate;//用户头像



@property(nonatomic,strong)NSString *replyTo; //被回复人id
@property(nonatomic,strong)NSString *replyToNickName;//被回复人名字
@property(nonatomic,strong)NSString *createBy; // 回复人ID

@property(nonatomic,strong)NSString *lxcAward;//开奖多少
@property(nonatomic,assign)BOOL showAward; // 是否开奖
@property(nonatomic,assign)CGFloat cellHeight;


@end



//@interface zkPLNModel : NSObject
//
//
//
//@end


