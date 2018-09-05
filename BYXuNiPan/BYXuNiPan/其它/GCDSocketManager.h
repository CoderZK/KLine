//
//  GCDSocketManager.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/25.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDSocketManager : NSObject
@property(nonatomic,strong) GCDAsyncSocket *socket;
//单例
+ (instancetype)sharedSocketManager;
//连接
- (void)connectToServer;
//断开
- (void)cutOffSocket;
@end
