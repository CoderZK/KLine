//
//  zkDingYueJieShaoTVC.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/17.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

@interface zkDingYueJieShaoTVC : BaseTableViewController
@property (nonatomic,copy)void(^sendJieShaoBlock)(NSString *jieShaoStr);
@end
