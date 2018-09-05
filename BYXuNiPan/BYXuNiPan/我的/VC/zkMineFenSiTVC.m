//
//  zkMineFenSiTVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/17.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkMineFenSiTVC.h"
#import "zkSettingTwoCell.h"
#import "zkBtcRankModel.h"
//#import "zkOtherCerterTVC.h"
@interface zkMineFenSiTVC ()
@property(nonatomic,assign)NSInteger pageNumber;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation zkMineFenSiTVC

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNumber = 1;
    self.navigationItem.title = @"我的粉丝";
    if (![self.userID isEqualToString:[zkSignleTool shareTool].userInfoModel.ID]) {
        self.navigationItem.title = @"他的粉丝";
    }
    if (self.isZan) {
       self.navigationItem.title = @"点赞列表";
    }
    [self.tableView registerNib:[UINib nibWithNibName:@"zkSettingTwoCell" bundle:nil] forCellReuseIdentifier:@"zkSettingTwoCell"];
    
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
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    zkSettingTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkSettingTwoCell" forIndexPath:indexPath];
    cell.type = 1;
    zkBtcRankModel * model = self.dataArray[indexPath.row];
    [cell.leftImageV sd_setImageWithURL:[NSURL URLWithString: model.userPic] placeholderImage:[UIImage imageNamed:@"369"] options:SDWebImageRetryFailed];
    cell.leftLB.text = model.nickName;
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

- (void)getList {
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }
    NSString * urlStr = [zkURL getUserFollowURL];
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"pageNo"] = @(self.pageNumber);
    dict[@"followMe"] = @"1";
    dict[@"userId"] = self.userID;
    if (self.isZan) {
        dict[@"topicId"] = self.topicID;
        dict[@"type"] = @1;
        urlStr = [zkURL gettopicSupportListURL];
        [SVProgressHUD show];
        [zkRequestTool networkingGET:urlStr parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
            [self.tableView.mj_footer endRefreshing];
            [self.tableView.mj_header endRefreshing];
            if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
                
                [SVProgressHUD dismiss];
                NSArray * arr = [zkBtcRankModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"rows"]];
                if (self.pageNumber == 1) {
                    [self.dataArray removeAllObjects];
                }
                [self.dataArray addObjectsFromArray:arr];
                if (self.dataArray.count == 0) {
                    [SVProgressHUD showSuccessWithStatus:@"赞无数据"];
                }
                [self.tableView reloadData];
            }    else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
                [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
            }else {
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [self.tableView.mj_footer endRefreshing];
            [self.tableView.mj_header endRefreshing];
        }];
        
    }else {
        
        [SVProgressHUD show];
        [zkRequestTool networkingPOST:urlStr parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
            [self.tableView.mj_footer endRefreshing];
            [self.tableView.mj_header endRefreshing];
            if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
                
                [SVProgressHUD dismiss];
                NSArray * arr = [zkBtcRankModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"rows"]];
                if (self.pageNumber == 1) {
                    [self.dataArray removeAllObjects];
                }
                [self.dataArray addObjectsFromArray:arr];
                if (self.dataArray.count == 0) {
                    [SVProgressHUD showSuccessWithStatus:@"赞无数据"];
                }
                [self.tableView reloadData];
            }    else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
                [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
            }else {
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [self.tableView.mj_footer endRefreshing];
            [self.tableView.mj_header endRefreshing];
        }];
        
    }
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
