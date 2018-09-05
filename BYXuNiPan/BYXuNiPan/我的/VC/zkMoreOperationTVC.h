//
//  zkMoreOperationTVC.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/14.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

@interface zkMoreOperationTVC : BaseTableViewController
//0 是持仓明细  1.0未成交  2.0成交历史   3.0历史委托
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,strong)NSString *userID;
@end
