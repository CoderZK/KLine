//
//  zkDingYueZhiFuOneTVC.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/18.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

@interface zkDingYueZhiFuOneTVC : BaseTableViewController
@property(nonatomic,strong)NSString *userID; //被订阅人的ID
@property(nonatomic ,copy)void(^sendDingYueBlock)(void);
@end
