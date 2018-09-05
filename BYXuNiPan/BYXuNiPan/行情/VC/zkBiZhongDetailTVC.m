//
//  zkBiZhongDetailTVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/8/1.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkBiZhongDetailTVC.h"
#import "zkMaiMaiView.h"
#import "zkBuyAndSellingV.h"
#import "zkPingLunView.h"
#import "WebSocketManager.h"
#import "zkJiaoYiChooseCell.h"
#import "zkPingLunWaiCell.h"
#import "zkBiZhongXinWenCell.h"
#import "zkHangQingDetailView.h"
#import "AppDelegate.h"
#import "zkZhangDieFuView.h"
#import "zkBtcNewsModel.h"
#import "zkBtcFootView.h"
#import "zkBTCDetailModel.h"
#import "zkTieZiXiangQingTVC.h"
#import "zkYiJianFanKuiDetailVC.h"
static NSInteger aa = 0;

@interface zkBiZhongDetailTVC ()<zkMaiMaiViewDelegate,zkJiaoYiChooseCellDelegate,zkPingLunWaiCellDelegate,zkPingLunViewDelegate,zkHangQingDetailViewDelgate,zkBuyAndSellingVDelegate,zkBiZhongXinWenCellDelegate,zkBtcFootViewDelegate>
@property(nonatomic,strong)zkMaiMaiView *maiMaiV;
@property(nonatomic,strong)zkBuyAndSellingV *buyOrSellV;
@property(nonatomic,assign)NSInteger type; //是新闻还是币种信息

@property(nonatomic,strong)zkHangQingDetailView *headV;
@property(nonatomic,strong)UIButton *backBt,*chaBt;
@property(nonatomic,strong)zkZhangDieFuView *zhangDieV;
@property(nonatomic,strong)UILabel *naviLB;
@property(nonatomic,assign)NSInteger pageNumber,newsPageNumber;
@property(nonatomic,strong)NSString *moneyStr,*btcNumber,*priceStr;//获取到的价格,bit 数量
@property(nonatomic,strong)NSMutableArray<zkHomelModel *> *dataArray;
@property(nonatomic,strong)NSMutableArray<zkBtcNewsModel *> *newsDataArray;
@property(nonatomic,strong)zkPingLunView *PV;
@property(nonatomic,strong)zkBtcFootView *footV;
@property(nonatomic,strong)zkBTCDetailModel *btcDetailModel;
@property(nonatomic,assign)BOOL isAdd; //是否添加了
@end

@implementation zkBiZhongDetailTVC
- (NSMutableArray<zkHomelModel *> *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray<zkBtcNewsModel *> *)newsDataArray {
    if (_newsDataArray == nil) {
        _newsDataArray = [NSMutableArray array];
    }
    return _newsDataArray;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[WebSocketManager instance] WebSocketClose];
 
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self shouldAutorotate];
    
    // Do any additional setup after loading the view.
    self.type = 0;
    self.pageNumber = self.newsPageNumber = 1;
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 45);
    self.maiMaiV = [[zkMaiMaiView alloc] initWithFrame:CGRectMake(0, ScreenH - 45 - sstatusHeight - 44, ScreenW, 45)];
    self.maiMaiV.delegate = self;
    [self.view addSubview:self.maiMaiV];
    
    [self getAllDataDetail];
    [self getMoneyAndBt];
    [self getTieZiList];
    [self getNewsList];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getAllDataDetail];
        if (self.type == 0) {
            self.pageNumber = 1;
            [self getTieZiList];
        }else if (self.type == 1) {
            self.newsPageNumber = 1;
            [self getNewsList];
        }
    }];

    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getTieZiList];
        if (self.type == 0) {
            [self getTieZiList];
        }else if (self.type == 1) {
            [self getNewsList];
        }
    }];
  
    
    [self.tableView registerClass:[zkJiaoYiChooseCell class] forCellReuseIdentifier:@"zkJiaoYiChooseCell"];
    [self.tableView registerClass:[zkPingLunWaiCell class] forCellReuseIdentifier:@"zkPingLunWaiCell"];
        [self.tableView registerClass:[zkBiZhongXinWenCell class] forCellReuseIdentifier:@"zkBiZhongXinWenCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setFootAndHeadView];
    [self setNavB];
    

    
}

- (void)setFootAndHeadView {
    self.footV = [[zkBtcFootView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0.01)];
     [self.footV.zhanKaiBt addTarget:self action:@selector(zhanKai) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = self.footV;
    self.footV.delegate = self;
    self.footV.hidden = YES;
    
    self.view.backgroundColor = [UIColor greenColor];
    self.zhangDieV = [[NSBundle mainBundle] loadNibNamed:@"zkZhangDieFuView" owner:nil options:nil].lastObject;
    self.zhangDieV.frame = CGRectMake(0, 0, ScreenW - 100, 44);
    self.zhangDieV.shiZhiLB.text = [NSString stringWithFormat:@"%0.2f亿",[self.self.model.marketValue floatValue]];
    self.zhangDieV.nameLB.text = [NSString stringWithFormat:@"%@",self.model.bitName];
    
    zkHangQingDetailView * vv = [[zkHangQingDetailView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 400)];
    self.headV = vv;
    vv.biZhongStr = self.model.bitName;
    __weak typeof(self) weakSelf = self;
    self.headV.sendShiSHiModel = ^(zkKLineModel *model) {
        if (aa == 0) {
            return ;
        }
        CGFloat price = [model.price floatValue];
        weakSelf.zhangDieV.moneyLB.text = [NSString stringWithFormat:@"%0.2f",price];
        CGFloat increase = [model.increase floatValue];
        if (increase > 0) {
            weakSelf.zhangDieV.zhangDieLB.text = [NSString stringWithFormat:@"+%0.2f",increase];
            weakSelf.zhangDieV.zhangDieLB.textColor = GreenColor;
        }else if (increase == 0) {
            weakSelf.zhangDieV.zhangDieLB.text = [NSString stringWithFormat:@"%0.2f",increase];
            weakSelf.zhangDieV.zhangDieLB.textColor = CharacterGrayColor102;
        }else {
            weakSelf.zhangDieV.zhangDieLB.text = [NSString stringWithFormat:@"%0.2f",increase];
            weakSelf.zhangDieV.zhangDieLB.textColor = RedColor;
        }
        weakSelf.zhangDieV.zuiGaoLB.text = model.kline.high;
        weakSelf.zhangDieV.zuidiLB.text = model.kline.low;
    };
    vv.shiZhiStr = self.model.marketValue;
    vv.biZhongStr = self.model.bitName;
    vv.delegate = self;
    self.tableView.tableHeaderView = vv;

    self.naviLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
    self.naviLB.textColor = [UIColor blackColor];
    self.naviLB.textAlignment = 1;
    self.naviLB.font = [UIFont boldSystemFontOfSize:18];
    self.naviLB.text = [NSString stringWithFormat:@"%@",[self.model.bitName uppercaseString]];
    self.navigationItem.titleView = self.naviLB;
    
    
}

- (void)setNavB {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"nav_back"] forState:(UIControlStateNormal)];
    [button setImage:[UIImage imageNamed:@"nav_back"] forState:(UIControlStateHighlighted)];
    CGRect frame = CGRectMake(0, 0, 30, 30);
    button.frame = frame;
    [button addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:button]];
    self.backBt = button;
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setImage:[UIImage imageNamed:@"cross"] forState:(UIControlStateNormal)];
    [button1 setImage:[UIImage imageNamed:@"cross"] forState:(UIControlStateHighlighted)];
    button1.frame = frame;
    [button1 addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button1];
    self.chaBt = button1;
    self.chaBt.hidden = YES;
    

}


#pragma mark ---- 点击资料的展开你
- (void)zhanKai{
    self.btcDetailModel.isZhanKai = !self.btcDetailModel.isZhanKai;
    self.footV.model = self.btcDetailModel;
    self.footV.mj_h = self.footV.footViewHeight;
    self.tableView.tableFooterView = self.footV;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (self.type == 0) {
         return self.dataArray.count;
    }else if (self.type == 1){
        return self.newsDataArray.count;
    }else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 50;
    }
    if (self.type == 0) {
        return self.dataArray[indexPath.row].cellHeight;
    }else if (self.type == 1){
        return self.newsDataArray[indexPath.row].cellHeight;
    }else {
        return 100;
    }
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //选择的那一部分
        zkJiaoYiChooseCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkJiaoYiChooseCell" forIndexPath:indexPath];
        cell.dataArr = @[@"讨论",@"新闻",@"币种资料"].mutableCopy;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        return cell;
    }else {
        
        if (self.type == 0) {
            zkPingLunWaiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"zkPingLunWaiCell" forIndexPath:indexPath];
            cell.delegate = self;
            cell.type = 2;
            cell.headBt.tag = indexPath.row;
            [cell.headBt addTarget:self action:@selector(clickHeadAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.model = self.dataArray[indexPath.row];
            return cell;
        }else if (self.type == 1) {
            zkBiZhongXinWenCell * cell = [tableView dequeueReusableCellWithIdentifier:@"zkBiZhongXinWenCell" forIndexPath:indexPath];
            cell.model = self.newsDataArray[indexPath.row];
            cell.zhanKaiBt.tag = indexPath.row;
            cell.delegate = self;
            [cell.zhanKaiBt addTarget:self action:@selector(zhanKaiAction:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else {
            
            
        }
        
        zkPingLunWaiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"zkPingLunWaiCell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.type = 2;
//        cell.headBt.tag = indexPath.row;
//        [cell.headBt addTarget:self action:@selector(clickHeadAction:) forControlEvents:UIControlEventTouchUpInside];
//        cell.model = self.dataArray[indexPath.row];
        return cell;
        
        
    }

    
}

- (void)zhanKaiAction:(UIButton *)button {
    zkBtcNewsModel * model = self.newsDataArray[button.tag];
    model.isZhanKai = !model.isZhanKai;
    [self.tableView reloadData];
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.type == 0) {
        //点击的讨论
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

    }else if (self.type == 1) {
        //点击的是新闻
        
        
    }else {
        
        
        
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

#pragma mark --- 点击持仓明细部分 -----
- (void)didClickChooseView:(zkJiaoYiChooseCell *)cell headIndex:(NSInteger)index isSmaeClick:(BOOL)isSame {
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.section == 0) {
        //持仓部分
        self.type = index;
        if (index == 2) {
            self.footV.hidden = NO;
            self.footV.mj_h = self.footV.footViewHeight;
            
        }else {
            self.footV.mj_h = 0.01;
            self.footV.hidden = YES;
            
        }
        [self.tableView reloadData];
    }
}

//点击返回按钮时
- (void)back:(UIButton *)button {
   
    if (aa % 2 == 1) {
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [self forceOrientationPortraitWith:self];
        self.headV.frame = CGRectMake(0, 0, ScreenW, 400);
        self.tableView.tableHeaderView = self.headV;
        self.maiMaiV.hidden = NO;
        self.tableView.scrollEnabled = YES;
        self.chaBt.hidden = YES;
        self.backBt.hidden = NO;
        aa = 0;
    }else {
       
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}

- (void)didDoubleClickView {
  
    if (aa % 2 == 0) {
        self.tableView.frame = CGRectMake(0, 0, ScreenW  , ScreenH);
        self.headV.mj_h = ScreenW - 44;
        self.maiMaiV.hidden = YES;
        self.tableView.scrollEnabled = NO;
        self.tableView.contentInset = UIEdgeInsetsMake(0, 44, 0, 0);
        [self forceOrientationLandscapeWith:self];

//        [self.view addSubview:self.headV];
//        if (sstatusHeight == 44) {
//            self.headV.frame = CGRectMake(sstatusHeight+self.view.frame.origin.y, 0, self.view.frame.size.width-sstatusHeight-44, self.view.frame.size.height);
//        }else {
//            self.headV.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//        }
        [self.headV updateLayoutWithLandscape:YES];
        self.chaBt.hidden = NO;
        self.backBt.hidden = YES;
    }else {
         self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
         [self forceOrientationPortraitWith:self];
         self.headV.frame = CGRectMake(0, 0, ScreenW, 400);
         self.tableView.tableHeaderView = self.headV;
         self.maiMaiV.hidden = NO;
        self.tableView.scrollEnabled = YES;
         [self.headV updateLayoutWithLandscape:NO];
        self.chaBt.hidden = YES;
        self.backBt.hidden = NO;
        
    }
    aa++;
    
}

#pragma mark --- 点击代理 ----
- (void)didClickBuyOrSellIndex:(NSInteger)index with:(UIButton *)button {
    if (index == 0) {
        //买
//        [self sendTongZhiWithName:@"jiaoyi"];
        self.buyOrSellV = [[zkBuyAndSellingV alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        self.buyOrSellV.delegate = self;
        self.buyOrSellV.moneyStr = self.moneyStr;
        self.buyOrSellV.bitNumberStr = self.btcNumber;
        self.buyOrSellV.pricStr = self.priceStr;
        [self.buyOrSellV showWithMaiMai:YES];
        
    
        
    }else if (index == 1) {
        //卖
//        [self sendTongZhiWithName:@"jiaoyi"];
        self.buyOrSellV = [[zkBuyAndSellingV alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        self.buyOrSellV.delegate = self;
        self.buyOrSellV.moneyStr = self.moneyStr;
        self.buyOrSellV.bitNumberStr = self.btcNumber;
        self.buyOrSellV.pricStr = self.priceStr;
        [self.buyOrSellV showWithMaiMai:NO];
        
        
        
    }else if (index == 2) {
        //评论
        [self sendTongZhiWithName:@"jiaoyi"];
        zkPingLunView * v = [[zkPingLunView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        self.PV = v;
        v.delegate = self;
        [v show];
        
        
    }else if (index == 3) {
        
        [self clickAction:button];
        
        
    }
}

#pragma  mark ----- 加减自选 ------
- (void)clickAction:(UIButton *)button {

    NSString * url = [zkURL getAddMyBitURL];
    if ([self.btcDetailModel.isAdd isEqualToString:@"yes"]) {
        url = [zkURL getDeleMyBitURL];
    }
    
    [SVProgressHUD show];
    [zkRequestTool networkingGET:url parameters:@{@"bitNames":self.model.bitName,@"deviceId":deviceID} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            [SVProgressHUD dismiss];
            if ([self.btcDetailModel.isAdd isEqualToString:@"no"]) {
                [SVProgressHUD showSuccessWithStatus:@"添加自选成功"];
                self.btcDetailModel.isAdd = @"yes";
            }else {
                [SVProgressHUD showSuccessWithStatus:@"去除自选成功"];
                self.btcDetailModel.isAdd = @"no";
            }
            if ([self.btcDetailModel.isAdd isEqualToString:@"yes"]) {
                self.maiMaiV.addV.image =[UIImage imageNamed:@"jian"];
                self.maiMaiV.addLB.text = @"减自选";
            }else {
                self.maiMaiV.addV.image =[UIImage imageNamed:@"tab_plus"];
                self.maiMaiV.addLB.text = @"加自选";
            }
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
    
}


- (void)sendTongZhiWithName:(NSString *)name {
    
    NSNotification * notification = [[NSNotification alloc] initWithName:name object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
}

#pragma 点击内部的买卖
- (void)didBuyOrSellV:(NSInteger)buyOrSell xianJiaOrShiJia:(NSInteger)xianOrShi number:(NSString *)number priceStr:(NSString *)priceStr {
    // buyOrSell 0 买入 1 卖出  //xianOrShi 0 限价 1 市价
    if (buyOrSell == 0) {
        if ([self.moneyStr floatValue] == 0) {
            [SVProgressHUD showErrorWithStatus:@"您的可用金额不足"];
            return;
        }

        if (xianOrShi == 0) {
            [self buyOrSell:YES isXianJia:YES number:number priceStr:priceStr];
        }else {
            [self buyOrSell:YES isXianJia:NO number:number priceStr:priceStr];
        }
        
    }else {
        if ([self.btcNumber floatValue] == 0) {
            [SVProgressHUD showErrorWithStatus:@"您没持有此币种"];
            return;
        }
        if (xianOrShi == 0) {
             [self buyOrSell:NO isXianJia:YES number:number priceStr:priceStr];
        }else {
             [self buyOrSell:NO isXianJia:NO number:number priceStr:priceStr];
        }
    }

}

#pragma  mark ----- 买卖交易 ------- 
- (void)buyOrSell:(BOOL)isBuy isXianJia:(BOOL)isXianJia number:(NSString*)number priceStr:(NSString *)price{
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"bitName"] = self.model.bitName;
    NSString * urlStr =@"";
    dict[@"amount"] = number;
    if (isXianJia) {
        urlStr = [zkURL getTradeLimitURL];
        dict[@"price"] = price;
        if (isBuy) {
            dict[@"type"] = @"1";
        }else {
            dict[@"type"] = @"2";
        }
    }else {
        urlStr = [zkURL getTradeMarketURL];
        if (isBuy) {
            dict[@"type"] = @"3";
        }else {
            dict[@"type"] = @"4";
        }
        
        
    }
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:urlStr parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {\
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            [self getMoneyAndBt];
            [self.buyOrSellV diss];
            [SVProgressHUD showSuccessWithStatus:@"交易成功，请到持仓明细查看"];
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    

}

#pragma mark --- 点击看空 ----
- (void)didClickZhangOrDieWithCell:(zkBiZhongXinWenCell *)cell index:(NSInteger)index {
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    zkBtcNewsModel * model = self.newsDataArray[indexPath.row];
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"newsId"] = model.ID;
    
    if (index == 0) {
        //看涨
        dict[@"type"] = @"1";
    }else {
       //看空
       dict[@"type"] = @"0";
    }
    [zkRequestTool networkingPOST:[zkURL getBTCNewsSupportURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            if (index == 0) {
                model.supportNum = [NSString stringWithFormat:@"%ld",[model.supportNum integerValue] + 1];
            }else {
                model.supportNum = [NSString stringWithFormat:@"%ld",[model.opposeNum integerValue] + 1];
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

#pragma mark --- 点击发送 ---

- (void)textViewContentText:(NSString *)textStr{
    
    [self faTieAction:textStr];
    
}


#pragma mark ---- 对比中进行评论 -----
- (void)faTieAction:(NSString *)text {
    
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"content"] = text;
    dict[@"coinName"] = self.model.bitName;
    dict[@"type"] = @"3";
    
    [SVProgressHUD show];
    [zkRequestTool networkingJsonPOST:[zkURL getFaTieURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
             [SVProgressHUD dismiss];
            zkHomelModel * model = [zkHomelModel mj_objectWithKeyValues:responseObject[@"result"]];
            [self.dataArray insertObject:model atIndex:0];
            [self.PV diss];
            [self sendTongZhiWithName:@"kaishi"];
            [self.tableView reloadData];
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}


#pragma mark --- 获取btc信息 ---
- (void)getAllDataDetail {
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"bitName"] = self.model.bitName;
    dict[@"deviceId"] = deviceID;
    [SVProgressHUD show];
    [zkRequestTool networkingGET:[zkURL getBitDetailURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
             [SVProgressHUD dismiss];
            NSArray * arr = responseObject[@"result"];
            if (arr.count>0) {
                self.btcDetailModel = [zkBTCDetailModel mj_objectWithKeyValues:responseObject[@"result"][0]];
                
            }
            if ([self.btcDetailModel.isAdd isEqualToString:@"yes"]) {
                self.maiMaiV.addV.image =[UIImage imageNamed:@"jian"];
                self.maiMaiV.addLB.text = @"减自选";
            }else {
                self.maiMaiV.addV.image =[UIImage imageNamed:@"tab_plus"];
                self.maiMaiV.addLB.text = @"加自选";
            }
            self.footV.model = self.btcDetailModel;
            if (self.type != 2) {
                self.footV.mj_h = 0.01;
            }
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

#pragma mark ---- 获取币种下面的的评论 ----
//获取帖列表
- (void)getTieZiList {
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"pageNo"] = @(self.pageNumber);
    dict[@"type"] = @(7);
    dict[@"coinId"] = self.model.bitName;
    [SVProgressHUD show];
    [zkRequestTool networkingGET:[zkURL getTopicInfoListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            [SVProgressHUD dismiss];
            NSMutableArray * arr  = [NSMutableArray arrayWithArray:[zkHomelModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"rows"]]];
            if (self.pageNumber == 1) {
                [self.dataArray removeAllObjects];
//                if (arr.count == 0 ) {
//                    [SVProgressHUD showSuccessWithStatus:@"暂无数据"];
//                }
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

#pragma mark ----- 获取币种的新闻 ----
- (void)getNewsList {
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"pageNo"] = @(self.newsPageNumber);
    dict[@"coinId"] = self.model.bitName;
    [SVProgressHUD show];
    [zkRequestTool networkingGET:[zkURL getBTCNewsInfoURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            [SVProgressHUD dismiss];
            NSMutableArray * arr  = [NSMutableArray arrayWithArray:[zkBtcNewsModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"rows"]]];
            if (self.newsPageNumber == 1) {
                [self.newsDataArray removeAllObjects];
            }
            [self.newsDataArray addObjectsFromArray:arr];
            [self.tableView reloadData];
            self.newsPageNumber++;
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

#pragma mark ----- 获取币种的可用 和我有的钱 ----
- (void)getMoneyAndBt {
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"bitName"] = self.model.bitName;
    [zkRequestTool networkingPOST:[zkURL getTeadeInfoURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            self.moneyStr = [NSString stringWithFormat:@"%@",responseObject[@"result"][@"balance"]];
            self.btcNumber = [NSString stringWithFormat:@"%@",responseObject[@"result"][@"bitCount"]];
            self.priceStr = [NSString stringWithFormat:@"%@",responseObject[@"result"][@"price"]];
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
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

#pragma mark --- 点击相关链接 -----

- (void)didClickLinkIndex:(NSInteger)index Link:(NSString *)linkStr {
     zkYiJianFanKuiDetailVC* vc =[[zkYiJianFanKuiDetailVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.isComeBannar = YES;
    vc.urlStr = linkStr;
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
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}


 //允许自动旋转
-(BOOL)shouldAutorotate{
    return NO;
}
// 横屏时是否将状态栏隐藏
-(BOOL)prefersStatusBarHidden{
    return NO;
}
// 横屏 home键在右边
-(void)forceOrientationLandscapeWith:(UIViewController *)VC{
      [self sendTongZhiWithName:@"kaishi"];
    self.navigationItem.titleView = self.zhangDieV;
    AppDelegate *appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    appdelegate.isForcePortrait=NO;
    appdelegate.isForceLandscape=YES;
    [appdelegate application:[UIApplication sharedApplication] supportedInterfaceOrientationsForWindow:VC.view.window];
    
    //强制翻转屏幕，Home键在右边。
    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
    //刷新
    [UIViewController attemptRotationToDeviceOrientation];
     [self.headV updateLayoutWithLandscape:YES];
}
// 竖屏
- (void)forceOrientationPortraitWith:(UIViewController *)VC{
    self.navigationItem.titleView = self.naviLB;
    AppDelegate *appdelegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    appdelegate.isForcePortrait=YES;
    appdelegate.isForceLandscape=NO;
    [appdelegate application:[UIApplication sharedApplication] supportedInterfaceOrientationsForWindow:VC.view.window];
    
    //强制翻转屏幕
    [[UIDevice currentDevice] setValue:@(UIDeviceOrientationPortrait) forKey:@"orientation"];
    //刷新
    [UIViewController attemptRotationToDeviceOrientation];
    
    [self.headV updateLayoutWithLandscape:NO];
    
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
