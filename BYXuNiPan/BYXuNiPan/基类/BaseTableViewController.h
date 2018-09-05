//
//  BaseTableViewController.h
//  ShareGo
//
//  Created by kunzhang on 16/4/7.
//  Copyright © 2016年 kunzhang. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

-(instancetype)initWithTableViewStyle:(UITableViewStyle)style;

@property(nonatomic,strong,readonly)UITableView * tableView;

@end
