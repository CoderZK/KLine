//
//  zkYiJianFanKuiTVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/17.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkYiJianFanKuiTVC.h"
#import "IQTextView.h"
#import "zkSettingCell.h"
#import "zkYiJianFanKuiModel.h"
#import "zkYiJianFanKuiDetailVC.h"
@interface zkYiJianFanKuiTVC ()
@property(nonatomic,strong)IQTextView *TV;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation zkYiJianFanKuiTVC

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"意见反馈";
    [self setHeadV];
    [self.tableView registerNib:[UINib nibWithNibName:@"zkSettingCell" bundle:nil] forCellReuseIdentifier:@"cell"];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self getYiJianFanKuiList];
}

- (void)setHeadV {
    UIView * whiteV =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 250)];
    whiteV.backgroundColor = WhiteColor;
    
    self.TV = [[IQTextView alloc] initWithFrame:CGRectMake(15,15, ScreenW - 30, 150)];
    self.TV.placeholder = @"请书写10字以上的意见或者建议,我们将不断改进产品...";
    self.TV.font = kFont(14);
    self.TV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [whiteV addSubview:self.TV];
    [self.view addSubview:whiteV];
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(15, CGRectGetMaxY(self.TV.frame) + 20, ScreenW - 30, 40);
    right.titleLabel.font = kFont(15);
    [right setTitleColor:WhiteColor forState:UIControlStateNormal];
    [right setBackgroundImage:[UIImage imageNamed:@"zk_blue"] forState:UIControlStateNormal];
//    [right setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentRight)];
    [right setTitle:@"提交反馈" forState:UIControlStateNormal];
    right.layer.cornerRadius = 20;
    right.clipsToBounds = YES;
    [right addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [whiteV addSubview:right];
    self.tableView.tableHeaderView = whiteV;
   
}

//点击提交
- (void)clickAction:(UIButton *)button {
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }
    if (self.TV.text.length <10) {
        [SVProgressHUD showErrorWithStatus:@"请输入10字以上的意见或者建议"];
        return;
    }
    
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:[zkURL getAuthAddURL] parameters:@{@"question":self.TV.text} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            
            [SVProgressHUD showSuccessWithStatus:@"意见或者建议反馈成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 700){
            [self showAlertWithKey:@"700" message:nil];
        }  else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
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
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    zkSettingCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    if (indexPath.section == 0) {
        cell.leftLB.text = @"常见问题";
        cell.rightLB.hidden = cell.rightImageV.hidden = YES;
    }else {
        zkYiJianFanKuiModel * model = self.dataArray[indexPath.row];
        cell.rightImageV.hidden = NO;
        cell.leftLBCon.constant = ScreenW - 15 - 45;
        cell.leftLB.text = model.question;
    
    }

    cell.rightLB.hidden = YES;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    zkYiJianFanKuiDetailVC * vc =[[zkYiJianFanKuiDetailVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.isComeYiJian = YES;
    vc.model = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];  
}


- (void)getYiJianFanKuiList {
    
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:[zkURL getAuthListURL] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
             [SVProgressHUD dismiss];
            self.dataArray = [zkYiJianFanKuiModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            [self.tableView reloadData];
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
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
