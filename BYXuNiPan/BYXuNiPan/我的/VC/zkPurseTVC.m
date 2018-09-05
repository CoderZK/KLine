//
//  zkPurseTVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/17.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkPurseTVC.h"
#import "zkSettingCell.h"
#import "zkPurseOneCell.h"
#import "zkPurseTwoCell.h"
#import "zkQianBaoModel.h"
@interface zkPurseTVC ()
@property(nonatomic,assign)NSInteger pageNumber;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation zkPurseTVC

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated {
     [super viewWillDisappear:animated];
     [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"zk_navimage"]];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"钱包";
    self.pageNumber = 1;
    [self.tableView registerNib:[UINib nibWithNibName:@"zkSettingCell" bundle:nil] forCellReuseIdentifier:@"zkSettingCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"zkPurseOneCell" bundle:nil] forCellReuseIdentifier:@"zkPurseOneCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"zkPurseTwoCell" bundle:nil] forCellReuseIdentifier:@"zkPurseTwoCell"];

     [self getListData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNumber = 1;
        [self getListData];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getListData];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 1;
    }
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 120;
    }else if (indexPath.section == 1) {
        return 44;
    }
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        zkPurseOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkPurseOneCell" forIndexPath:indexPath];
    
        CGFloat money = [self.moneyStr floatValue];
        if (money > 10000) {
            cell.moneyLB.text = [NSString stringWithFormat:@"%0.2f万",money/10000];
        }else {
            cell.moneyLB.text = [NSString stringWithFormat:@"%0.2f",money];
        }
        
        return cell;
    }else if (indexPath.section == 1) {
        zkSettingCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkSettingCell" forIndexPath:indexPath];
        cell.leftLB.font = [UIFont boldSystemFontOfSize:14];
        cell.rightLB.hidden = YES;
        cell.rightImageV.hidden = YES;
        cell.leftLB.text = @"账单明细";
        return cell;
    }else {
        zkPurseTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkPurseTwoCell" forIndexPath:indexPath];
        zkQianBaoModel * model = self.dataArray[indexPath.row];
        cell.titleLB.text = model.remark;
        cell.timeLB.text = [NSString stringWithTime:model.createDate];
        NSString * str = @"";
        if ([model.tradePrice floatValue] > 0) {
            str = [NSString stringWithFormat:@"+%@LXC",model.tradePrice];
        }else {
            str = [NSString stringWithFormat:@"%@LXC",model.tradePrice];
        }
        cell.eargingLB.text = str;
        return cell;
    }
    
    
    
}

- (void)getListData{
    
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }

    [zkRequestTool networkingPOST:[zkURL getUserWalletURL] parameters:@{@"userId":[zkSignleTool shareTool].userInfoModel.ID,@"pageNo":@(self.pageNumber)} success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            
            NSArray * arr = [zkQianBaoModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"userAccountTradeDtoList"]];
            if (self.pageNumber == 1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:arr];
            self.pageNumber++;
            [self.tableView reloadData];
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 700) {
             [self showAlertWithKey:@"700" message:nil];
        } else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
    
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
