//
//  GCDSocketManager.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/25.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "GCDSocketManager.h"
#import "GCDAsyncSocket.h"
#define SocketHost @"192.168.1.120"
#define SocketPort 8765
@interface GCDSocketManager()<GCDAsyncSocketDelegate>

//握手次数
@property(nonatomic,assign) NSInteger pushCount;

//断开重连定时器
@property(nonatomic,strong) NSTimer *timer;

//重连次数
@property(nonatomic,assign) NSInteger reconnectCount;

@end

@implementation GCDSocketManager

//全局访问点
+ (instancetype)sharedSocketManager {
    static GCDSocketManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

//可以在这里做一些初始化操作
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark 请求连接
//连接
- (void)connectToServer {
    self.pushCount = 0;
    
    self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    NSError *error = nil;
    [self.socket connectToHost:SocketHost onPort:SocketPort error:&error];
    
    if (error) {
        NSLog(@"SocketConnectError:%@",error);

    }
}

#pragma mark 连接成功
//连接成功的回调
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSLog(@"%@",@"socket连接成功");

//    [self sendDataToServer];
     NSDictionary * dd = @{@"type":@"1",@"clientId":@"123",@"sentMsg":@"666666666"};
    [self sendDataToServerWithDict:dd];
//      NSDictionary * ddd = @{@"type":@"2",@"clientId":@"123",@"sentMsg":@"Kline:market.actusdt.kline.5min"};
//     [self sendDataToServerWithDict:ddd];
    
}

//连接成功后向服务器发送数据
- (void)sendDataToServer {
    //发送数据代码省略...
    
    NSDictionary * dd = @{@"type":@"1",@"clientId":@"123",@"sentMsg":@"666666666"};
    NSError *error;
      NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dd options:NSJSONWritingPrettyPrinted error:&error];
    //发送
    [self.socket writeData:jsonData withTimeout:-1 tag:1];
    
    //读取数据
    [self.socket readDataWithTimeout:-1 tag:200];
}


- (void)sendDataToServerWithDict:(NSDictionary *)dd {
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dd options:NSJSONWritingPrettyPrinted error:&error];
    //发送
    [self.socket writeData:jsonData withTimeout:-1 tag:1];
    
    //读取数据
    [self.socket readDataWithTimeout:-1 tag:200];
    
}


//连接成功向服务器发送数据后,服务器会有响应
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    
    
    NSDictionary * dict = [NSString GetJsonWithData:data];
    static NSInteger aa = 0;
    
    if (aa == 0) {
        NSDictionary * ddd = @{@"type":@"2",@"clientId":@"123",@"sentMsg":@"Kline:market.actusdt.kline.5min"};
        [self sendDataToServerWithDict:ddd];
        aa++;
    }
    
    
    NSLog(@"====%@",dict);

    
    [self.socket readDataWithTimeout:-1 tag:200];
    
    //服务器推送次数
    self.pushCount++;
    
    //在这里进行校验操作,情况分为成功和失败两种,成功的操作一般都是拉取数据
}

#pragma mark 连接失败
//连接失败的回调
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    NSLog(@"%@",@"Socket连接失败");

    
    self.pushCount = 0;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *currentStatu = [userDefaults valueForKey:@"Statu"];
    
    //程序在前台才进行重连
    if ([currentStatu isEqualToString:@"foreground"]) {
        
        //重连次数
        self.reconnectCount++;
        
        //如果连接失败 累加1秒重新连接 减少服务器压力
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 * self.reconnectCount target:self selector:@selector(reconnectServer) userInfo:nil repeats:NO];
        
        self.timer = timer;
    }
}

//如果连接失败,5秒后重新连接
- (void)reconnectServer {
    
    self.pushCount = 0;
    
    self.reconnectCount = 0;
    
    //连接失败重新连接
    NSError *error = nil;
    [self.socket connectToHost:SocketHost onPort:SocketPort error:&error];
    if (error) {
        NSLog(@"SocektConnectError:%@",error);

    }
}

#pragma mark 断开连接
//切断连接
- (void)cutOffSocket {
    NSLog(@"%@",@"socket断开连接");

    
    self.pushCount = 0;
    
    self.reconnectCount = 0;
    
    [self.timer invalidate];
    self.timer = nil;
    
    [self.socket disconnect];
}

@end
