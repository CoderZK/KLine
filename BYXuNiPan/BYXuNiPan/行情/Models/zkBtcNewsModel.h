//
//  zkBtcNewsModel.h
//  BYXuNiPan
//
//  Created by zk on 2018/8/10.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface zkBtcNewsModel : NSObject
@property(nonatomic,strong)NSString *ID;//这一条新闻的ID
@property(nonatomic,strong)NSString *coinId;   //币种ID
@property(nonatomic,strong)NSString *content; //新闻内容
@property(nonatomic,strong)NSString *createBy;
@property(nonatomic,strong)NSString *createDate;
@property(nonatomic,strong)NSString *opposeNum;
@property(nonatomic,strong)NSString *supportNum; //价格
@property(nonatomic,strong)NSString *title;
@property(nonatomic,assign)BOOL support;
@property(nonatomic,assign)BOOL supportFlag;
@property(nonatomic,assign)BOOL isZhanKai;
@property(nonatomic,assign)CGFloat cellHeight;
@end
