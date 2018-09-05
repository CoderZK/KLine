//
//  MineVC.m
//  BYXuNiPan
//
//  Created by kunzhang on 2018/7/2.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "MineVC.h"
#import "zkMineHeadView.h"
#import "zkOtherTwoCell.h"
#import "zkMineTongYongCell.h"
#import "zkNewsTVC.h"
#import "zkEditUserInfoVC.h"
#import "zkSettingTVC.h"
#import "zkDingYueTVC.h"
#import "zkPurseTVC.h"
#import "zkKeFuVC.h"
#import "zkShouFeiJiLuTVC.h"
#import "zkMineFenSiTVC.h"
#import "zkMineDingYueTVC.h"
#import "zkMineZiXuanTVC.h"
#import "zkYaoQingHaoYouVC.h"
#import "zkUserInfoModel.h"
#import "zkYiJianFanKuiDetailVC.h"
#import "zkOtherZiXuanTVC.h"
#import "zkMoreOperationTVC.h"
@interface MineVC ()<zkMineHeadViewDelegate>
@property(nonatomic,assign)BOOL isWhite;

@property(nonatomic,strong)zkMineHeadView *headView;
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)zkUserInfoModel *userInfoModel;//记录内部的排名
@property(nonatomic,strong)zkUserInfoModel *dataModel;//外部个人的信息
@end

@implementation MineVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isWhite = YES;
    self.navigationController.navigationBar.hidden = YES;
   [UIApplication sharedApplication].statusBarStyle = [self preferredStatusBarStyle];
    if ([zkSignleTool shareTool].isLogin == NO) {
        self.tabBarController.selectedIndex = 0;
    }else {
        [self getUserInfo];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.isWhite = NO;
    [UIApplication sharedApplication].statusBarStyle = [self preferredStatusBarStyle];

}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.isWhite) {
        return UIStatusBarStyleLightContent;
    }else {
        return UIStatusBarStyleDefault;
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.frame = CGRectMake(0, -sstatusHeight, ScreenW, ScreenH - 49  + sstatusHeight);
    [self setHeadView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getUserInfo];
    }];

    [self.tableView registerNib:[UINib nibWithNibName:@"zkOtherTwoCell" bundle:nil] forCellReuseIdentifier:@"zkOtherTwoCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"zkMineTongYongCell" bundle:nil] forCellReuseIdentifier:@"zkMineTongYongCell"];
    self.titleArr = @[@[],@[@"持仓明细",@"消息",@"订阅设置",@"收付记录"],@[@"活跃奖励说明"],@[@"推荐给朋友",@"清除交易",@"联系客服"]];
    
    
}

- (void)setHeadView {
    zkMineHeadView * whiteV = [[zkMineHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, kScreenHSacle(235))];
    self.headView = whiteV;
    whiteV.delegate = self;
    self.tableView.tableHeaderView = whiteV;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!self.userInfoModel) {
        return 0;
    }
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 2) {
        return 1;
    }else if (section == 1) {
        return 4;
    }
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 210;
    }
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
    if (indexPath.section == 0) {
        zkOtherTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkOtherTwoCell" forIndexPath:indexPath];
         self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.model = self.userInfoModel;
        return cell;
    }else {
         self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        zkMineTongYongCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkMineTongYongCell" forIndexPath:indexPath];
        if (indexPath.section == 1 && indexPath.row == 1) {
            if ([self.dataModel.unReadMsgCount integerValue] > 0) {
                cell.redV.hidden = NO;
            }else {
               cell.redV.hidden = YES;
            }
        }else {
            cell.redV.hidden = YES;
        }
        cell.leftLB.text = self.titleArr[indexPath.section][indexPath.row];
        cell.leftImgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"zk_mine%ld%ld",(long)indexPath.section,(long)indexPath.row]];
        return cell;
    }
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        [self jiaoyimingxi];
        return;
    }else if(indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self jiaoyimingxi];
            return;
        }else  if (indexPath.row == 1) {
            //点击消息
            zkNewsTVC * vc =[[zkNewsTVC alloc] initWithTableViewStyle:(UITableViewStylePlain)];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 2) {
            //订阅设置
            zkDingYueTVC * vc =[[zkDingYueTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 3){
            zkShouFeiJiLuTVC * vc =[[zkShouFeiJiLuTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (indexPath.section == 2) {
     
        zkYiJianFanKuiDetailVC   * vc =[[zkYiJianFanKuiDetailVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.isComeJiangLi = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            zkYaoQingHaoYouVC * vc =[[zkYaoQingHaoYouVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
          
        }else if (indexPath.row == 1){
            [self confirmAction];
        }else if (indexPath.row == 2){
            zkKeFuVC * vc =[[zkKeFuVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        }
    }
 
}

//去交易明细
- (void)jiaoyimingxi {
    
    NSArray * titleArr = @[@"持仓明细",@"未成交",@"成交历史",@"历史委托"];
    NSMutableArray * vcsArr = @[].mutableCopy;
    for (int i = 0 ; i < titleArr.count ; i++) {
        zkMoreOperationTVC * tvc = [[zkMoreOperationTVC alloc] init];
        tvc.type = i;
        tvc.userID = self.dataModel.ID;
        [vcsArr addObject:tvc];
    }
    zkContrainTitlesFatherVC * vc =[[zkContrainTitlesFatherVC alloc] initFrame:self.view.bounds titleArr:titleArr vcsArr:vcsArr];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

//点击确认支付
- (void)confirmAction {
    
    UIAlertController *alt = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"清除后您的本金将回到最初值,所有的交易记录将被清除" preferredStyle:UIAlertControllerStyleAlert];
  
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        [self deleteTrade];
       
    }];
    
    
    [alt addAction:cancelAction];
    [alt addAction:okAction];
    
    [self presentViewController:alt animated:YES completion:nil];
    
}


#pragma amrk --- 点击我的透视图的几个按钮 ---
- (void)didClickHead:(UIButton *)button index:(NSInteger)index {
    if (index == 0) {
        //点击的是设置
        zkSettingTVC * vc =[[zkSettingTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 1) {
        //点击的是自己的头像
        zkOtherCerterTVC * vc =[[zkOtherCerterTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.userID = [zkSignleTool shareTool].userInfoModel.ID;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 2){
        //点击的是修改
        zkEditUserInfoVC * vc =[[zkEditUserInfoVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (index == 3) {
        //我的订阅
        zkMineDingYueTVC * vc =[[zkMineDingYueTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.userID = [zkSignleTool shareTool].userInfoModel.ID;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 4) {
       //粉丝
        zkMineFenSiTVC * vc =[[zkMineFenSiTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.userID = [zkSignleTool shareTool].userInfoModel.ID;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 5) {
        //自选
//        zkMineZiXuanTVC * vc =[[zkMineZiXuanTVC alloc] init];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
        
        zkOtherZiXuanTVC * vc =[[zkOtherZiXuanTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.userID = [zkSignleTool shareTool].userInfoModel.ID;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (index == 6) {
        //点击的是钱包
   
        zkPurseTVC * vc =[[zkPurseTVC alloc] init];
        vc.moneyStr = [zkSignleTool shareTool].userInfoModel.wallet;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

//获取个人信息
- (void)getUserInfo {
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }
    [SVProgressHUD show];
    [zkRequestTool networkingGET:[zkURL getUserInfoURL] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            [SVProgressHUD dismiss];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            [zkSignleTool shareTool].userInfoModel = [zkUserInfoModel mj_objectWithKeyValues:responseObject[@"result"]];
            self.dataModel =  [zkUserInfoModel mj_objectWithKeyValues:responseObject[@"result"]];
            self.userInfoModel =  [zkUserInfoModel mj_objectWithKeyValues:responseObject[@"result"][@"statisticsDataResponse"]];
            self.headView.model = [zkUserInfoModel mj_objectWithKeyValues:responseObject[@"result"]];
            [self.tableView reloadData];
            
        } else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

//清除交易
- (void)deleteTrade {
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:[zkURL getUserInfoAuthTradeURL] parameters:@{@"userId":[zkSignleTool shareTool].userInfoModel.ID} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            
            [self getUserInfo];

        } else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
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
