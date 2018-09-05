//
//  HangQingVC.m
//  BYXuNiPan
//
//  Created by kunzhang on 2018/7/2.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "HangQingVC.h"
#import "zkHangQingCell.h"
#import "zkTopClickView.h"
#import "zkBiZhongSearchTVC.h"
#import "zkBuyAndSellingV.h"
#import "zkBiModel.h"
#import "zkBiZhongDetailTVC.h"

@interface HangQingVC ()<zkNavTitleViewDelegate,zkTopClickViewDelegate>
@property(nonatomic,strong)zkNavTitleView *navTitle;
@property(nonatomic,strong)zkTopClickView *topV;
@property(nonatomic,assign)NSInteger searchType;
@property(nonatomic,assign)NSInteger ziXuanOrAll;
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation HangQingVC

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getAllDataList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchType = 0;
    self.ziXuanOrAll = 0;
    [self.tableView registerNib:[UINib nibWithNibName:@"zkHangQingCell" bundle:nil] forCellReuseIdentifier:@"zkHangQingCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.frame = CGRectMake(0,  40, ScreenW, ScreenH - 49 -40);
    [self setNav];
  
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getAllDataList];
    }];

}

- (void)setNav {
    
    self.navTitle = [[zkNavTitleView alloc] initWithFrame:CGRectMake(0, 0, ScreenW - 150, 35)];
    self.navTitle.titleArr = @[@"自选",@"全部"].mutableCopy;
    self.navTitle.delegate = self;
    self.navigationItem.titleView = self.navTitle;
    
    self.topV = [[zkTopClickView alloc] initWithFreame:CGRectMake(0, 0, ScreenW, 40) alignmentArr:@[@"0",@"1",@"2"] titleArr:@[@"市值",@"价格",@"今日涨幅"]];
    _topV.delegate = self;
    [self.view addSubview:self.topV];
    
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 10, 35, 35);
    [right setImage:[UIImage imageNamed:@"nav_search"] forState:UIControlStateNormal];
    [right setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentRight)];
    right.tag = 101;
    [right addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    zkHangQingCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkHangQingCell" forIndexPath:indexPath];
    
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = WhiteColor;
    }else {
        cell.backgroundColor = RGB(240, 240, 240);
    }
    CGFloat rangkingW = [[NSString stringWithFormat:@"%ld",indexPath.row +1] getWidhtWithFontSize:11];
    cell.rankingLBWidthCon.constant = rangkingW + 6;
    if (indexPath.row < 9) {
        cell.rankingLBWidthCon.constant = 13;
    }
    cell.rankingLB.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    if (indexPath.row < 3) {
        cell.rankingLB.backgroundColor = PMBlue123;
    }else if (indexPath.row < 6) {
        cell.rankingLB.backgroundColor = PMBlue456;
    }else {
        cell.rankingLB.backgroundColor = PMBlue7;
    }
    zkBiModel * model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    zkBuyAndSellingV * v = [[zkBuyAndSellingV alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
//    [v show];
    
    zkBiModel * model = self.dataArray[indexPath.row];
    zkBiZhongDetailTVC* vc =[[zkBiZhongDetailTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    vc.hidesBottomBarWhenPushed = YES;
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


#pragma mark ---- 点击导航栏的自选和全部 -----

- (void)didSelectTitleButton:(UIButton *)button index:(NSInteger)index isSame:(BOOL)isSame {
    
    self.ziXuanOrAll = index;
    
    [self getAllDataList];
    
    
}
#pragma mark ---- 点击选的内容 ------
- (void)clickTopChooseIndex:(NSInteger)index times:(NSInteger)times {
    
    for (int i = 0 ; i < 3 ; i++) {
        zkTopNeiView * v = [self.topV viewWithTag:200+i];
        if ((index + 200) == v.tag) {
            
        }else {
            v.isSelect = NO;
        }
    }
    if (times == 0) {
        self.searchType = 0;
    }else if (times == 1){
        self.searchType = (index + 1) *2;
    }else {
        self.searchType = (index + 1) *2 - 1;
    }
    [self getAllDataList];
    
}

- (void)getAllDataList {
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    if (self.searchType != 0) {
        dict[@"orderType"] = @(self.searchType);
    }
    
    NSString * url = [zkURL getAllBitURL];
    if (self.ziXuanOrAll == 0) {
        url = [zkURL getChaKanZiXuanURL];
        dict[@"deviceId"] = deviceID;
    }
    
    [SVProgressHUD show];
    [zkRequestTool networkingGET:url parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
             [SVProgressHUD dismiss];
            self.dataArray = [zkBiModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        
            [self.tableView reloadData];
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
    
    
}


- (void)navBtnClick:(UIButton *)button {
    zkBiZhongSearchTVC * vc =[[zkBiZhongSearchTVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
