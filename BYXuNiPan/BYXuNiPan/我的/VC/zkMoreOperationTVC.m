//
//  zkMoreOperationTVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/14.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkMoreOperationTVC.h"
#import "zkChiCangMingXiCell.h"
#import "zkWeiChengJiaoCell.h"
#import "zkChengJiaoLiShiCell.h"
#import "zkLishiWeiTuoCell.h"
#import "zkBTCChiYouModel.h"
#import "zkOneBiZhongChiCangTVC.h"
@interface zkMoreOperationTVC ()
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,assign)NSInteger pageNumber;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation zkMoreOperationTVC

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleArr = @[@[@"币种",@"持仓量 ( 比例 ) ",@"持仓价",@"当前价格",@"收益率"],@[@"类型",@"币种",@"状态",@"委托价格",@"数量",@"撤单"],@[@"类型",@"币种",@"成交价格",@"数量",@"成交时间"],@[@"类型",@"币种",@"状态",@"委托价格",@"数量",@"成交时间"]];
    self.pageNumber = 1;
    
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - sstatusHeight - 44);
    
    
    //持仓明细
    [self.tableView registerNib:[UINib nibWithNibName:@"zkChiCangMingXiCell" bundle:nil] forCellReuseIdentifier:@"zkChiCangMingXiCell"];
    //成交历史
    [self.tableView registerNib:[UINib nibWithNibName:@"zkChengJiaoLiShiCell" bundle:nil] forCellReuseIdentifier:@"zkChengJiaoLiShiCell"];
    //未成交
    [self.tableView registerNib:[UINib nibWithNibName:@"zkWeiChengJiaoCell" bundle:nil] forCellReuseIdentifier:@"zkWeiChengJiaoCell"];
    //历史委托
    [self.tableView registerNib:[UINib nibWithNibName:@"zkLishiWeiTuoCell" bundle:nil] forCellReuseIdentifier:@"zkLishiWeiTuoCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNumber = 1;
        [self getDataList];
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getDataList];
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
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.type == 0) {
        //持仓明细
        zkChiCangMingXiCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkChiCangMingXiCell" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            cell.titleArr = self.titleArr[self.type];
            cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }else {
            cell.backgroundColor = WhiteColor;
            zkBTCChiYouModel * model = self.dataArray[indexPath.row];
            cell.model = model;
        }
        
        return cell;
    }else if (self.type == 1) {
        //未成交
        zkWeiChengJiaoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkWeiChengJiaoCell" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            cell.titleArr = self.titleArr[self.type];
            cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }else {
            cell.backgroundColor = WhiteColor;
             zkBTCChiYouModel * model = self.dataArray[indexPath.row];
//            if (![model.userId isEqualToString:[zkSignleTool shareTool].userInfoModel.ID]){
//                cell.
//            }
            cell.model = model;
        }
        
        cell.cheDanBt.tag = indexPath.row;
        [cell.cheDanBt addTarget:self action:@selector(cheDanAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (self.type == 2) {
        //成交历史
        zkChengJiaoLiShiCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkChengJiaoLiShiCell" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            cell.titleArr = self.titleArr[self.type];
            cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }else {
            cell.backgroundColor = WhiteColor;
            zkBTCChiYouModel * model = self.dataArray[indexPath.row];
            cell.model = model;
        }
       
        return cell;
    }
    
    zkLishiWeiTuoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkLishiWeiTuoCell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.titleArr = self.titleArr[self.type];
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }else {
        cell.backgroundColor = WhiteColor;
        zkBTCChiYouModel * model = self.dataArray[indexPath.row];
        cell.model = model;
    }
    
    return cell;
}

#pragma mark --- 撤单 ----
- (void)cheDanAction:(UIButton *)button {
    
    if ([zkSignleTool shareTool].isLogin && [self.userID isEqualToString:[zkSignleTool shareTool].userInfoModel.ID]) {
        //是自己才可以撤单
        zkBTCChiYouModel * model = self.dataArray[button.tag];
        NSMutableDictionary * dict = @{}.mutableCopy;
        dict[@"userId"] = self.userID;
        dict[@"orderid"] = model.ID;
        [SVProgressHUD show];
        [zkRequestTool networkingGET:[zkURL getTradeCancelURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
                [SVProgressHUD showSuccessWithStatus:@"撤单成功"];
                [self.dataArray removeObjectAtIndex:button.tag];
                [self.tableView reloadData];
          
            } else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
                [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
            }else {
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
        
    }
    
    
    
    
}

#pragma --- 获取除了持仓明细的记录 ---------- 
- (void)getDataList {
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"userId"] = self.userID;
    dict[@"pageNo"] = @(self.pageNumber);
    dict[@"type"] = @(self.type);
    dict[@"pageSize"] = @30;
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:[zkURL getTradeHistoryURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            [SVProgressHUD dismiss];
            NSArray * arr = [zkBTCChiYouModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"rows"]];
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



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.type == 1) {
        return;
    }
    
    zkBTCChiYouModel * model = self.dataArray[indexPath.row];
    
    if (([model.status integerValue] == 1 || [model.status integerValue] == 3) && self.type == 3) {
        return;
    }
    zkOneBiZhongChiCangTVC * vc =[[zkOneBiZhongChiCangTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    vc.hidesBottomBarWhenPushed = YES;
    vc.btcName = model.bitName;
    vc.userID = self.userID;
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
