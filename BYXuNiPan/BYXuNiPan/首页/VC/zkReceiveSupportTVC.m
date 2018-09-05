//
//  zkReceiveSupportTVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/13.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkReceiveSupportTVC.h"
#import "zkNewsTwoCell.h"
#import "zkMessageModel.h"
#import "zkTieZiXiangQingTVC.h"
#import "zkPingLunXiangQingTVC.h"
@interface zkReceiveSupportTVC ()
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation zkReceiveSupportTVC
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收到的赞";
    
    [self.tableView registerClass:[zkNewsTwoCell class] forCellReuseIdentifier:@"zkNewsTwoCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self getNesList];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getNesList];
    }];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    zkNewsTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkNewsTwoCell" forIndexPath:indexPath];
    zkMessageModel * model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    zkMessageModel * model = self.dataArray[indexPath.row];
    [self updateNewsWithModel:model];
    [self tiaoTiaoZhuanWithModel:model];

    
    
}


//点击跳转
- (void)tiaoTiaoZhuanWithModel:(zkMessageModel *)model {
    if (model.topicId.length != 0 && ![model.topicId isEqualToString:@"0"]) {
        //跳转到帖子详情
        zkTieZiXiangQingTVC * vc =[[zkTieZiXiangQingTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        vc.ID = model.topicId;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        
        zkPingLunXiangQingTVC * vc =[[zkPingLunXiangQingTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        vc.hidesBottomBarWhenPushed = YES;
        vc.pingLunID = model.replyId;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
}

//更新消息属性
- (void)updateNewsWithModel:(zkMessageModel *)model {
    
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:[zkURL getUserMsgDoReadURL] parameters:@{@"ids":model.ID} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
             [SVProgressHUD dismiss];
            model.readFlag = YES;
            [self.tableView reloadData];
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}


- (void)getNesList{
    
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }

    
    NSString * url = [NSString stringWithFormat:@"%@%@%@",[zkURL getUserMsgListURL],@"/",@"2"];
    [zkRequestTool networkingGET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
             [SVProgressHUD dismiss];
            self.dataArray = [zkMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            [self.tableView reloadData];
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
