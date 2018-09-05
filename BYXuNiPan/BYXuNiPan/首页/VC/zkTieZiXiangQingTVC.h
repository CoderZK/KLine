//
//  zkTieZiXiangQingTVC.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/20.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

@interface zkTieZiXiangQingTVC : BaseTableViewController
@property(nonatomic,strong)NSString *type; //leixing // 1 帖子 2 交易
@property(nonatomic,strong)NSString *ID; //帖子ID
@property(nonatomic,strong)zkHomelModel *getHomeModel;
@property(nonatomic,copy)void(^sendHomeBlock)(zkHomelModel *modelSend);

@end
