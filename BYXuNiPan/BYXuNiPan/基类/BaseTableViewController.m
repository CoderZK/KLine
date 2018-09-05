//
//  BaseTableViewController.m
//  ShareGo
//
//  Created by kunzhang on 16/4/7.
//  Copyright © 2016年 kunzhang. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BaseTableViewHeaderFooterView.h"
@interface BaseTableViewController ()
{
    UITableViewStyle _tableViewStyle;
}
@end
@implementation BaseTableViewController
-(instancetype)initWithTableViewStyle:(UITableViewStyle)style
{
    if (self=[super init])
    {
        _tableViewStyle = style;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initBaseTableView];
}






-(void)initBaseTableView
{
    _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:_tableViewStyle];
    _tableView.autoresizingMask  =  UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.tableFooterView = [[UIView alloc] init];
    
    //下面三行时防止刷新时tableView 跳动
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    
    self.tableView.backgroundColor =[UIColor groupTableViewBackgroundColor];
    
    [self.view addSubview:_tableView];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    BaseTableViewHeaderFooterView * view =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseTableViewHeaderFoot"];
    if (!view) {
        view =[[BaseTableViewHeaderFooterView alloc] initWithReuseIdentifier:@"BaseTableViewHeaderFoot"];
    }
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BaseTableViewHeaderFooterView * view =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseTableViewHeaderFoot1"];
    if (!view) {
        view =[[BaseTableViewHeaderFooterView alloc] initWithReuseIdentifier:@"BaseTableViewHeaderFoot1"];
    }
    return view;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}


@end
