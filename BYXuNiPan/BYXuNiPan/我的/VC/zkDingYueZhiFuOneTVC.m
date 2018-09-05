//
//  zkDingYueZhiFuOneTVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/18.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkDingYueZhiFuOneTVC.h"
#import "zkSettingTwoCell.h"
#import "zkDingYueZhiFuMoneyOneCell.h"
#import "zkDingYueZhiFuTwoCell.h"
#import "zkDingYueZhiFuDetailTVC.h"


@interface zkDingYueZhiFuOneTVC ()
@property(nonatomic,strong)NSString *xuZhiFuStr;
@property(nonatomic,strong)NSString *myMoneyStr;
@end

@implementation zkDingYueZhiFuOneTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //点击订阅进入的界面
    self.navigationItem.title = @"支付";
    [self.tableView registerNib:[UINib nibWithNibName:@"zkSettingTwoCell" bundle:nil] forCellReuseIdentifier:@"zkSettingTwoCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"zkDingYueZhiFuMoneyOneCell" bundle:nil] forCellReuseIdentifier:@"zkDingYueZhiFuMoneyOneCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"zkDingYueZhiFuTwoCell" bundle:nil] forCellReuseIdentifier:@"zkDingYueZhiFuTwoCell"];
    [self getData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
 
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    //return 2; //此时包含订阅二维码订阅
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }else {
        return 3;
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1 && indexPath.section == 0) {
        return 80;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 ) {
        if (indexPath.row == 0) {
            zkDingYueZhiFuMoneyOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkDingYueZhiFuMoneyOneCell" forIndexPath:indexPath];
            cell.leftLB.text = @"币支付";
            cell.rightLB.text = [NSString stringWithFormat:@"%@ Lxc",self.xuZhiFuStr];
            return cell;
        }else {
            zkDingYueZhiFuTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkDingYueZhiFuTwoCell" forIndexPath:indexPath];
            cell.leftOneLB.text = @"LXC支付";
            cell.leftTwoLB.text = [NSString stringWithFormat:@"可用:%@ Lxc",self.myMoneyStr];
            return cell;
        }
    }else {
        if (indexPath.row == 0) {
            zkDingYueZhiFuMoneyOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkDingYueZhiFuMoneyOneCell" forIndexPath:indexPath];
            cell.leftLB.text = @"人民币支付";
            return cell;
        }else {
            zkSettingTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkSettingTwoCell" forIndexPath:indexPath];
            cell.titleLBRightCon.constant = 100;
            cell.rightImgV.hidden = YES;
            cell.rightLB.hidden = NO;
            
            if (indexPath.row == 1) {
                cell.leftLB.text = @"支付宝转账";
                cell.rightImgV.image = [UIImage imageNamed:@"zhifubao"];
            }else {
                cell.leftLB.text = @"微信转账";
                cell.rightImgV.image = [UIImage imageNamed:@"weixin2"];
            }
            return cell;
        }
        
        
    }
    
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1 && indexPath.row > 0) {
        
        zkDingYueZhiFuDetailTVC * vc =[[zkDingYueZhiFuDetailTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.userID = self.userID;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }else  {
        
        if ([self.myMoneyStr floatValue] < [self.xuZhiFuStr floatValue]) {
            [SVProgressHUD showErrorWithStatus:@"您的LXC币不足,无法支付"];
            return;
        }
        
        
        UIAlertController *alt = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"确定支付%@LXC",self.xuZhiFuStr] message:[NSString stringWithFormat:@"可用: %@LXC",self.myMoneyStr] preferredStyle:UIAlertControllerStyleAlert];
   
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self addDingYue];
        }];
        
        
        [alt addAction:cancelAction];
        [alt addAction:okAction];
        
        [self presentViewController:alt animated:YES completion:nil];
        
    }
    
}

//订阅
- (void)addDingYue {
    
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }
    self.tableView.userInteractionEnabled = NO;
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"followUserId"] = self.userID;
    dict[@"money"] = self.xuZhiFuStr;
    dict[@"payType"] = @"1";
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:[zkURL getAddDingYueURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        self.tableView.userInteractionEnabled = YES;
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
             [SVProgressHUD showSuccessWithStatus:@"订阅成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.sendDingYueBlock != nil ) {
                    self.sendDingYueBlock();
                }
                [self.navigationController popViewControllerAnimated:YES];
                
            });
        }    else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
         self.tableView.userInteractionEnabled = YES;
    }];
    
}

//获取支付详情
- (void)getData {
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"followUserId"] = self.userID;
    dict[@"userId"] = [zkSignleTool shareTool].userInfoModel.ID;
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:[zkURL getUserPayConfirmURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
             [SVProgressHUD dismiss];
            self.xuZhiFuStr = [NSString stringWithFormat:@"%@",responseObject[@"result"][@"followLxcPrice"]];
            self.myMoneyStr = [NSString stringWithFormat:@"%@",responseObject[@"result"][@"userLxcPrice"]];
            [self.tableView reloadData];
        }else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
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
