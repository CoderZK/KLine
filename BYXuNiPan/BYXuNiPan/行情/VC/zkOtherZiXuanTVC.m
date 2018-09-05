
//
//  zkOtherZiXuanTVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/8/13.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkOtherZiXuanTVC.h"
#import "zkHangQingCell.h"
#import "zkBiZhongDetailTVC.h"
#import "zkZiXuanOneCell.h"
@interface zkOtherZiXuanTVC ()
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation zkOtherZiXuanTVC
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"他的自选";
    if ([self.userID  isEqualToString:[zkSignleTool shareTool].userInfoModel.ID]) {
        self.navigationItem.title = @"我的自选";
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"zkHangQingCell" bundle:nil] forCellReuseIdentifier:@"zkHangQingCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"zkZiXuanOneCell" bundle:nil] forCellReuseIdentifier:@"zkZiXuanOneCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self getAllDataList];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getAllDataList];
    }];
}


- (void)getAllDataList {
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    NSString * url = [zkURL getChaKanZiXuanURL];
    dict[@"userId"] = self.userID;
    [SVProgressHUD show];
    [zkRequestTool networkingGET:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            [SVProgressHUD dismiss];
            self.dataArray = [zkBiModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            [self.tableView reloadData];
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return self.dataArray.count;
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
    cell.model = self.dataArray[indexPath.row];
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = WhiteColor;
    }else {
        cell.backgroundColor = RGB(240, 240, 240);
    }
    CGFloat rangkingW = [[NSString stringWithFormat:@"%ld",indexPath.row +1] getWidhtWithFontSize:11];
    cell.rankingLBWidthCon.constant = rangkingW + 6;
    if (indexPath.row < 9) {
        cell.rankingLBWidthCon.constant = 13;
    }
    cell.rankingLB.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    if (indexPath.row < 3) {
        cell.rankingLB.backgroundColor = PMBlue123;
    }else if (indexPath.row < 6) {
        cell.rankingLB.backgroundColor = PMBlue456;
    }else {
        cell.rankingLB.backgroundColor = PMBlue7;
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        return;
    }
    zkBiModel * model = self.dataArray[indexPath.row];
    zkBiZhongDetailTVC* vc =[[zkBiZhongDetailTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    vc.hidesBottomBarWhenPushed = YES;
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
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
