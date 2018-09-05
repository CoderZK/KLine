//
//  zkAccountNumberSettingTVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/17.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkAccountNumberSettingTVC.h"
#import "zkSettingCell.h"
#import "zkforgetMMVC.h"
#import "zkChangeNumberVC.h"
@interface zkAccountNumberSettingTVC ()
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)NSString *phoneStr;
@end

@implementation zkAccountNumberSettingTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArr = @[@[@"手机号"],@[@"修改密码"]];
    self.navigationItem.title = @"账号设置";
    [self.tableView registerNib:[UINib nibWithNibName:@"zkSettingCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.phoneStr = [zkSignleTool shareTool].userInfoModel.phone;
    
    
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.01;
    }else {
        return 10;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    zkSettingCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.leftLB.text = self.titleArr[indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        cell.rightLB.hidden = NO;
        cell.rightLB.text = _phoneStr;
    }else {
        cell.rightLB.hidden = YES;
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        zkChangeNumberVC * vc =[[zkChangeNumberVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        __weak typeof(self) weakSelf = self;
        vc.sendPhoneBlock = ^(NSString *phoneStr) {
            weakSelf.phoneStr = phoneStr;
             
            [weakSelf.tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        zkforgetMMVC * vc =[[zkforgetMMVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
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
