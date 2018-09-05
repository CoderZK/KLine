//
//  zkShouFeiJiLuDetailTVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/17.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkShouFeiJiLuDetailTVC.h"
#import "zkSettingCell.h"
#import "zkPurseOneCell.h"
#import "zkShouFuJiLumodel.h"
@interface zkShouFeiJiLuDetailTVC ()
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)UIButton *confirmBt;
@property(nonatomic,strong)zkShouFuJiLumodel *dataModel;
@end

@implementation zkShouFeiJiLuDetailTVC
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
    self.titleArr = @[@[@""],@[@"付款方式",@"交易对象",@"订单号",@"创建时间"],@[@"客服申诉"]];
    self.navigationItem.title = @"记录详情";
    [self.tableView registerNib:[UINib nibWithNibName:@"zkSettingCell" bundle:nil] forCellReuseIdentifier:@"zkSettingCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"zkPurseOneCell" bundle:nil] forCellReuseIdentifier:@"zkPurseOneCell"];
    
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
    
    [self setFootV];
}

- (void)setFootV {
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH - sstatusHeight - 44 - 44, ScreenW, 44)];
    UIButton * _clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _clearBtn.frame = CGRectMake(0, 0, ScreenW, 45);
    [_clearBtn setTitle:@"确认收款" forState:UIControlStateNormal];
    [_clearBtn setBackgroundImage:[UIImage imageNamed:@"zk_blue"] forState:UIControlStateNormal];
    _clearBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_clearBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:_clearBtn];
    self.confirmBt = _clearBtn;
    [self.view addSubview:footView];
    
}

//点击确认收款
- (void)confirmAction:(UIButton *)button {
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.titleArr[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return 10;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 120;
    }else {
        return 44;
    }
 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        zkPurseOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkPurseOneCell" forIndexPath:indexPath];
        
        return cell;
    }else {
        zkSettingCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkSettingCell" forIndexPath:indexPath];
        cell.leftLB.font = [UIFont boldSystemFontOfSize:14];
        cell.rightLB.hidden = YES;
        cell.rightImageV.hidden = YES;
        cell.leftLB.text = self.titleArr[indexPath.section][indexPath.row];
        cell.rightLB.hidden = NO;
        if (indexPath.section == 1 && indexPath.row != 1 ) {
            cell.hidenRightImgV = YES;
            cell.rightCon.constant = 15;
        }else {
            cell.hidenRightImgV = NO;
            cell.rightCon.constant = 40;
        }
        if (indexPath.section == 2) {
            cell.rightLB.hidden = YES;
        }else {
            cell.rightLB.hidden = NO;
        }
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                cell.rightLB.text = self.dataModel.payType;
            }else if (indexPath.row == 1) {
                cell.rightLB.text = self.dataModel.nickName;
            }else if (indexPath.row == 2) {
                
            }else if (indexPath.row == 3) {
                cell.rightLB.text = self.dataModel.payTime;
            }
        }
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1 && indexPath.row == 1) {
        
        zkOtherCerterTVC * vc =[[zkOtherCerterTVC alloc] init];
        vc.userID = self.dataModel.userId;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

- (void)getData {
    
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }
    NSString * url = [NSString stringWithFormat:@"%@/%@",[zkURL getUserFollowIncomeDetailURL],self.ID];
    [SVProgressHUD show];
    [zkRequestTool networkingGET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([responseObject[@"code"] integerValue] == 200) {
             [SVProgressHUD dismiss];
            [self.tableView.mj_header endRefreshing];
            self.dataModel = [zkShouFuJiLumodel mj_objectWithKeyValues:responseObject[@"result"]];
            [self.tableView reloadData];
        } else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
    
    
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
