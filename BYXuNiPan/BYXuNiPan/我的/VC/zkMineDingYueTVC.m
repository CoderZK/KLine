//
//  zkMineDingYueTVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/17.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkMineDingYueTVC.h"
#import "zkNiuRenBangCell.h"
@interface zkMineDingYueTVC ()
@property(nonatomic,strong)NSArray<UIColor *> *colorArr;
@property(nonatomic,assign)NSInteger pageNumber;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation zkMineDingYueTVC

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.colorArr = @[RGB(236, 78, 71),RGB(255, 128, 39),RGB(95, 74, 207)];
    self.navigationItem.title = @"关注的人";
    [self.tableView registerClass:[zkNiuRenBangCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.pageNumber = 1;
    [self getList];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNumber = 1;
        [self getList];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getList];
    }];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 240;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    zkNiuRenBangCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.row < 3) {
        cell.headBt.layer.borderWidth = 2;
        cell.headBt.layer.borderColor = self.colorArr[indexPath.row].CGColor;
        cell.imgV.hidden = NO;
        cell.imgV.image = [UIImage imageNamed:[NSString stringWithFormat:@"ranking%ld",(long)indexPath.row]];
    }else {
        cell.imgV.hidden = YES;
        cell.headBt.layer.borderWidth = 0;
    }
    cell.headBt.tag = indexPath.row;
    [cell.headBt addTarget:self action:@selector(clickHead:) forControlEvents:UIControlEventTouchUpInside];
    zkBtcRankModel * model = self.dataArray[indexPath.row];
    cell.model = model.rankListResponse;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    zkBtcRankModel * model = self.dataArray[indexPath.row];
    zkOtherCerterTVC * vc =[[zkOtherCerterTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.userID = model.userId;
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}

- (void)clickHead:(UIButton *)button {
    
    zkBtcRankModel * model = self.dataArray[button.tag];
    zkOtherCerterTVC * vc =[[zkOtherCerterTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.userID = model.userId;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)getList {
    
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"pageNo"] = @(self.pageNumber);
    dict[@"followMe"] = @"0";
    dict[@"userId"] = self.userID;
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:[zkURL getUserFollowURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
             [SVProgressHUD dismiss];
            NSArray * arr = [zkBtcRankModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"rows"]];
            if (self.pageNumber == 1) {
                [self.dataArray removeAllObjects];
                if (arr.count == 0 ) {
                    [SVProgressHUD showSuccessWithStatus:@"暂无数据"];
                }
            }
            [self.dataArray addObjectsFromArray:arr];
            [self.tableView reloadData];
            self.pageNumber++;
        } else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
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
