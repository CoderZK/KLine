//
//  zkNewsTVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/12.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkNewsTVC.h"
#import "zkNewsOneCell.h"
#import "zkSystemNotificationTVC.h"
#import "zkNewsPLThreeCell.h"
#import "zkNewsTwoCell.h"
#import "PopListView.h"
#import "zkReceiveSupportTVC.h"
#import "zkMessageModel.h"
#import "zkTieZiXiangQingTVC.h"
#import "zkPingLunXiangQingTVC.h"
@interface zkNewsTVC ()<PopListViewDelegate>
/**  */
@property(nonatomic,strong)PopListView *popListV;
/**  */
@property(nonatomic,strong)NSString *titleStr;
/** 注释 */
@property(nonatomic,assign)NSInteger selectDYIndex;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,assign)NSInteger pageNumber;
@property(nonatomic,strong)NSMutableArray *AllArr;
@property(nonatomic,strong)NSMutableArray *dingYueArr;
@property(nonatomic,strong)NSMutableArray *mineArr;
@property(nonatomic,strong)NSString *supportCount;
@property(nonatomic,strong)NSString *systemMsgCount;
@property(nonatomic,strong)NSMutableArray *dataArray;


@end

@implementation zkNewsTVC

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

//- (PopListView *)popListV {
//    if (_popListV == nil) {
//        _popListV = [[PopListView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
//    }
//    return _popListV;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleStr = @"全部";
    self.navigationItem.title = @"消息";
    self.type = self.pageNumber=1;
    [self.tableView registerNib:[UINib nibWithNibName:@"zkNewsOneCell" bundle:nil] forCellReuseIdentifier:@"zkNewsOneCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"zkNewsPLThreeCell" bundle:nil] forCellReuseIdentifier:@"zkNewsPLThreeCell"];
    [self.tableView registerClass:[zkNewsTwoCell class] forCellReuseIdentifier:@"zkNewsTwoCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self getNesList];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNumber = 1;
        [self getNesList];
    }];
//    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//
//    }];
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 2;
    }else if (section ==1) {
        return 1;
    }
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0){
      return 70;
    }else if (indexPath.section == 1) {
        return 44;
    }
    return 95;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        zkNewsOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkNewsOneCell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.numberStr = self.supportCount;
            cell.titleLB.text = @"收到的赞";
            cell.imgV.image = [UIImage imageNamed:@"like"];
        }else {
            cell.numberStr = self.systemMsgCount;
            cell.titleLB.text = @"系统通知";
            cell.imgV.image = [UIImage imageNamed:@"inform"];
            
        }
        return cell;
    }else if (indexPath.section == 1) {
       zkNewsPLThreeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkNewsPLThreeCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.rightBt addTarget:self action:@selector(clickRightBt:) forControlEvents:UIControlEventTouchUpInside];
        [cell.rightBt setTitle:self.titleStr forState:UIControlStateNormal];
        return cell;
    }else {
        zkNewsTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkNewsTwoCell" forIndexPath:indexPath];
        zkMessageModel * model = self.dataArray[indexPath.row];
        cell.model = model;
        return cell;
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //点击收到的赞
            zkReceiveSupportTVC * vc =[[zkReceiveSupportTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            //点击系统通知
            zkSystemNotificationTVC * vc =[[zkSystemNotificationTVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (indexPath.section == 2) {
        zkMessageModel * model = self.dataArray[indexPath.row];
        [self updateNewsWithModel:model];
        [self tiaoTiaoZhuanWithModel:model];
        
    }
    
    
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


//获取未读
- (void)getNesList{
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }
    
    [SVProgressHUD show];
    [zkRequestTool networkingGET:[zkURL getNewListURL] parameters:@{@"type":@(self.type)} success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            [SVProgressHUD dismiss];
            self.supportCount = [NSString stringWithFormat:@"%@",responseObject[@"result"][@"supportCount"]];
            self.systemMsgCount = [NSString stringWithFormat:@"%@",responseObject[@"result"][@"systemMsgCount"]];
            self.dataArray = [zkMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"userMsgDtoList"]];
            [self.tableView reloadData];
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];
    
}

//点击筛选
-(void)clickRightBt:(UIButton *)button {
    CGPoint point = self.tableView.contentOffset;
    self.popListV = [[PopListView alloc] initWithTitleArr:@[@"全部",@"订阅我的",@"只看楼主"]];
    self.popListV.delegate = self;
    [self.popListV showAtPoint:CGPointMake(ScreenW - 80 -15 , 180 +sstatusHeight + 44 - (point.y)) animation:YES];
    
}

#pragma  mark ---- 点击弹出框的代理 ----
-(void)PopListView:(PopListView *)view  didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray * arr = @[@"全部",@"订阅我的",@"只看楼主"];
    self.selectDYIndex = indexPath.row;
    self.type = indexPath.row + 1;
    self.titleStr = arr[indexPath.row];
    [self getNesList];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:(UITableViewRowAnimationFade)];
    
    
    
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
