//
//  zkOtherCerterTVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/13.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkOtherCerterTVC.h"
#import "zkOtherOneCell.h"
#import "zkOtherTwoCell.h"
#import "zkChiCangMingXiCell.h"
#import "zkJiaoYiChooseCell.h"
#import "zkShowMingXiCell.h"
#import "zkMoreOperationTVC.h"
#import "zkDingYueZhiFuOneTVC.h"
#import "zkOneBiZhongChiCangTVC.h"
#import "zkOtherCenterModel.h"
#import "zkPingLunWaiCell.h"
#import "zkOtherCenterFootView.h"
#import "zkMineFenSiTVC.h"
#import "zkOtherZiXuanTVC.h"
#import "zkBiZhongDetailTVC.h"
#import "zkTieZiXiangQingTVC.h"
@interface zkOtherCerterTVC ()<zkJiaoYiChooseCellDelegate,zkShowMingXiCellDelegate,zkPingLunWaiCellDelegate,zkOtherCenterFootViewDelegate,zkPingLunWaiCellDelegate>

/** 中间的持仓明细部分的  */
@property(nonatomic,assign)NSInteger type,type1,type2; //type 为交易明细用 type1 为订阅用 2为全部帖子用
@property(nonatomic,strong)UIButton *rightBt2;
@property(nonatomic,strong)zkOtherCenterModel *dataModel;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger pageNumber;
@property(nonatomic,strong)zkOtherCenterFootView *footV;

@end

@implementation zkOtherCerterTVC

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    self.type = self.type2 = self.type1 = 0;
    self.pageNumber = 1;
    [self.tableView registerNib:[UINib nibWithNibName:@"zkOtherOneCell" bundle:nil] forCellReuseIdentifier:@"zkOtherOneCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"zkOtherTwoCell" bundle:nil] forCellReuseIdentifier:@"zkOtherTwoCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"zkChiCangMingXiCell" bundle:nil] forCellReuseIdentifier:@"zkChiCangMingXiCell"];
    [self.tableView registerClass:[zkJiaoYiChooseCell class] forCellReuseIdentifier:@"zkJiaoYiChooseCell"];
       [self.tableView registerClass:[zkJiaoYiChooseCell class] forCellReuseIdentifier:@"zkJiaoYiChooseCell1"];
    [self.tableView registerClass:[zkJiaoYiChooseCell class] forCellReuseIdentifier:@"zkJiaoYiChooseCell2"];
    [self.tableView registerClass:[zkShowMingXiCell class] forCellReuseIdentifier:@"zkShowMingXiCell"];
    [self.tableView registerClass:[zkPingLunWaiCell class] forCellReuseIdentifier:@"zkPingLunWaiCell"];
     self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setFoot];
    
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        if ([self.dataModel.followFlag integerValue] == 0) {
            //未订阅
            [self getListWithType:4];
        }else {
           //订阅
            if (self.type2 == 0) {
               [self getListWithType:3];
            }else if (self.type2 == 1) {
               [self getListWithType:5];
            }else {
               [self getListWithType:6];
            }
        }
        
    }];
    
}

- (void)setFoot {
    self.footV = [[zkOtherCenterFootView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0.1)];
    self.footV.hidden = YES;
    self.footV.delegate = self;
    self.tableView.tableFooterView = self.footV;
}

- (void)setNav{
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 10, 35, 25);
    [right setImage:[UIImage imageNamed:@"nav_more2"] forState:UIControlStateNormal];
    [right setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentRight)];
    right.tag = 101;
    [right addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *right2 = [UIButton buttonWithType:UIButtonTypeCustom];
    right2.frame = CGRectMake(0, 10, 60, 25);
    right2.backgroundColor = BlueColor;
    [right2 setTitle:@"+订阅" forState:UIControlStateNormal];
    right2.titleLabel.font = kFont(13);
    right2.layer.shadowOffset = CGSizeMake(1, 2);
    right2.layer.shadowColor = BlueColor.CGColor;
    right2.layer.shadowOpacity = 0.8;
    self.rightBt2 = right2;
    self.rightBt2.hidden = YES;
//    [right2 setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentRight)];
    right2.tag = 102;
    [right2 addTarget:self action:@selector(dingYueAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIBarButtonItem * item1 = [[UIBarButtonItem alloc] initWithCustomView:right];
     UIBarButtonItem * item2 = [[UIBarButtonItem alloc] initWithCustomView:right2];
    self.navigationItem.rightBarButtonItems = @[item1,item2];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!self.dataModel) {
        return 0;
    }
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 5) {
        if ([self.dataModel.followFlag integerValue] == 0 && self.type1 == 1) {
            return 0;
        }
        return self.dataArray.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
    return 145;
    }else if (indexPath.section == 1) {
        return 210;
    }else if (indexPath.section == 2 || indexPath.section == 4) {
        return 50;
    }else if (indexPath.section == 3) {
        if ([self.dataModel.followFlag integerValue] == 1 || [self.dataModel.myHome integerValue] == 1) {
            if (self.type == 0) {
                if (self.dataModel.holdingCoinList.count == 0) {
                    return 0;
                }
                return self.dataModel.holdingCoinList.count > 4 ? 240:self.dataModel.holdingCoinList.count * 40 + 40 ;
               
            }else if (self.type == 1) {
                if (self.dataModel.unPayTradeList.count == 0) {
                    return 0;
                }
                return self.dataModel.unPayTradeList.count > 4 ? 240:self.dataModel.unPayTradeList.count*40+40;
               
            }else if (self.type == 2) {
                if (self.dataModel.historyTradeList.count == 0) {
                    return 0;
                }
                return self.dataModel.historyTradeList.count > 4 ? 240:self.dataModel.historyTradeList.count * 40 + 40;
               
            }else {
                if (self.dataModel.historyEntrustList.count == 0) {
                    return 0;
                }
                return self.dataModel.historyEntrustList.count > 4 ? 240:self.dataModel.historyEntrustList.count * 40 + 40 ;
            }
        }else {
            return 240;
        }
    }else if (indexPath.section == 5){
        if ([self.dataModel.followFlag integerValue] ==0 && self.type1 == 1) {
            return 100;
        }else {
            zkHomelModel * model = self.dataArray[indexPath.row];
            return model.cellHeight;
        }
        
        
    }
    return 100;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1 || section == 3 || section == 5) {
        return 0.01;
    }else {
        return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        zkOtherOneCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkOtherOneCell" forIndexPath:indexPath];
        [cell.dingYueBt addTarget:self action:@selector(dingYueAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.model = _dataModel;
        [cell.fenSiBt addTarget:self action:@selector(fansAndZixuanAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.ziXuanBt addTarget:self action:@selector(fansAndZixuanAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (indexPath.section == 1) {
        zkOtherTwoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkOtherTwoCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = _dataModel.statisticsDataResponse;
        return cell;
    }else if (indexPath.section == 2) {
        //选择的那一部分
        zkJiaoYiChooseCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkJiaoYiChooseCell" forIndexPath:indexPath];
        cell.dataArr = @[@"持仓明细",@"未成交",@"成交历史",@"历史委托"].mutableCopy;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }if (indexPath.section == 3) {
        //中间的明细部分
        zkShowMingXiCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkShowMingXiCell" forIndexPath:indexPath];
        cell.type = self.type;
        cell.model = _dataModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegete = self;
        [cell.moreBt addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }if (indexPath.section == 4) {
        //订阅 ,帖子的选择部分
        if ([self.dataModel.followFlag integerValue] == 1 || [self.dataModel.myHome integerValue] == 1)  {
            zkJiaoYiChooseCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkJiaoYiChooseCell2" forIndexPath:indexPath];
            cell.dataArr = @[@"全部",@"帖子",@"交易"].mutableCopy;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            return cell;
        }else {
            zkJiaoYiChooseCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkJiaoYiChooseCell1" forIndexPath:indexPath];
            cell.dataArr = @[@"精选内容",@"如何关注"].mutableCopy;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            return cell;
        }
    }else if (indexPath.section == 5) {
        //订阅说明 和 帖子
        
        if ([self.dataModel.followFlag integerValue] == 0 && self.type1 == 1) {
            zkChiCangMingXiCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkChiCangMingXiCell" forIndexPath:indexPath];
            return cell;
        }else {
            zkPingLunWaiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"zkPingLunWaiCell" forIndexPath:indexPath];
            cell.delegate = self;
            cell.type = 2;
            cell.headBt.tag = indexPath.row;
            [cell.headBt addTarget:self action:@selector(clickHeadAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.model = self.dataArray[indexPath.row];
            return cell;
            
        }
        
        
        
    }
    zkChiCangMingXiCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkChiCangMingXiCell" forIndexPath:indexPath];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 5) {
        
        __block  zkHomelModel * model = self.dataArray[indexPath.row];
        zkTieZiXiangQingTVC * vc =[[zkTieZiXiangQingTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        vc.ID = model.ID;
        vc.type = model.type;
        vc.getHomeModel = model;
        __weak typeof(self) weakSelf = self;
        vc.sendHomeBlock = ^(zkHomelModel *modelSend) {
            model = modelSend;
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
        };
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    
    
}


#pragma mark --- 点击粉丝或者他人的自选
- (void)fansAndZixuanAction:(UIButton *)button {
    if (button.tag == 100) {
        //点击的是粉丝
        zkMineFenSiTVC * vc =[[zkMineFenSiTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.userID = self.userID;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        //点击的是自选
        zkOtherZiXuanTVC * vc =[[zkOtherZiXuanTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.userID = self.userID;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    
}

//点击头像
- (void)clickHeadAction:(UIButton *)button {
    zkHomelModel * model = self.dataArray[button.tag];
    
    zkOtherCerterTVC * vc =[[zkOtherCerterTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.userID = model.createBy;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark ---- 点击持仓明细的cell -------
- (void)didSelectCell:(zkShowMingXiCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%@",indexPath);
    zkBTCChiYouModel * model = [[zkBTCChiYouModel alloc] init];
    if (self.type == 0) {
        model = self.dataModel.holdingCoinList[indexPath.row];
    }else if (self.type == 1) {
        model = self.dataModel.unPayTradeList[indexPath.row];
        return;
    }else if (self.type == 2) {
        model = self.dataModel.historyTradeList[indexPath.row];
    }else if (self.type == 3) {
        model = self.dataModel.historyEntrustList[indexPath.row];
        if ([model.status integerValue] == 1 || [model.status integerValue] == 3) {
            return;
        }
    }
    
    
    zkOneBiZhongChiCangTVC * vc =[[zkOneBiZhongChiCangTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    vc.hidesBottomBarWhenPushed = YES;
    vc.btcName = model.bitName;
    vc.userID = self.userID;
    [self.navigationController pushViewController:vc animated:YES];
    
//    NSArray * titleArr = @[@"持仓明细",@"未成交",@"成交历史",@"历史委托"];
//    NSMutableArray * vcsArr = @[].mutableCopy;
//    for (int i = 0 ; i < titleArr.count ; i++) {
//        zkMoreOperationTVC * tvc = [[zkMoreOperationTVC alloc] init];
//        tvc.type = i;
//        tvc.userID = self.userID;
//        [vcsArr addObject:tvc];
//    }
//    zkContrainTitlesFatherVC * vc =[[zkContrainTitlesFatherVC alloc] initFrame:self.view.bounds titleArr:titleArr vcsArr:vcsArr];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didSelectCheDanWithIndex:(NSInteger)index WithModel:(zkBTCChiYouModel *)model {
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"userId"] = self.userID;
    dict[@"orderid"] = model.ID;
    [SVProgressHUD show];
    [zkRequestTool networkingGET:[zkURL getTradeCancelURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            [SVProgressHUD showSuccessWithStatus:@"撤单成功"];
            [self.dataModel.historyTradeList removeObjectAtIndex:index];
            [self.tableView reloadData];
            
        } else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

#pragma mark --- 点击更多 ----
- (void)moreAction:(UIButton *)button {
    
    NSArray * titleArr = @[@"持仓明细",@"未成交",@"成交历史",@"历史委托"];
    NSMutableArray * vcsArr = @[].mutableCopy;
    for (int i = 0 ; i < titleArr.count ; i++) {
        zkMoreOperationTVC * tvc = [[zkMoreOperationTVC alloc] init];
        tvc.type = i;
        tvc.userID = self.userID;
        [vcsArr addObject:tvc];
    }
    zkContrainTitlesFatherVC * vc =[[zkContrainTitlesFatherVC alloc] initFrame:self.view.bounds titleArr:titleArr vcsArr:vcsArr];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark --- 点击持仓明细部分 -----
- (void)didClickChooseView:(zkJiaoYiChooseCell *)cell headIndex:(NSInteger)index isSmaeClick:(BOOL)isSame {
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.section == 2) {
        //持仓部分
        self.type = index;
        [self.tableView reloadData];
    }else {
        if ([self.dataModel.followFlag integerValue] == 1 || [self.dataModel.myHome integerValue] == 1) {
            //已经订阅
            self.type2 = index;
            self.pageNumber = 1;
            [self getData];
        }else {
            //未订阅
            self.type1 = index;
            if (index == 0) {
                self.footV.hidden = YES;
                self.footV.mj_h = 0;
                self.pageNumber = 1;
                [self getData];
            }else {
                self.footV.hidden  = NO;
                self.footV.model = self.dataModel;
                self.footV.mj_h = self.footV.footHeight;
                [self.tableView reloadData];
            }
            
        }
       
    }  
}

- (void)didClickChooseHeadIndex:(NSInteger)index isSmaeClick:(BOOL)isSame {

}

#pragma mark ---- 点击订阅 ---
- (void)dingYueAction:(UIButton *)button {
    
    zkDingYueZhiFuOneTVC * vc =[[zkDingYueZhiFuOneTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    __weak typeof(self) weakSelf = self;
    vc.sendDingYueBlock = ^{
        weakSelf.dataModel.followFlag = @"1";
        [weakSelf.tableView reloadData];
        weakSelf.rightBt2.hidden = YES;
    };
    vc.userID = self.userID;
    [self.navigationController pushViewController:vc animated:YES];
    
//    if ([self.dataModel.followFlag  integerValue] == 0) {
//        [self addDingYueAction];
//    }else {
//        zkDingYueZhiFuOneTVC * vc =[[zkDingYueZhiFuOneTVC alloc] init];
//        vc.hidesBottomBarWhenPushed = YES;
//        __weak typeof(self) weakSelf = self;
//        vc.sendDingYueBlock = ^{
//            weakSelf.dataModel.followFlag = @"1";
//            [weakSelf.tableView reloadData];
//            weakSelf.rightBt2.hidden = YES;
//        };
//        vc.userID = self.userID;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    
    
  
    
    
}
#pragma mark --- 点击右侧导航栏 (现在作为取消订阅处理) ----
- (void)navBtnClick:(UIButton *)button {
    if ([self.dataModel.myHome integerValue] == 1) {
        [SVProgressHUD showErrorWithStatus:@"是自己的主页,不能进行取消订阅"];
        return;
    }else if ([self.dataModel.followFlag integerValue] == 0) {
        [SVProgressHUD showErrorWithStatus:@"您还没有订阅此人,不能进行取消订阅"];
        return;
    }else if ([self.dataModel.followFlag integerValue] == 1) {
        
        [SVProgressHUD show];
        [zkRequestTool networkingPOST:[zkURL getCancelDingYueURL] parameters:@{@"followUserId":self.userID} success:^(NSURLSessionDataTask *task, id responseObject) {
            
            if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
                [SVProgressHUD showSuccessWithStatus:@"取消订阅成功"];
                self.dataModel.followFlag = @"0";
                zkOtherOneCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                if (self.tableView.contentOffset.y - 20 >=cell.dingYueBt.frame.origin.y) {
                    if ([self.dataModel.myHome integerValue] == 1 || [self.dataModel.followFlag integerValue] == 1) {
                        self.rightBt2.hidden = YES;
                    }else {
                        self.rightBt2.hidden = NO;
                    }
                    
                }else {
                    self.rightBt2.hidden = YES;
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
    
    
}

//获取详情
- (void)getData {
    
    [SVProgressHUD show];
    [zkRequestTool networkingGET:[zkURL getUserInfoHomeURL] parameters:@{@"followUserId":self.userID} success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
             [SVProgressHUD dismiss];
            self.dataModel = [zkOtherCenterModel mj_objectWithKeyValues:responseObject[@"result"]];
            [self.dataArray removeAllObjects];
            if ([self.dataModel.myHome integerValue] == 1 || [self.dataModel.followFlag integerValue] == 1) {
                //订阅或者是自己
                if(self.type2 == 0) {
                   self.dataArray =[NSMutableArray arrayWithArray:self.dataModel.allTopicList];
                }else if (self.type2 == 1) {
                   self.dataArray =[NSMutableArray arrayWithArray:self.dataModel.markeTopicList];
                }else {
                   self.dataArray =[NSMutableArray arrayWithArray:self.dataModel.tradeTopicList];
                }
            }else {
                self.dataArray =[NSMutableArray arrayWithArray:self.dataModel.hotTopicList];
            }
            if ([self.dataModel.myHome integerValue] == 1 || [self.dataModel.followFlag integerValue] == 1) {
                //是自己
                self.rightBt2.hidden = YES;
            }
            [self.tableView reloadData];
            self.pageNumber++;
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

//获取帖列表
- (void)getListWithType:(NSInteger )type {
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"pageNo"] = @(self.pageNumber);
    dict[@"type"] = @(type);
    dict[@"followUserId"] = self.userID;
    [SVProgressHUD show];
    [zkRequestTool networkingGET:[zkURL getTopicInfoListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
             [SVProgressHUD dismiss];
            NSMutableArray * arr  = [zkHomelModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"rows"]];
            [self.dataArray addObjectsFromArray:arr];
            [self.tableView reloadData];
            self.pageNumber++;
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




#pragma mark --- 点击cell点赞 ---
- (void)didClickZanRenYuanView:(zkPingLunWaiCell *)cell zanBt:(UIButton *)button index:(NSInteger)index {
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    zkHomelModel * model = self.dataArray[indexPath.row];
    if (index == -1) {
        //点赞
        [self zanAction:model IndexPath:indexPath];
        
    }else {
        //        //点击下面的点赞的人
        //        zkHomelModel * model = self.dataArray[indexPath.row];
        //        zkTieZiXiangQingTVC * vc =[[zkTieZiXiangQingTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        //        vc.ID = model.ID;
        //        vc.type = model.type;
        //        vc.hidesBottomBarWhenPushed = YES;
        //        [self.navigationController pushViewController:vc animated:YES];
        zkOtherCerterTVC * vc =[[zkOtherCerterTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        vc.userID = [model.supportUserIds componentsSeparatedByString:@","][index];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    
    
}

- (void)didClickXiaDanTableView:(zkPingLunWaiCell *)cell {
    
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    zkHomelModel * model = self.dataArray[indexPath.row];
    
    zkBiZhongDetailTVC * vc =[[zkBiZhongDetailTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    vc.hidesBottomBarWhenPushed = YES;
    zkBiModel * biM = [[zkBiModel alloc] init];
    biM.bitName = model.coinName;
    vc.model = biM;
    [self.navigationController pushViewController:vc animated:YES]; 
    
    
    
    
}

//点赞
- (void)zanAction:(zkHomelModel *)model IndexPath:(NSIndexPath *)indexPath{
    
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }
    if (model.supportFlag) {
        [SVProgressHUD showErrorWithStatus:@"不可以重复点赞"];
        return;
    }
    NSMutableDictionary * dict =@{}.mutableCopy;
    dict[@"topicId"] = model.ID;
    dict[@"type"] = @1;
    
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:[zkURL getAddZanURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
             [SVProgressHUD dismiss];
            model.supportNickNames = [[zkSignleTool shareTool].userInfoModel.nickName stringByAppendingString:[NSString stringWithFormat:@",%@",model.supportNickNames]];
            NSInteger  zanNumber = [model.supportCount integerValue] + 1;
            model.supportCount = [NSString stringWithFormat:@"%ld",zanNumber];
            model.supportUserIds =  [[zkSignleTool shareTool].userInfoModel.ID stringByAppendingString:[NSString stringWithFormat:@",%@",model.supportUserIds]];
            model.supportFlag = YES;
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

#pragma mark --- 点击如何关注的头像 ------
- (void)didclickZanheadWithIndex:(NSInteger)index {
    
    if (index < 20) {
     zkOtherCerterTVC * vc =[[zkOtherCerterTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
     vc.hidesBottomBarWhenPushed = YES;
     vc.userID = self.dataModel.supportHelper.fansUserIdList[index];
     [self.navigationController pushViewController:vc animated:YES];
    }else {
        
    }
     
}

#pragma mark --- 免费时的订阅 -----
- (void)addDingYueAction {
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"followUserId"] = self.userID;
    dict[@"money"] = @"0";
    dict[@"payType"] = @"1";
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:[zkURL getAddDingYueURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            [SVProgressHUD dismiss];
            
            [self getData];
            
        }   else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //可以更具字的多少计算
    zkOtherOneCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSLog(@"----\==\n%lf",cell.dingYueBt.frame.origin.y);
    
     NSLog(@"++%lf\n",scrollView.contentOffset.y);
    
    if (scrollView.contentOffset.y - 20 >=cell.dingYueBt.frame.origin.y) {
        if ([self.dataModel.myHome integerValue] == 1 || [self.dataModel.followFlag integerValue] == 1) {
             self.rightBt2.hidden = YES;
        }else {
           self.rightBt2.hidden = NO;
        }
        
    }else {
        self.rightBt2.hidden = YES;
    }
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
