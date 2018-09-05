//
//  zkPushSettingTVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/17.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkPushSettingTVC.h"
#import "zkSettingCell.h"
@interface zkPushSettingTVC ()

@property(nonatomic,assign)BOOL tieZi,yueDuJiaoYi,pingLun,dianZan,xinWenGongGao;
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)UILabel *lb;
@end

@implementation zkPushSettingTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (![self isUserNotificationEnable]) {
        
        self.tieZi = self.yueDuJiaoYi = self.pingLun = self.dianZan = self.xinWenGongGao = NO;
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:@"您还没有开启推送,是否去开启推送" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           
            [self goToAppSystemSetting];
            
        }];
        [ac addAction:action1];
        [ac addAction:action2];
        [self.navigationController presentViewController:ac animated:YES completion:nil];
    }
    [self getPushDetail];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"推送设置";
    self.titleArr = @[@"订阅帖子",@"订阅交易",@"评论",@"点赞",@"新闻公告"];
    [self.tableView registerNib:[UINib nibWithNibName:@"zkSettingCell" bundle:nil] forCellReuseIdentifier:@"cell"];
 
    
    
}


- (void)setFootV {
    
    self.lb = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, ScreenW - 30, 20)];
    self.lb.textColor = CharacterBlackColor30;
    self.lb.text = @"";
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    zkSettingCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.rightImageV.hidden = YES;
    cell.rightLB.hidden = YES;
    cell.swiftOn.hidden = NO;
    cell.swiftOn.userInteractionEnabled = NO;
    
    if (![self isUserNotificationEnable]) {
        cell.swiftOn.on = NO;
    }else {
        if (indexPath.row == 0) {
            cell.swiftOn.on = self.tieZi;
        }else if (indexPath.row ==1) {
            cell.swiftOn.on = self.yueDuJiaoYi;
        }else if (indexPath.row == 2) {
            cell.swiftOn.on = self.pingLun;
        }else if (indexPath.row ==3) {
            cell.swiftOn.on = self.dianZan;
        }else if (indexPath.row == 4) {
            cell.swiftOn.on = self.xinWenGongGao;
        }
    }
    cell.leftLB.text = _titleArr[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (![self isUserNotificationEnable]) {
        
        self.tieZi = self.yueDuJiaoYi = self.pingLun = self.dianZan = self.xinWenGongGao = NO;
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:@"您还没有开启推送,是否去开启推送" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self goToAppSystemSetting];
            
        }];
        [ac addAction:action1];
        [ac addAction:action2];
        [self.navigationController presentViewController:ac animated:YES completion:nil];
        
    }else {
        if (indexPath.row == 0) {
            self.tieZi = !self.tieZi;
        }else if (indexPath.row ==1) {
            self.yueDuJiaoYi = !self.yueDuJiaoYi;
        }else if (indexPath.row == 2) {
            self.pingLun = !self.pingLun;
        }else if (indexPath.row ==3) {
            self.dianZan = !self.dianZan;
        }else if (indexPath.row == 4) {
            self.xinWenGongGao = !self.xinWenGongGao;
        }
        [self updatePush];
        [self.tableView reloadData];
    }
    
    
   

    
    
}

//更新推送
- (void)updatePush {
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"pushNews"] = @(self.xinWenGongGao);
    dict[@"pushReply"] = @(self.pingLun);
    dict[@"pushSupport"] = @(self.dianZan);
    dict[@"pushTopic"] = @(self.tieZi);
    dict[@"pushTrade"] = @(self.yueDuJiaoYi);
    dict[@"userId"] = [zkSignleTool shareTool].userInfoModel.ID;
    
    [SVProgressHUD show];
    [zkRequestTool networkingJsonPOST:[zkURL getUserPushUpdateURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
         [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        

    }];
    
}





- (BOOL)isUserNotificationEnable { // 判断用户是否允许接收通知
    BOOL isEnable = NO;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f) { // iOS版本 >=8.0 处理逻辑
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        isEnable = (UIUserNotificationTypeNone == setting.types) ? NO : YES;
    } else { // iOS版本 <8.0 处理逻辑
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        isEnable = (UIRemoteNotificationTypeNone == type) ? NO : YES;
    }
    return isEnable;
}

// 如果用户关闭了接收通知功能，该方法可以跳转到APP设置页面进行修改  iOS版本 >=8.0 处理逻辑
- (void)goToAppSystemSetting {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([application canOpenURL:url]) {
        if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            [application openURL:url options:@{} completionHandler:nil];
        } else {
            [application openURL:url];
        }
    }
}

- (void)getPushDetail {
    
    [SVProgressHUD show];
    [zkRequestTool networkingGET:[zkURL getUserPushlURL] parameters:@{@"userId":[zkSignleTool shareTool].userInfoModel.ID} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
             [SVProgressHUD dismiss];
            NSDictionary * dict = responseObject[@"result"];
            //新闻
            if ([[NSString stringWithFormat:@"%@",dict[@"pushNews"]] integerValue] == 1) {
                self.xinWenGongGao = YES;
            }else {
                self.xinWenGongGao = NO;
            }
            //点赞
            if ([[NSString stringWithFormat:@"%@",dict[@"pushSupport"]] integerValue] == 1) {
                self.dianZan = YES;
            }else {
                self.dianZan = NO;
            }
            //交易
            if ([[NSString stringWithFormat:@"%@",dict[@"pushTrade"]] integerValue] == 1) {
                self.yueDuJiaoYi = YES;
            }else {
                self.yueDuJiaoYi = NO;
            }
            //评论
            if ([[NSString stringWithFormat:@"%@",dict[@"pushReply"]] integerValue] == 1) {
                self.pingLun = YES;
            }else {
                self.pingLun = NO;
            }
            //订阅帖子
            if ([[NSString stringWithFormat:@"%@",dict[@"pushTopic"]] integerValue] == 1) {
                self.tieZi = YES;
            }else {
                self.tieZi = NO;
            }

            [self.tableView reloadData];
            
            
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 700){
            [self showAlertWithKey:@"700" message:nil];
        } else {
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
