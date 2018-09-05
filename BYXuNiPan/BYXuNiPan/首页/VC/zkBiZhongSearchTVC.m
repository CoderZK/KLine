//
//  zkBiZhongSearchTVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/16.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkBiZhongSearchTVC.h"
#import "zkBizhongSearchView.h"
#import "zkSearchView.h"
#import "zkSearchBiZhongCell.h"
#import "zkBiModel.h"
#import "zkBiZhongDetailTVC.h"
@interface zkBiZhongSearchTVC ()<UITextFieldDelegate,zkBizhongSearchViewDelegate>
@property(nonatomic,strong)zkBizhongSearchView *biZhongSearchV;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)zkSearchView *seachV;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation zkBiZhongSearchTVC

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"zkSearchBiZhongCell" bundle:nil] forCellReuseIdentifier:@"zkSearchBiZhongCell"];
   
    
    [self setRightNavItem];
    
}

- (void)setRightNavItem {
    
    self.dataArr = [NSMutableArray arrayWithArray:[zkSignleTool shareTool].serachBiZhong];
    self.biZhongSearchV = [[zkBizhongSearchView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    [self.view addSubview:self.biZhongSearchV];
    self.biZhongSearchV.backgroundColor = WhiteColor;
    self.biZhongSearchV.delegate = self;
    self.biZhongSearchV.dataArr =self.dataArr;
    
    zkSearchView * searchV = [[zkSearchView alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 80, 26)];
    searchV.textTF.placeholder = @"搜做币种";
    searchV.textTF.delegate = self;
    self.seachV = searchV;
    self.navigationItem.titleView = searchV;
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(ScreenW - 35 - 10, sstatusHeight + 5.5, 35, 35);
    right.titleLabel.font = kFont(14);
    [right setTitleColor:CharacterBlackColor30 forState:UIControlStateNormal];
    [right setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentRight)];
    [right setTitle:@"取消" forState:UIControlStateNormal];
    right.tag = 100;
    [right addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    zkSearchBiZhongCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkSearchBiZhongCell" forIndexPath:indexPath];
  
    zkBiModel *model = self.dataArray[indexPath.row];
    if ([model.isAdd isEqualToString:@"no"]) {
        [cell.rightBt setImage:[UIImage imageNamed:@"star_n"] forState:UIControlStateNormal];
    }else {
        [cell.rightBt setImage:[UIImage imageNamed:@"star_p"] forState:UIControlStateNormal];
    }
      cell.titleLB.text = [NSString stringWithFormat:@"%@(%@)",[model.baseCurrency uppercaseString],model.cnName];
    cell.rightBt.tag = indexPath.row;
    [cell.rightBt addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    zkBiModel * model = self.dataArray[indexPath.row];
    zkBiZhongDetailTVC* vc =[[zkBiZhongDetailTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    model.bitName = model.baseCurrency;
    vc.model = model;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES]; 
}

//点击加入自选和
- (void)clickAction:(UIButton *)button {
    
    zkBiModel * model = self.dataArray[button.tag];
    
    NSString * url = [zkURL getAddMyBitURL];
    if ([model.isAdd isEqualToString:@"yes"]) {
        url = [zkURL getDeleMyBitURL];
    }
    
    [SVProgressHUD show];
    [zkRequestTool networkingGET:url parameters:@{@"bitNames":model.baseCurrency,@"deviceId":deviceID} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            [SVProgressHUD dismiss];
            if ([model.isAdd isEqualToString:@"no"]) {
                [SVProgressHUD showSuccessWithStatus:@"添加自选成功"];
                 model.isAdd = @"yes";
            }else {
                [SVProgressHUD showSuccessWithStatus:@"去除自选成功"];
                 model.isAdd = @"no";
            }
           
            [self.tableView reloadData];
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
    
}


#pragma mark -textfield代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length > 0) {
        BOOL isHave = NO;
        for (NSString *str in _dataArr) {
            if ([self.seachV.textTF.text isEqualToString:str]) {
                
                isHave = YES;
            }
        }
        if (!isHave) {
            [_dataArr insertObject:textField.text atIndex:0];
        }
        
        if (_dataArr.count > 20) {
            [_dataArr removeLastObject];
        }
        [zkSignleTool shareTool].serachBiZhong = [NSMutableArray arrayWithArray:_dataArr];
        self.biZhongSearchV.dataArr = _dataArr;
        self.biZhongSearchV.hidden = YES;
        [self searchBiZhong:textField.text];
        return YES;
    }else {
        [SVProgressHUD showErrorWithStatus:@"请输入搜索内容"];
        return NO;
    }
}



//是否是输入框没有内容了
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if(string.length == 0) {
        
        if (textField.text.length - range.length == 0) {
            
            self.biZhongSearchV.hidden = NO;
        }
        
    }
    return YES;
}
#pragma Mark --- 点击搜索的历史 ---
- (void)didClickBiZhongWithStr:(NSString *)searchStr {
    self.biZhongSearchV.hidden = YES;
    [self searchBiZhong:searchStr];
}

//搜索币种
- (void)searchBiZhong:(NSString *)name {
    
    [SVProgressHUD show];
    [zkRequestTool networkingGET:[zkURL getSelectBitURL] parameters:@{@"bitName":name,@"deviceId":deviceID} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            [SVProgressHUD dismiss];
            self.dataArray = [zkBiModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            [self.tableView reloadData];
            if (self.dataArray.count == 0) {
                [SVProgressHUD showSuccessWithStatus:@"搜索结果为空"];
            }
            
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

#pragma mark --- 点击取消 ----
- (void)rightAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
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
