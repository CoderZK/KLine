//
//  zkTieZiSearchResultTVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/16.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkTieZiSearchResultTVC.h"
#import "zkSettingTwoCell.h"
#import "zkSearchJiaoYiCell.h"
#import "zkSearchTieZiCell.h"
#import "zkSearchModel.h"
#import "zkTieZiXiangQingTVC.h"
@interface zkTieZiSearchResultTVC ()

@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation zkTieZiSearchResultTVC

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"zkSettingTwoCell" bundle:nil] forCellReuseIdentifier:@"zkSettingTwoCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"zkSearchJiaoYiCell" bundle:nil] forCellReuseIdentifier:@"zkSearchJiaoYiCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"zkSearchTieZiCell" bundle:nil] forCellReuseIdentifier:@"zkSearchTieZiCell"];
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - sstatusHeight - 44);
    if (sstatusHeight == 44) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - sstatusHeight - 44 - 34 );
    }
    
    
    self.pageNumber = 1;
    if (self.searchStr.length != 0) {
        [self searchWithStr:self.searchStr type:self.type BoolIsSearchOne:YES];
    }

    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNumber = 1;
        [self searchWithStr:self.searchStr type:self.type BoolIsSearchOne:YES];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self searchWithStr:self.searchStr type:self.type BoolIsSearchOne:NO];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type == 1) {
        return 90;
    }else if (self.type == 2) {
        return 124;
    }
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type == 1) {
        zkSearchModel * model = self.dataArray[indexPath.row];
        zkSearchTieZiCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkSearchTieZiCell" forIndexPath:indexPath];
       
        if (indexPath.row %2 == 0) {
            cell.contentLB.text = @"奇偶的飞洒老股民了;费国际饭店";
        }else {
            cell.contentLB.text = @"奇偶的飞洒老股偶的飞洒老股民了偶的飞洒老股民了偶的飞洒老股民了偶的飞洒老股民了偶的飞洒老股民了民了费国际饭店";
        }
        cell.headBt.tag = indexPath.row;
        [cell.headBt addTarget:self action:@selector(headClickAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.model = model;
        return cell;
    }else if (self.type == 2){
        zkSearchJiaoYiCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkSearchJiaoYiCell" forIndexPath:indexPath];
         cell.headBt.tag = indexPath.row;
        [cell.headBt addTarget:self action:@selector(headClickAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.model = self.dataArray[indexPath.row];
        return cell;
    }else {
        zkSearchModel * model = self.dataArray[indexPath.row];
        zkSettingTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkSettingTwoCell" forIndexPath:indexPath];
        cell.type = 1;
        cell.headBt.tag = indexPath.row;
        [cell.leftImageV sd_setImageWithURL:[NSURL URLWithString:model.createByUserPic] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
        [cell.headBt addTarget:self action:@selector(headClickAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.leftLB.text = model.createByNickName;
        return cell;
    }

    
}

- (void)headClickAction:(UIButton *)button {
    
    zkOtherCerterTVC * vc =[[zkOtherCerterTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    zkSearchModel * model = self.dataArray[button.tag];
    vc.userID = model.createBy;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.type == 3) {
        //用户
        zkSearchModel  * model = self.dataArray[indexPath.row];
        zkOtherCerterTVC * vc =[[zkOtherCerterTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        vc.hidesBottomBarWhenPushed = YES;
        vc.userID = model.createBy;
        [self.navigationController pushViewController:vc animated:YES]; 
    } else {
        
        zkSearchModel  * model = self.dataArray[indexPath.row];
         zkTieZiXiangQingTVC* vc =[[zkTieZiXiangQingTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        vc.hidesBottomBarWhenPushed = YES;
        vc.ID = model.topicId;
        [self.navigationController pushViewController:vc animated:YES]; 
    }
        
    
    
    
    
}

- (void)searchWithStr:(NSString *)searchStr type:(NSInteger )type BoolIsSearchOne:(BOOL)isOne{
    
    if (isOne) {
        self.pageNumber = 1;
    }
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"pageNo"] = @(self.pageNumber);
    dict[@"type"] = @(type);
    dict[@"keywords"] = searchStr;
    
    [SVProgressHUD show];
    [zkRequestTool networkingGET:[zkURL getSearchURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
             [SVProgressHUD dismiss];
            NSArray *arr = [zkSearchModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"rows"]];
            if (self.pageNumber == 1) {
                [self.dataArray removeAllObjects];
                if (arr.count == 0 ) {
                    [SVProgressHUD showSuccessWithStatus:@"暂无数据"];
                }
            }
            [self.dataArray addObjectsFromArray:arr];
            [self.tableView reloadData];
            self.pageNumber++;
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];
    
    
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
