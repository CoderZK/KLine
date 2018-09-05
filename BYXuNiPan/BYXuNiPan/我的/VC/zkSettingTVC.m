//
//  zkSettingTVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/16.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkSettingTVC.h"
#import "zkSettingCell.h"
#import "Clear.h"
#import "zkAccountNumberSettingTVC.h"
#import "zkDingYueTVC.h"
#import "zkPushSettingTVC.h"
#import "zkAboutUsVC.h"
#import "zkYiJianFanKuiTVC.h"
@interface zkSettingTVC ()
@property(nonatomic,strong)NSArray *leftArr;
@end

@implementation zkSettingTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置";
    self.leftArr = @[@"清除缓存",@"账号设置",@"推送设置",@"关于我们",@"意见反馈"];
    [self.tableView registerNib:[UINib nibWithNibName:@"zkSettingCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self configFootView];
    
   
    
    
}

- (void)configFootView{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenH - sstatusHeight - 44 - 44, ScreenW, 44)];
    if (sstatusHeight == 44) {
        footView.frame = CGRectMake(0, ScreenH - sstatusHeight - 44 - 44 - 34, ScreenW, 44);
    }
    UIButton * _clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _clearBtn.frame = CGRectMake(0, 0, ScreenW, 45);
    [_clearBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    [_clearBtn setBackgroundImage:[UIImage imageNamed:@"zk_blue"] forState:UIControlStateNormal];
    _clearBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_clearBtn addTarget:self action:@selector(outoLogin) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:_clearBtn];
    [self.view addSubview:footView];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.leftArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    zkSettingCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.leftLB.text = _leftArr[indexPath.row];
    if (indexPath.row == 0) {
        cell.rightLB.hidden = NO;
        cell.rightImageV.hidden = YES;
        cell.rightCon.constant = 15;
        cell.rightLB.text = [NSString stringWithFormat:@"%0.1lfM",[Clear folderSizeAtPath]];
    }else {
        cell.rightLB.hidden = YES;
        cell.rightImageV.hidden = NO;
        cell.rightCon.constant = 40;
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self ClearAction];
    }else if (indexPath.row == 1) {
        zkAccountNumberSettingTVC * vc =[[zkAccountNumberSettingTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2) {
        zkPushSettingTVC * vc =[[zkPushSettingTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 3) {
        zkAboutUsVC * vc =[[zkAboutUsVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];

    }else if (indexPath.row == 4) {
        zkYiJianFanKuiTVC * vc =[[zkYiJianFanKuiTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (void)ClearAction{
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:@"确定要清除缓存" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [Clear cleanCache:^{
            [self.tableView reloadData];
        }];
    }];
  
    [ac addAction:action1];
    [ac addAction:action2];

    
    [self.navigationController presentViewController:ac animated:YES completion:nil];
    
}

- (void)outoLogin {

    [[zkSignleTool shareTool] uploadDeviceTokenWith:@"123"];
    [zkSignleTool shareTool].isLogin = NO;
    [zkSignleTool shareTool].session_token = nil;
    [zkSignleTool shareTool].userInfoModel = [[zkUserInfoModel alloc] init];
    [self.navigationController popToRootViewControllerAnimated:YES];
 
    
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
