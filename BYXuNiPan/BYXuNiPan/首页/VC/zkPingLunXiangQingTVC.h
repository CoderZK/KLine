//
//  zkPingLunXiangQingTVC.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/26.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"
#import "zkHomelModel.h"
@interface zkPingLunXiangQingTVC : BaseTableViewController
@property(nonatomic,strong)NSString *pingLunID;
@property(nonatomic,strong)NSString *nickName;
@property(nonatomic,copy)void(^sendPingLunModel)(zkHomelModel *neiModel);
@property(nonatomic,copy)void(^sendPingLunAddCount)(NSInteger count);
@end
