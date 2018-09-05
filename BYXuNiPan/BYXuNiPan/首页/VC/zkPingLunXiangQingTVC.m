//
//  zkPingLunXiangQingTVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/26.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkPingLunXiangQingTVC.h"
#import "zkPingLunDetailHeadView.h"
#import "zkNewsPLThreeCell.h"
#import "zkPingLunDetailCell.h"
#import "PopListView.h"
#import "DKSKeyboardView.h"
#import "zkTieZiXiangQingTVC.h"
@interface zkPingLunXiangQingTVC ()<PopListViewDelegate,DKSKeyboardDelegate,zkPingLunDetailHeadViewDelegate>
@property(nonatomic,strong)zkHomelModel *dataModel;
@property(nonatomic,strong)zkPingLunDetailHeadView *headV;
@property(nonatomic,assign)NSInteger selectDYIndex;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,strong)PopListView *popListV;
@property(nonatomic,strong)NSString *titleStr;
@property (nonatomic, strong) DKSKeyboardView *keyView;
@property(nonatomic,assign)BOOL isHuiFuZhuTie;
@property(nonatomic,assign)NSInteger pageNumber;
@property(nonatomic,strong)NSIndexPath *selectIndexPath;
@property(nonatomic,strong)zkHomelModel *selectPingModel;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)NSInteger addPingLunCount;



@end

@implementation zkPingLunXiangQingTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isPush = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.sendPingLunModel != nil && self.isPush == NO) {
        self.sendPingLunModel(self.dataModel);
        
    }
    if (self.sendPingLunAddCount != nil && self.isPush == NO) {
        self.sendPingLunAddCount(self.addPingLunCount);
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNumber = 1;
    self.type = 0;
    [self getData];
    self.isPush = NO;
    self.isHuiFuZhuTie = YES;
    self.titleStr = @"智能排序";
    [self.tableView registerNib:[UINib nibWithNibName:@"zkNewsPLThreeCell" bundle:nil] forCellReuseIdentifier:@"zkNewsPLThreeCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"zkPingLunDetailCell" bundle:nil] forCellReuseIdentifier:@"zkPingLunDetailCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNumber = 1;
        [self getData];
    }];

    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getDataList];
    }];
    
    self.headV = [[zkPingLunDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 1)];
    self.headV.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 1000;
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 52);
    
    //添加输入框
    self.keyView = [[DKSKeyboardView alloc] initWithFrame:CGRectMake(0, ScreenH  - 52 - sstatusHeight - 44, ScreenW, 52)];
    self.keyView.tyep = 1;
    //    self.keyView.backgroundColor = [UIColor redColor];
    self.keyView.nomalImage = [UIImage imageNamed:@"tab_praise_n"];
    self.keyView.selectImage = [UIImage imageNamed:@"tab_praise_p"];
    
    self.keyView.placehodleStr = [NSString stringWithFormat:@" @%@",self.nickName];
    //设置代理方法
    self.keyView.delegate = self;
    [self.view addSubview:_keyView];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0){
        return 1;
    }
    return self.dataModel.replyList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }else {
        return 0.01;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        zkNewsPLThreeCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkNewsPLThreeCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.rightBt setTitle:self.titleStr forState:UIControlStateNormal];
        [cell.rightBt addTarget:self action:@selector(clickRightBt:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else {
        zkPingLunDetailCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkPingLunDetailCell" forIndexPath:indexPath];
        zkHomelModel * model = self.dataModel.replyList[indexPath.row];
        cell.parentId = self.dataModel.ID;
        cell.model = model;
        cell.zanBt.tag = indexPath.row;
        [cell.zanBt addTarget:self action:@selector(didClickRightBt:) forControlEvents:UIControlEventTouchUpInside];
        cell.headBt.tag = indexPath.row;
        [cell.headBt addTarget:self action:@selector(didClickhead:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
        
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.keyView.textView becomeFirstResponder];
    self.selectPingModel = self.dataModel.replyList[indexPath.row];
    self.keyView.placehodleStr = [NSString stringWithFormat:@" @%@",self.selectPingModel.createByNickName];
    self.isHuiFuZhuTie = NO;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)clickRightBt:(UIButton *)button {
    
    self.type ++;
    self.type = self.type%2;
    NSArray * arr = @[@"智能排序",@"点赞排序"];
    self.titleStr = arr[self.type];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:(UITableViewRowAnimationFade)];
    self.pageNumber = 1;
    [self getDataList];
    
    
//    CGPoint point = self.tableView.contentOffset;
//    self.popListV = [[PopListView alloc] initWithTitleArr:@[@"全部",@"订阅我的",@"只看楼主"]];
//    self.popListV.delegate = self;
//    [self.popListV showAtPoint:CGPointMake(ScreenW - 80 -15 , 180 +sstatusHeight + 44 - (point.y)) animation:YES];
    
}

#pragma  mark ---- 点击弹出框的代理 ----
-(void)PopListView:(PopListView *)view  didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSArray * arr = @[@"只能排序",@"点赞排序"];
//    self.selectDYIndex = indexPath.row;
//    self.type = indexPath.row + 1;
//    self.titleStr = arr[indexPath.row];
//    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:(UITableViewRowAnimationFade)];
    
    
    
}

- (void)keyboardChangeFrameWithMinY:(CGFloat)minY {
    
    if (minY> 450) {
        self.isHuiFuZhuTie = YES;
        self.keyView.placehodleStr = [NSString stringWithFormat:@" @%@",self.nickName];
    }
    
    NSLog(@"%@",@"wer");
    NSLog(@"%@",self.keyView);
    NSLog(@"%f",minY);
    
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"keyboardHide" object:nil];
}


#pragma mark ====== DKSKeyboardDelegate ======
//发送的文案
- (void)textViewContentText:(NSString *)textStr {
    
    if (self.isHuiFuZhuTie) {
        [self pingLunWeithHomeModel:self.dataModel text:textStr];
    }else {
        [self pingLunWeithHomeModel:self.selectPingModel text:textStr];
    }
}



//评论详情
- (void)getData {
    
    NSString * url = [NSString stringWithFormat:@"%@%@%@",[zkURL getTopicReplyDetailURL],@"/",self.pingLunID];;
    [zkRequestTool networkingGET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            [SVProgressHUD dismiss];
            self.dataModel = [zkHomelModel mj_objectWithKeyValues:responseObject[@"result"]];
            self.headV.model = self.dataModel;
            self.headV.height = self.headV.headHeight;
            self.tableView.tableHeaderView = self.headV;
            self.keyView.moreBtn.selected = self.dataModel.supportFlag;
            self.keyView.placehodleStr = [NSString stringWithFormat:@" @%@",self.dataModel.createByNickName];
            self.nickName = self.dataModel.createByNickName;
            [self.tableView reloadData];
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==800){
            [SVProgressHUD showSuccessWithStatus:@"帖子已经被删除"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else {
             [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];
    
}

//朱评论liset
- (void)getDataList {
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"pageNo"] = @(self.pageNumber);
    dict[@"topicId"] = self.pingLunID;
    dict[@"type"] = @"2";
    if (self.type == 0) {
        //默认
        dict[@"sort"] = @"1";
    }else {
        dict[@"sort"] = @"2";
    }
    [zkRequestTool networkingGET:[zkURL getTopicReplyListURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
             [SVProgressHUD dismiss];
            NSMutableArray * arr = [zkHomelModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"rows"]];
            if (self.pageNumber == 1) {
                [self.dataModel.replyList removeAllObjects];
                [self.dataModel.replyList addObjectsFromArray:arr];
            }else {
                [self.dataModel.replyList addObjectsFromArray:arr];
            }
          
            [self.tableView reloadData];
            self.pageNumber++;
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


#pragma  mark ---- 评论 ----
- (void)pingLunWeithHomeModel:(zkHomelModel *)model text:(NSString *)text{
    
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }
    if (text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入评论"];
        return;
    }
    NSMutableDictionary *dict = @{}.mutableCopy;
    dict[@"content"] = text;
//    dict[@"topicId"] = self.dataModel.topicId;
    dict[@"parentId"]  = self.dataModel.ID;
    if (!self.isHuiFuZhuTie) {
        dict[@"parentId"] = model.ID;
    }
    [zkRequestTool networkingJsonPOST:[zkURL getAddPingLunURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
             [SVProgressHUD dismiss];
            self.addPingLunCount++;
            if (self.isHuiFuZhuTie) {
                zkHomelModel * mm = [zkHomelModel mj_objectWithKeyValues:responseObject[@"result"]];
                [self.dataModel.replyList insertObject:mm atIndex:0];
              
            }else {
                //对内部进行评论 此时的model 比dataModel低一级
                zkHomelModel * mm = [zkHomelModel mj_objectWithKeyValues:responseObject[@"result"]];
                [self.dataModel.replyList addObject:mm];
            }
            [self.tableView reloadData];
            [self.keyView.textView resignFirstResponder];
            self.keyView.placehodleStr = [NSString stringWithFormat:@" @%@",self.dataModel.createByNickName];
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}

#pragma mark ---- 点击内部cell的点赞 -----
- (void)didClickRightBt:(UIButton *)button {
    
    zkHomelModel * model = self.dataModel.replyList[button.tag];
    if (model.supportFlag) {
        [SVProgressHUD showErrorWithStatus:@"不可重复点赞"];
        return;
    }
    [self zanActionType:2 IndexPath:nil model:model];
}

- (void)didClickhead:(UIButton *)button {
    zkHomelModel * model = self.dataModel.replyList[button.tag];
    zkOtherCerterTVC * vc =[[zkOtherCerterTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    vc.hidesBottomBarWhenPushed = YES;
    vc.userID = model.createBy;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma  mark --- 点赞操作 ---
- (void)zanActionType:(NSInteger)type IndexPath:(NSIndexPath *)indexPath model:(zkHomelModel *)model{
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }
    NSMutableDictionary * dict =@{}.mutableCopy;
    dict[@"topicId"] = model.ID;
    dict[@"type"] = @(2);
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:[zkURL getAddZanURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
             [SVProgressHUD dismiss];
            model.supportFlag = YES;
            model.supportCount = [NSString stringWithFormat:@"%ld",[model.supportCount integerValue] + 1];
            if (type == 1) {
                self.keyView.moreBtn.selected = model.supportFlag;
                self.headV.model = model;
            }
        
            [self.tableView reloadData];
            
        } else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

#pragma mark -- 点击头部的按钮的代理 ----
- (void)didClickheadBt:(UIButton *)button index:(NSInteger)index {
    
    if (index == 0) {
        
        [self zanActionType:1 IndexPath:nil model:self.dataModel];
        
    }else if (index == 1) {
        //点击查看原文
        
        UIViewController * vc = self.navigationController.childViewControllers[self.navigationController.childViewControllers.count - 2];
        if ([vc isKindOfClass:[zkTieZiXiangQingTVC class]]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            
            zkTieZiXiangQingTVC * vc =[[zkTieZiXiangQingTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
            vc.hidesBottomBarWhenPushed = YES;
            vc.ID = self.dataModel.topicId;
            [self.navigationController pushViewController:vc animated:YES]; 
        }
        
        
        
    }else if (index == 2) {
        //点击头像
        zkOtherCerterTVC * vc =[[zkOtherCerterTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        vc.hidesBottomBarWhenPushed = YES;
        vc.userID = self.dataModel.createBy;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 100) {
        self.isHuiFuZhuTie = YES;
        self.keyView.placehodleStr = [NSString stringWithFormat:@" @%@",self.nickName];
    }
    
}


@end
