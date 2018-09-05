//
//  WebSocketManager.h
//  BYXuNiPan
//
//  Created by zk on 2018/8/1.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SocketRocket.h>
extern NSString * const kNeedPayOrderNote;
extern NSString * const kWebSocketDidOpenNote;
extern NSString * const kWebSocketDidCloseNote;
extern NSString * const kWebSocketdidReceiveMessageNote;


@protocol WebSocketManagerDelegate<NSObject>
- (void)didReceivemessage:(id)message;
@end

@interface WebSocketManager : NSObject
+ (WebSocketManager *)instance;
-(void)WebSocketOpenWithURLString:(NSString *)urlString;//开启连接
-(void)WebSocketClose;//关闭连接
- (void)sendData:(id)data;//发送数据
@property(nonatomic,assign)id<WebSocketManagerDelegate>delegate;
@end
