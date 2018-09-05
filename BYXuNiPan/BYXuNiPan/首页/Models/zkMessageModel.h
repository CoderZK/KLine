//
//  zkMessageModel.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/26.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface zkMessageModel : NSObject
@property(nonatomic,strong)NSString *ID;//消息ID
@property(nonatomic,strong)NSString *topicId;//帖子ID
@property(nonatomic,strong)NSString *msgId;//系统消息ID
@property(nonatomic,strong)NSString *replyId;//评论ID
@property(nonatomic,strong)NSString *content;//内容
@property(nonatomic,strong)NSString *fromUserPic;//用户头像
@property(nonatomic,strong)NSString *createDate; //创建时间
@property(nonatomic,strong)NSString *fromUser; //主动人ID
@property(nonatomic,strong)NSString *replyCount;//回复数量
@property(nonatomic,strong)NSString *supportCount; //点赞数量
@property(nonatomic,strong)NSString *profile;//描述
@property(nonatomic,strong)NSString *title;//标题
@property(nonatomic,strong)NSString *toUser; // 被ID
@property(nonatomic,assign)BOOL readFlag;



@end
