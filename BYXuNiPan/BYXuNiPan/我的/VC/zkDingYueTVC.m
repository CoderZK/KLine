//
//  zkDingYueTVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/17.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkDingYueTVC.h"
#import "zkSettingCell.h"
#import "zkDingYueSettingVC.h"
#import "zkDingYueJieShaoTVC.h"
#import "zkErWeiMaTVC.h"
#import "zkErWeiMaModel.h"
@interface zkDingYueTVC ()
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,assign)BOOL isShouFei;
@property(nonatomic,strong)IQTextView *textV;

@end

@implementation zkDingYueTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isShouFei = YES;
    self.navigationItem.title = @"订阅设置";
    self.titleArr = @[@"订阅收费",@"人民币价格",@"收款二维码",@"LXC定价"];
    [self.tableView registerNib:[UINib nibWithNibName:@"zkSettingCell" bundle:nil] forCellReuseIdentifier:@"cell"];

    [self setFoofView];
    
    [self  getDingYueDetail];
    
}

- (void)setFoofView {
    
     UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel * lb =[[UILabel alloc] initWithFrame:CGRectMake(15, 15 , 100, 20)];
    lb.font =[UIFont systemFontOfSize:15];
    lb.textColor = CharacterBlackColor30;
    lb.text = @"订阅介绍";
    [view addSubview:lb];
    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(ScreenW - 15 - 40, 15, 40, 20);
    [button setTitle:@"编辑" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:BlueColor forState:UIControlStateNormal];
    button.layer.cornerRadius = 0;
    button.clipsToBounds = YES;
    [button addTarget:self action:@selector(editAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    self.textV = [[IQTextView alloc] initWithFrame:CGRectMake(8, 50, ScreenW - 16, 150)];
    self.textV.font = [UIFont systemFontOfSize:14];
    self.textV.placeholder = @"请编辑订阅介绍";
    self.textV.userInteractionEnabled = NO;
    [view addSubview:self.textV];
    self.tableView.tableFooterView = view;
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
}

- (void)editAction {
    
    zkDingYueJieShaoTVC * vc =[[zkDingYueJieShaoTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    __weak typeof(self) weakSelf = self;
    vc.sendJieShaoBlock = ^(NSString *jieShaoStr) {
        weakSelf.model.profile = jieShaoStr;
        weakSelf.textV.text = jieShaoStr;
        [weakSelf UpdateDingYueSetting];
    };
    [self.navigationController pushViewController:vc animated:YES];}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2 || indexPath.row == 1) {
        return 0;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    zkSettingCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.clipsToBounds = YES;
    cell.leftLB.text = self.titleArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.swiftOn.hidden = NO;
        cell.rightLB.hidden = YES;
        cell.rightImageV.hidden = YES;
        cell.swiftOn.userInteractionEnabled = NO;
        cell.swiftOn.on = self.isShouFei;
        cell.leftLB.textColor = CharacterBlackColor30;
    }else {
        cell.rightLB.hidden = NO;
        cell.rightImageV.hidden = NO;
         cell.swiftOn.hidden = YES;
        if (!self.isShouFei) {
            cell.leftLB.textColor = CharacterBackColor153;
            cell.userInteractionEnabled = NO;
        }else {
            cell.leftLB.textColor = CharacterBlackColor30;
            cell.userInteractionEnabled = YES;
        }
        if (indexPath.row == 1) {
            cell.rightLB.text = [NSString stringWithFormat:@"￥%@",self.model.price];
        }else if (indexPath.row == 2){
            if ([self.model.qrCodeCount integerValue] == 0) {
                cell.rightLB.text = @"未设置";
            }else {
                cell.rightLB.text = @"查看修改";
            }
        }else {
             cell.rightLB.text = [NSString stringWithFormat:@"￥%@LXC",self.model.lxcPrice];
        }
        
        
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        self.isShouFei =! self.isShouFei;
        [self.tableView reloadData];
        [self UpdateDingYueSetting];
    }else if (indexPath.row == 1 | indexPath.row == 3) {
        
        zkDingYueSettingVC * vc =[[zkDingYueSettingVC alloc] init];
        if (indexPath.row == 0) {
            vc.titleStr = self.model.price;
        }else {
            vc.titleStr = self.model.lxcPrice;
        }
        __weak typeof(self) weakSelf = self;
        vc.sendBlcok = ^(NSString *str) {
            if (indexPath.row == 1) {
                weakSelf.model.price = str;
            }else {
                weakSelf.model.lxcPrice = str;
            }
            [weakSelf UpdateDingYueSetting];
        };
        vc.type = indexPath.row;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2) {
        zkErWeiMaTVC * vc =[[zkErWeiMaTVC alloc] init];
        vc.dingYueTvc = self;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


//获取订阅的详情
- (void)getDingYueDetail {
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }
    [SVProgressHUD show];
    [zkRequestTool networkingGET:[zkURL getUserSetUpDetailURL] parameters:@{@"userId":[zkSignleTool shareTool].userInfoModel.ID} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
             [SVProgressHUD dismiss];
            self.model = [zkErWeiMaModel  mj_objectWithKeyValues:responseObject[@"result"]];
            self.isShouFei = !self.model.freeFlag;
            self.textV.text = self.model.profile;
            [self.tableView reloadData];
            
            
            
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}

- (void)UpdateDingYueSetting {
    
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }

    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"freeFlag"] = @(!self.isShouFei);
    dict[@"lxcPrice"] = self.model.lxcPrice;
    dict[@"price"] = self.model.price;
    dict[@"profile"] = self.model.profile;
    dict[@"userId"] = [zkSignleTool shareTool].userInfoModel.ID;
    [SVProgressHUD show];
    [zkRequestTool networkingJsonPOST:[zkURL getUserSetUpUpdateURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
             [SVProgressHUD dismiss];
            [self.tableView reloadData];
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
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
