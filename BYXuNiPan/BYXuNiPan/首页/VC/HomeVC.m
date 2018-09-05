//
//  HomeVC.m
//  BYXuNiPan
//
//  Created by kunzhang on 2018/7/2.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "HomeVC.h"
#import "zkLoginVC.h"
#import "MineVC.h"
#import "zkHomeOneCell.h"
#import "zkHomeLeftNavV.h"
#import "zkHomeTwoCell.h"
#import "zkLunBoCell.h"
#import "zkNewsTVC.h"
#import "zkNiuRenBangTVC.h"
#import "zkFatieTVC.h"
#import "zkPingLunWaiCell.h"
#import "zkTieZiXiangQingTVC.h"
#import "zkHomelModel.h"
#import "GCDSocketManager.h"
#import "zkBannerModel.h"
#import "zkBtcRankModel.h"
#import "zkYiJianFanKuiDetailVC.h"
#import "zkNewSearchVC.h"
@interface HomeVC ()<UITabBarControllerDelegate,zkHomeOneCellDelegate,zkHomeLeftNavVDelegate,zkLunBoCellDelegate,zkPingLunWaiCellDelegate,zkHomeTwoCellDelegate>
@property(nonatomic,strong)UIButton *messageBt;
@property(nonatomic,assign)BOOL isTuiJian;
@property(nonatomic,strong)zkHomeLeftNavV *navLeftV;
@property(nonatomic,strong)NSMutableArray<zkHomelModel *> *dataArray;
@property(nonatomic,strong)NSMutableArray<zkBannerModel *> *bannerDataArr;
@property(nonatomic,strong)NSMutableArray<zkBtcRankModel *> *niuRenBangArr;
@property(nonatomic,assign)NSInteger pageNumber;
@property(nonatomic,assign)NSInteger type;
@end

@implementation HomeVC
- (NSMutableArray<zkHomelModel *> *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSMutableArray<zkBannerModel *> *)bannerDataArr {
    if (_bannerDataArr == nil) {
        _bannerDataArr = [NSMutableArray array];
    }
    return _bannerDataArr;
}
- (NSMutableArray<zkBtcRankModel *> *)niuRenBangArr {
    if (_niuRenBangArr == nil) {
        _niuRenBangArr = [NSMutableArray array];
    }
    return _niuRenBangArr;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"HomeVC"];
    [MobClick event:@"home1"];
    [self.tableView reloadData];
    
    
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"HomeVC"];
}





- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNumber = 1;
    self.type = 2;
    self.isTuiJian = YES;
    self.tabBarController.delegate = self;
    [self.tableView registerClass:[zkHomeOneCell class] forCellReuseIdentifier:@"cell1"];
     [self.tableView registerClass:[zkHomeTwoCell class] forCellReuseIdentifier:@"cell2"];
    [self.tableView registerClass:[zkLunBoCell class] forCellReuseIdentifier:@"zkLunBoCell"];
    [self.tableView registerClass:[zkPingLunWaiCell class] forCellReuseIdentifier:@"zkPingLunWaiCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self setRightAndLeftNavbar];
    [self getListWithType:self.type];
    [self GetbannerList];
    [self GetNiuRenList];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNumber = 1;
        [self GetbannerList];
        [self getListWithType:self.type];
        [self GetNiuRenList];
    }];
   
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
         [self getListWithType:self.type];
    }];
    
//    [[GCDSocketManager sharedSocketManager] connectToServer];
    
}

//设置右侧导航栏
- (void)setRightAndLeftNavbar{
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 10, 35, 35);
    [right setImage:[UIImage imageNamed:@"nav_search"] forState:UIControlStateNormal];
    [right setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentRight)];
    right.tag = 101;
    [right addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:right];
    
    UIButton *right1 = [UIButton buttonWithType:UIButtonTypeCustom];
    right1.frame = CGRectMake(0, 10, 40, 35);
    [right1 setImage:[UIImage imageNamed:@"post"] forState:UIControlStateNormal];
    right1.tag = 102;
    [right1 addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.messageBt = right1;
    UIBarButtonItem * item1 =[[UIBarButtonItem alloc] initWithCustomView:right];
    UIBarButtonItem * item2 =[[UIBarButtonItem alloc] initWithCustomView:right1];
    
    UIButton * button3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    UIBarButtonItem * item3 =[[UIBarButtonItem alloc] initWithCustomView:button3];
    
    self.navigationItem.rightBarButtonItems =@[item2,item1];
    
    
    zkHomeLeftNavV * leftV = [[zkHomeLeftNavV alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    leftV.delegate = self;
    self.navLeftV = leftV;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftV];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.isTuiJian && (section == 0 || section == 1)) {
        return 0.01;
    }
    return 15;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 1;
    }
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
//         return ScreenW * Scale;
        return ScreenW / 2;
    }else   if (indexPath.section == 1){
        return 45 + ((ScreenW - 10 * 4)/3 * (90/105.0)) + 40  + 10;
        
    }else  {
        return self.dataArray[indexPath.row].cellHeight;
    }
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {

        zkLunBoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"zkLunBoCell" forIndexPath:indexPath];
        NSMutableArray * arr = @[].mutableCopy;
        for (zkBannerModel * model  in self.bannerDataArr) {
            [arr addObject:model.img];
        }
        cell.dataArr = arr;
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1) {
        zkHomeTwoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.dataArr = self.niuRenBangArr;
        cell.delegate = self;
        [cell.moreBt addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2) {
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

//点击头像
- (void)clickHeadAction:(UIButton *)button {
    zkHomelModel * model = self.dataArray[button.tag];
    
    zkOtherCerterTVC * vc =[[zkOtherCerterTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.userID = model.createBy;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark --- 点击第一去cell的代理 ----
- (void)didSelectWithindex:(NSInteger)index {
   
    
}

#pragma  mark --- 点击牛人榜的代理 ---
- (void)didClickNiuRenWithIndex:(NSInteger)index {
    zkBtcRankModel * model = self.niuRenBangArr[index];
    
    zkOtherCerterTVC * vc =[[zkOtherCerterTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    vc.hidesBottomBarWhenPushed = YES;
    vc.userID = model.userId;
    [self.navigationController pushViewController:vc animated:YES];  
    
}


- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    BaseNavigationController * navc = (BaseNavigationController *)viewController;
    if ([[navc.childViewControllers firstObject] isKindOfClass:[MineVC class]]) {
        if (![zkSignleTool shareTool].isLogin) {
            [self gotoLoginVC];
            return NO;
        }
    }
    return YES;
    
}

#pragma mark --- 点击右侧导航栏按钮 -------
- (void)navBtnClick:(UIButton *)button {
    if (button.tag == 101) {
        //点击搜索
        
        [MobClick event:@"clcik"];
        
        zkNewSearchVC * vc =[[zkNewSearchVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
       //点击发帖
        [MobClick event:@"clcik1" attributes:@{@"fatie":@"发布"}];
        zkFatieTVC * vc =[[zkFatieTVC alloc] init];
        typeof(self) weakSelf = self;
        vc.fatieBlcok = ^{
            weakSelf.navLeftV.selectIndex = 1;
            weakSelf.type = 1;
            weakSelf.pageNumber = 1;
            [weakSelf getListWithType:weakSelf.type];
            
        };
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    
}



#pragma mark --- 点击左侧导航栏按钮的代理-------
- (void)didSelectLeftNavWithIndex:(NSInteger)index {
   if (index == 1) {
       self.type = 1;
       
       self.pageNumber = 1;
       [self getListWithType:self.type];
    }else {
        self.type = 2;
        self.pageNumber = 1;
        [self getListWithType:self.type];

    }
////    [self.tableView reloadData];
//
//    if (index == 1) {
//
//
//        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2] atScrollPosition:(UITableViewScrollPositionTop) animated:YES];
//    }else {

    
 
    
    
}

#pragma mark ---- 点击轮播图的代理 -----
- (void)didSelectLunBoPic:(NSInteger)index {
    
    zkBannerModel * model = self.bannerDataArr[index];
    zkYiJianFanKuiDetailVC * vc =[[zkYiJianFanKuiDetailVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.isComeBannar = YES;
    vc.urlStr = model.linkUrl;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

#pragma mark --- 点击更多牛人 -----
- (void)moreAction:(UIButton *)button {
    
    NSArray * titleArr = @[@"总收益榜",@"周收益榜",@"日收益榜"];
    NSMutableArray * vcsArr = @[].mutableCopy;
    for (int i = 0 ; i < titleArr.count ; i++) {
        zkNiuRenBangTVC * tvc = [[zkNiuRenBangTVC alloc] init];
        tvc.type = i;
        [vcsArr addObject:tvc];
    }
    
    zkContrainTitlesVC * vc =[[zkContrainTitlesVC alloc] initFrame:self.view.bounds titleArr:titleArr vcsArr:vcsArr];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
//获取banner列表
- (void)GetbannerList {
    [SVProgressHUD show];
    [zkRequestTool networkingGET:[zkURL getBannerListURL] parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            [SVProgressHUD dismiss];
            self.bannerDataArr = [zkBannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
            [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:(UITableViewRowAnimationNone)];
            
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
    [SVProgressHUD show];
    [zkRequestTool networkingGET:[zkURL getTopicInfoListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            [SVProgressHUD dismiss];
            NSMutableArray * arr  = [NSMutableArray arrayWithArray:[zkHomelModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"rows"]]];
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
            model.supportFlag = YES;
            model.supportCount = [NSString stringWithFormat:@"%ld",zanNumber];
            model.supportUserIds =  [[zkSignleTool shareTool].userInfoModel.ID stringByAppendingString:[NSString stringWithFormat:@",%@",model.supportUserIds]];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
//获取牛人版
- (void)GetNiuRenList {
    [SVProgressHUD show];
    
    NSMutableDictionary *dict =@{}.mutableCopy;
    dict[@"type"] = @"3";
    dict[@"pageNo"] = @1;
    
    [zkRequestTool networkingGET:[zkURL getTradeRankListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            [SVProgressHUD dismiss];
            self.niuRenBangArr = [zkBtcRankModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"rows"]];
            [self.tableView reloadSections:[[NSIndexSet alloc] initWithIndex:1] withRowAnimation:(UITableViewRowAnimationNone)];
            
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
