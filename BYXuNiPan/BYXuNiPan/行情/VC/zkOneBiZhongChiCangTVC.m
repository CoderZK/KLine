//
//  zkOneBiZhongChiCangTVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/20.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkOneBiZhongChiCangTVC.h"
#import "zkBiZhongChiCangOneCell.h"
#import "zkBiZhongChiCangTwoCell.h"
#import "zkBiZhongChiCangThreeCell.h"
#import "zkSettingCell.h"
#import "zkOneBtcChiCangModel.h"
#import "zkBiZhongDetailTVC.h"
@interface zkOneBiZhongChiCangTVC ()

@property(nonatomic,strong)zkOneBtcChiCangModel *dataModel;

@end

@implementation zkOneBiZhongChiCangTVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    [self.tableView registerNib:[UINib nibWithNibName:@"zkBiZhongChiCangOneCell" bundle:nil] forCellReuseIdentifier:@"zkBiZhongChiCangOneCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"zkSettingCell" bundle:nil] forCellReuseIdentifier:@"zkSettingCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"zkBiZhongChiCangTwoCell" bundle:nil] forCellReuseIdentifier:@"zkBiZhongChiCangTwoCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"zkBiZhongChiCangThreeCell" bundle:nil] forCellReuseIdentifier:@"zkBiZhongChiCangThreeCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
    self.navigationItem.title = [NSString stringWithFormat:@"当前持仓-%@",[self.btcName uppercaseString]];
    
}

- (void)getData {
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"userId"] = self.userID;
    dict[@"bitName"] = self.btcName;
    [zkRequestTool networkingGET:[zkURL getTradePositionDetailURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            
            self.dataModel = [zkOneBtcChiCangModel mj_objectWithKeyValues:responseObject[@"result"]];
            [self.tableView reloadData];
            
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!self.dataModel) {
        return  0;
    }
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return self.dataModel.records.count +  1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 70;
    }else if (indexPath.section == 1) {
        return 210;
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            return 40;
        }else {
            return 80;
        }
    }
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        zkBiZhongChiCangOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkBiZhongChiCangOneCell" forIndexPath:indexPath];
        [cell.headBt sd_setBackgroundImageWithURL:[NSURL URLWithString:self.dataModel.imge] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
        cell.nameLB.text = self.dataModel.name;
        cell.contentLB.text = [NSString stringWithFormat:@"总收益 %0.2f 近7日收益%0.2f",[self.dataModel.totalPercent floatValue],[self.dataModel.totalWeekPercent floatValue]];
        if ([self.dataModel.userId isEqualToString:[zkSignleTool shareTool].userInfoModel.ID]) {
            cell.guanZhuLB.hidden = YES;
        }else {
            cell.guanZhuLB.hidden = NO;
        }
        return cell;
    }else if (indexPath.section == 1) {
        zkBiZhongChiCangTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkBiZhongChiCangTwoCell" forIndexPath:indexPath];
        cell.model = self.dataModel;
        [cell.buyBt addTarget:self action:@selector(buyOrSell) forControlEvents:UIControlEventTouchUpInside];
        [cell.sellBt addTarget:self action:@selector(buyOrSell) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }else if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            zkSettingCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkSettingCell" forIndexPath:indexPath];
            cell.rightLB.hidden = YES;
            cell.rightImageV.hidden = YES;
            cell.leftLB.text = @"调仓记录";
            cell.leftLB.font = [UIFont boldSystemFontOfSize:15];
            return cell;
        }else {
            zkBiZhongChiCangThreeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkBiZhongChiCangThreeCell" forIndexPath:indexPath];
            cell.model = self.dataModel.records[indexPath.row - 1];
            return cell;
        }
    }
    
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    return cell;
    
}

- (void)buyOrSell{
     zkBiZhongDetailTVC* vc =[[zkBiZhongDetailTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    zkBiModel * model = [[zkBiModel alloc] init];
    model.bitName = self.dataModel.bitName;
    vc.hidesBottomBarWhenPushed = YES;
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
