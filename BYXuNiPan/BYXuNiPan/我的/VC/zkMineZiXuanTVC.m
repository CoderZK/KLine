//
//  zkMineZiXuanTVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/17.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkMineZiXuanTVC.h"
#import "zkZiXuanOneCell.h"
#import "zkHangQingCell.h"
@interface zkMineZiXuanTVC ()

@end

@implementation zkMineZiXuanTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"自选";
    [self.tableView registerNib:[UINib nibWithNibName:@"zkZiXuanOneCell" bundle:nil] forCellReuseIdentifier:@"zkZiXuanOneCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"zkHangQingCell" bundle:nil] forCellReuseIdentifier:@"zkHangQingCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 44;
    }
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        zkZiXuanOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkZiXuanOneCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        return cell;
    }
    zkHangQingCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkHangQingCell" forIndexPath:indexPath];
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = WhiteColor;
    }else {
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
