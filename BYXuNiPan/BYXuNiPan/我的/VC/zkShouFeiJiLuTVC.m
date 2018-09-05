//
//  zkShouFeiJiLuTVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/17.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkShouFeiJiLuTVC.h"
#import "zkShouFeiJiLuCell.h"
#import "zkShouFeiJiLuTwoCell.h"
#import "zkShouFeiJiLuDetailTVC.h"
#import "zkShouFuJiLumodel.h"
@interface zkShouFeiJiLuTVC ()
@property(nonatomic,assign)NSInteger pageNumber;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSString *shouRuStr;
@property(nonatomic,strong)NSString *zhiChuStr;
@end

@implementation zkShouFeiJiLuTVC
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收付记录";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"zkShouFeiJiLuCell" bundle:nil] forCellReuseIdentifier:@"zkShouFeiJiLuCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"zkShouFeiJiLuTwoCell" bundle:nil] forCellReuseIdentifier:@"zkShouFeiJiLuTwoCell"];
    
    self.pageNumber = 1;
    [self getList];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNumber = 1;
        [self getList];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getList];
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
        return 70;
    }
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        zkShouFeiJiLuTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkShouFeiJiLuTwoCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        cell.leftOneLB.text = self.shouRuStr;
        cell.leftTwoLB.text = self.zhiChuStr;
        return cell;
    }
    zkShouFeiJiLuCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkShouFeiJiLuCell" forIndexPath:indexPath];
    zkShouFuJiLumodel * model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    zkShouFuJiLumodel * model = self.dataArray[indexPath.row];
    zkShouFeiJiLuDetailTVC * vc =[[zkShouFeiJiLuDetailTVC alloc] init];
    vc.ID = model.ID;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getList {
    
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }

    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"pageNo"] = @(self.pageNumber);
    dict[@"followMe"] = @"0";
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:[zkURL getUserFollowIncomeListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
             [SVProgressHUD dismiss];
            NSArray * arr = [zkShouFuJiLumodel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"incomeDetailDtoList"][@"rows"]];
            self.shouRuStr = [NSString stringWithFormat:@"%@",responseObject[@"result"][@"in"]];
            self.zhiChuStr = [NSString stringWithFormat:@"%@",responseObject[@"result"][@"out"]];
            if (self.pageNumber == 1) {
                [self.dataArray removeAllObjects];
                if (arr.count == 0 ) {
                    [SVProgressHUD showSuccessWithStatus:@"暂无数据"];
                }
            }
            [self.dataArray addObjectsFromArray:arr];
            [self.tableView reloadData];
            self.pageNumber++;
        } else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];
    
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
