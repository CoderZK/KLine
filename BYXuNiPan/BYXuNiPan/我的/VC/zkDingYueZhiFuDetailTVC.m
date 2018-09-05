//
//  zkDingYueZhiFuDetailTVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/18.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkDingYueZhiFuDetailTVC.h"
#import "zkSettingCell.h"
#import "zkSettingTwoCell.h"
#import "zkSettingThreeCell.h"
@interface zkDingYueZhiFuDetailTVC ()
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)NSString *remarkStr;
@end

@implementation zkDingYueZhiFuDetailTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArr = @[@"支付宝",@"姓名",@"账号",@"收款二维码"];
    [self.tableView registerNib:[UINib nibWithNibName:@"zkSettingCell" bundle:nil] forCellReuseIdentifier:@"zkSettingCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"zkSettingTwoCell" bundle:nil] forCellReuseIdentifier:@"zkSettingTwoCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"zkSettingThreeCell" bundle:nil] forCellReuseIdentifier:@"zkSettingThreeCell"];
    
    [self configFootView];
    self.navigationItem.title = @"支付";
}

- (void)configFootView{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 70)];
    footView.backgroundColor = WhiteColor;
    UIButton * _clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _clearBtn.frame = CGRectMake(15, 10, ScreenW - 30, 45);
    [_clearBtn setTitle:@"确认转账" forState:UIControlStateNormal];
    [_clearBtn setBackgroundImage:[UIImage imageNamed:@"zk_blue"] forState:UIControlStateNormal];
    _clearBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_clearBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    _clearBtn.layer.cornerRadius = 4;
    _clearBtn.clipsToBounds = YES;
    [footView addSubview:_clearBtn];

    self.tableView.tableFooterView = footView;
}


//点击确认支付
- (void)confirmAction:(UIButton *)button {
    
    UIAlertController *alt = [UIAlertController alertControllerWithTitle:@"温馨提示" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alt addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"请输入备注,以便大牛找到你你的付款记录";
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UITextField *inputInfo = alt.textFields.firstObject;
        self.remarkStr = inputInfo.text;
        [self showAleartTwo:button];
    }];
    
    
    [alt addAction:cancelAction];
    [alt addAction:okAction];
    
    [self presentViewController:alt animated:YES completion:nil];

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
        return 150;
    }
    return 44;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 3) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }else {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    
    if (indexPath.section == 0) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil ) {
            cell =[[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
        }
        return cell;
    }
    if (indexPath.row == 0) {
        zkSettingTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkSettingTwoCell" forIndexPath:indexPath];
        cell.leftLB.text = self.titleArr[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
     
        [cell.headBt setBackgroundImage: [UIImage imageNamed:@"zhifubao"] forState:UIControlStateNormal];
        //
        cell.leftImageV.image = [UIImage imageNamed:@"weixin2"];
        
        return cell;
    }else if (indexPath.row <= 3) {
        zkSettingCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkSettingCell" forIndexPath:indexPath];
        
        cell.leftLB.text = self.titleArr[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 3) {
            cell.rightLB.text = @"";
        }
        cell.rightCon.constant = 15;
        cell.rightImageV.hidden = YES;
        return cell;
    }else {
        zkSettingThreeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkSettingThreeCell" forIndexPath:indexPath];
        cell.imgV.image = [UIImage imageNamed:@"369"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if(section == 1) {
        return 0.01;
    }
    return 10;
}

- (void)showAleartTwo:(UIButton *)button  {
    
    UIAlertController *alt = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"若实际未转账,平台查实后将与与您联系" preferredStyle:UIAlertControllerStyleAlert];
    

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //这边可添加网络请求的代码。
        [self addDingYue:button];
        
        
    }];
    [alt addAction:cancelAction];
    [alt addAction:okAction];
    
    [self presentViewController:alt animated:YES completion:nil];
}

//订阅
- (void)addDingYue:(UIButton *)button  {
    
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"followUserId"] = self.userID;
    dict[@"money"] = @"0";
    dict[@"payType"] = @"1";
    dict[@"remark"] = self.remarkStr;
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:[zkURL getAddDingYueURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
             [SVProgressHUD dismiss];
            zkOtherCerterTVC * vc = self.navigationController.childViewControllers[self.navigationController.childViewControllers.count - 2-1];
            [self.navigationController popToViewController:vc animated:YES];
        }    else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
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
