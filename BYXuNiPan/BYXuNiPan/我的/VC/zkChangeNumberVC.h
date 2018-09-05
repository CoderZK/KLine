//
//  zkChangeNumberVC.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/23.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "BaseViewController.h"

@interface zkChangeNumberVC : BaseViewController

@property(nonatomic,copy)void(^sendPhoneBlock)(NSString *phoneStr);

@end
