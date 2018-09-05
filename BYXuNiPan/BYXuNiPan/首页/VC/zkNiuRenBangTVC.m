//
//  zkNiuRenBangTVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/13.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkNiuRenBangTVC.h"
#import "zkNiuRenBangCell.h"
#import "zkBtcRankModel.h"
//#import "zkOtherCerterTVC.h"
@interface zkNiuRenBangTVC ()<zkContrainTitlesVCDelegate>
/**  */
@property(nonatomic,strong)NSArray<UIColor *> *colorArr;
@property(nonatomic,strong)NSMutableArray<zkBtcRankModel *> *dataArray;
@property(nonatomic,assign)NSInteger pageNumber;
@end

@implementation zkNiuRenBangTVC

- (NSMutableArray<zkBtcRankModel *> *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.colorArr = @[RGB(236, 78, 71),RGB(255, 128, 39),RGB(95, 74, 207)];
    
    self.pageNumber = 1;
    [self GetNiuRenList];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNumber = 1;
        [self GetNiuRenList];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self GetNiuRenList];
    }];

//    [self.tableView registerClass:[zkNiuRenBangCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
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
    
    zkNiuRenBangCell * cell = [[zkNiuRenBangCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell1"];
//    if (!cell ) {
//        cell = [[zkNiuRenBangCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell1"];
//    }
    cell.headBt.userInteractionEnabled = NO;
    if (indexPath.row < 3) {
        cell.headBt.layer.borderWidth = 2;
        cell.headBt.layer.borderColor = self.colorArr[indexPath.row].CGColor;
        NSString * str = [NSString stringWithFormat:@"ranking%ld",(long)indexPath.row];
           cell.imgV.hidden = NO;
        cell.imgV.image = [UIImage imageNamed:str];
    
    }else {
        cell.headBt.layer.borderWidth = 0;
        cell.imgV.hidden = YES;
    }
    cell.model = self.dataArray[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    zkOtherCerterTVC * vc =[[zkOtherCerterTVC alloc] init];
    zkBtcRankModel * model = self.dataArray[indexPath.row];
    vc.userID = model.userId;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark --- 点击导航栏的透视图 ----- 
- (void)didSelectTopTitleButton:(UIButton *)button index:(NSInteger)index isSame:(BOOL)isSame {
    
    NSLog(@"%@",@"1254");

}


//获取牛人版
- (void)GetNiuRenList {
    [SVProgressHUD show];
    
    NSMutableDictionary *dict =@{}.mutableCopy;
    if (self.type == 0) {
     dict[@"type"] = @(3);
    }else if (self.type == 1) {
        dict[@"type"] = @(2);
    }else {
        dict[@"type"] = @(1);
    }
    
    dict[@"pageNo"] = @(self.pageNumber);
    
    [zkRequestTool networkingGET:[zkURL getTradeRankListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            [SVProgressHUD dismiss];
            NSArray * arr  = [zkBtcRankModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"rows"]];
            if (self.pageNumber == 1) {
                [self.dataArray removeAllObjects];
            }
            
            [self.dataArray addObjectsFromArray:arr];
            self.pageNumber++;
            [self.tableView reloadData];
            
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
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
