//
//  zkYiJianFanKuiDetailVC.h
//  BYXuNiPan
//
//  Created by zk on 2018/8/7.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "BaseViewController.h"
#import "zkYiJianFanKuiModel.h"
@interface zkYiJianFanKuiDetailVC : BaseViewController
@property(nonatomic,assign)BOOL isComeJiangLi;
@property(nonatomic,assign)BOOL isComeYiJian;
@property(nonatomic,assign)BOOL isComeBannar;
@property(nonatomic,strong)zkYiJianFanKuiModel *model;
@property(nonatomic,strong)NSString *urlStr;
@end
