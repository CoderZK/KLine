//
//  zkFatieTVC.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/16.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"

typedef void(^faTieBlock)();

@interface zkFatieTVC : BaseTableViewController

@property(nonatomic,copy)faTieBlock fatieBlcok;

@end
