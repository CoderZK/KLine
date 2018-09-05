//
//  zkTieZiXiangQingTVC.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/20.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkTieZiXiangQingTVC.h"
#import "zkTieZiXiangQingHeadView.h"
#import "zkPingLunWaiCell.h"
#import "zkSettingCell.h"
#import "DKSKeyboardView.h"
#import "zkPingLunXiangQingTVC.h"
#import "zkMineFenSiTVC.h"
#import "zkBiZhongDetailTVC.h"
@interface zkTieZiXiangQingTVC ()<DKSKeyboardDelegate,UIGestureRecognizerDelegate,zkTieZiXiangQingHeadViewDelegate,zkPingLunWaiCellDelegate>
@property(nonatomic,strong)zkTieZiXiangQingHeadView *headV;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic, strong) DKSKeyboardView *keyView;
@property(nonatomic,strong)zkHomelModel *dataModel;
@property(nonatomic,strong)zkHomelModel *selectPingModel;
@property(nonatomic,assign)BOOL isHuiFuZhuTie;
@property(nonatomic,assign)NSInteger pageNumber;
@property(nonatomic,strong)NSIndexPath *selectIndexPath;
@property(nonatomic,assign)BOOL isPush;
@end

@implementation zkTieZiXiangQingTVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isPush = NO;
    [IQKeyboardManager sharedManager].enable = NO;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [IQKeyboardManager sharedManager].enable = YES;
    
    if (self.sendHomeBlock != nil && self.isPush == NO) {
        self.sendHomeBlock(self.getHomeModel);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageNumber = 1;
    self.navigationItem.title = @"帖子详情";
    self.isHuiFuZhuTie = YES;
    [self setHead];
    [self.tableView registerNib:[UINib nibWithNibName:@"zkSettingCell" bundle:nil] forCellReuseIdentifier:@"zkSettingCell"];
    [self.tableView registerClass:[zkPingLunWaiCell class] forCellReuseIdentifier:@"zkPingLunWaiCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 52);
    
    //添加输入框
    self.keyView = [[DKSKeyboardView alloc] initWithFrame:CGRectMake(0, ScreenH  - 52 - sstatusHeight - 44, ScreenW, 52)];
//    if (sstatusHeight == 44) {
//        self.keyView.frame = CGRectMake(0, ScreenH - 52 - sstatusHeight - 44 - 34 , ScreenW, 52);
//         self.tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 52 - 34 );
//    }
    self.keyView.tyep = 1;
//    self.keyView.backgroundColor = [UIColor redColor];
    self.keyView.nomalImage = [UIImage imageNamed:@"tab_praise_n"];
    self.keyView.selectImage = [UIImage imageNamed:@"tab_praise_p"];
    
    self.keyView.placehodleStr = @" 评论主贴";
    //设置代理方法
    self.keyView.delegate = self;
    [self.view addSubview:_keyView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageNumber = 1;
        [self getTieZiDetail];
    }];
     [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getPingLunList];
    }];
    

}

- (void)setHead {
    self.headV = [[zkTieZiXiangQingHeadView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0)];
    self.headV.clipsToBounds = YES;
    self.headV.delegate = self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataModel == nil) {
        return 0;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.dataModel.hotReplyList.count;
    }else {
        return self.dataModel.replyList.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if ((section == 0 && self.dataModel.hotReplyList.count > 0) || (section == 1 && self.dataModel.replyList.count > 0)) {
        
        return 40;
        
    }else {
        return 0.01;
    }

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSArray * arr = @[@"热门评论",@"最新评论"];
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 40)];
    view.backgroundColor = WhiteColor;
    
    UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 10)];
    backV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [view  addSubview:backV];
    
    UILabel * lb =[[UILabel alloc] initWithFrame:CGRectMake(15, 20 , ScreenW - 30, 20)];
    lb.font =[UIFont boldSystemFontOfSize:14];
    lb.textColor = CharacterBlackColor30;
    lb.text = arr[section];
    [view addSubview:lb];

    view.clipsToBounds = YES;

    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.section == 0) {
        zkHomelModel * model = self.dataModel.hotReplyList[indexPath.row];
        return model.cellHeight;
    }else {
        zkHomelModel * model = self.dataModel.replyList[indexPath.row];
        return model.cellHeight;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    zkPingLunWaiCell * cell = [tableView dequeueReusableCellWithIdentifier:@"zkPingLunWaiCell" forIndexPath:indexPath];
    cell.type = indexPath.section + 1;
    cell.isNeiPingLun = YES;
    cell.delegate = self;
    if (indexPath.section == 0) {
        zkHomelModel * model = self.dataModel.hotReplyList[indexPath.row];
        model.type = @"1";
        cell.model = model;
    }else {
        zkHomelModel * model = self.dataModel.replyList[indexPath.row];
        model.type = @"1";
        cell.model = model;
    }
    cell.headBt.tag = indexPath.row;
    [cell.headBt addTarget:self action:@selector(clickHeadBt:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}

- (void)clickHeadBt:(UIButton *)button {
    zkHomelModel * model = self.dataModel.replyList[button.tag];
    zkOtherCerterTVC * vc =[[zkOtherCerterTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    vc.hidesBottomBarWhenPushed = YES;
    vc.userID = model.createBy;
    [self.navigationController pushViewController:vc animated:YES]; 
 
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.keyView.textView becomeFirstResponder];
    if (indexPath.section == 0) {
        self.selectPingModel = self.dataModel.hotReplyList[indexPath.row];
        self.keyView.placehodleStr = [NSString stringWithFormat:@" @%@",self.selectPingModel.createByNickName];
    }else {
        self.selectPingModel = self.dataModel.replyList[indexPath.row];
        self.keyView.placehodleStr = [NSString stringWithFormat:@" @%@",self.selectPingModel.createByNickName];
    }
    self.isHuiFuZhuTie = NO;
//    UITextView * t = [UITextView alloc];
//    [t becomeFirstResponder];
}

- (void)keyboardChangeFrameWithMinY:(CGFloat)minY {

    if (minY> 450) {
        self.isHuiFuZhuTie = YES;
        self.keyView.placehodleStr = @" 评论主贴";
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

- (void)didClickRightBt:(UIButton *)button {
    [self zanActionType:1 IndexPath:nil model:nil];
    //    [button setImage:[UIImage imageNamed:@"moreImg"] forState:UIControlStateNormal];
}


- (void)getTieZiDetail {
    
    NSString * url = [NSString stringWithFormat:@"%@%@%@",[zkURL getTopicInfoDetailURL],@"/",self.ID];
    [SVProgressHUD show];
    [zkRequestTool networkingGET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
//        [self.tableView.mj_footer endRefreshing];
            if (self.pageNumber == 1) {
                self.dataModel = [zkHomelModel mj_objectWithKeyValues:responseObject[@"result"]];
                self.headV.model = self.dataModel;
                self.headV.height = self.headV.headHeight;
                self.tableView.tableHeaderView = self.headV;
                self.keyView.moreBtn.selected = self.dataModel.supportFlag;
            }else {
                NSMutableArray * arr = [NSMutableArray arrayWithArray:[zkHomelModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"rows"]]];
                [self.dataModel.replyList addObjectsFromArray:arr];
            }
            self.pageNumber ++;
            [self.tableView reloadData];
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==800){
            [SVProgressHUD showSuccessWithStatus:@"帖子已经被删除"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}

- (void)getPingLunList {
    
    NSMutableDictionary * dict = @{}.mutableCopy;
    dict[@"pageNo"] = @(self.pageNumber);
    dict[@"topicId"] = self.ID;
    dict[@"type"] = @"1";
    [SVProgressHUD show];
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
    dict[@"parentId"]  = @"0";
    if (!self.isHuiFuZhuTie) {
        dict[@"parentId"] = model.ID;
    }else {
         dict[@"topicId"] = self.ID;
    }
    [SVProgressHUD show];
    [zkRequestTool networkingJsonPOST:[zkURL getAddPingLunURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
            [SVProgressHUD dismiss];
            if (self.isHuiFuZhuTie) {
                zkHomelModel * mm = [zkHomelModel mj_objectWithKeyValues:responseObject[@"result"]];
                self.getHomeModel.replyCount = [NSString stringWithFormat:@"%ld", [self.getHomeModel.replyCount integerValue] + 1];
                [self.getHomeModel.replyList addObject:mm];
                if (self.dataModel.hotReplyList.count < 3) {
                    [self.dataModel.hotReplyList addObject:mm];
                }
                [self.dataModel.replyList insertObject:mm atIndex:0];
                [self.tableView reloadData];
                
            }else {
                
                //对内部进行评论 此时的model 比dataModel低一级
                zkHomelModel * mm = [zkHomelModel mj_objectWithKeyValues:responseObject[@"result"]];
                self.getHomeModel.replyCount = [NSString stringWithFormat:@"%ld", [self.getHomeModel.replyCount integerValue] + 1];
                [model.replyList addObject:mm];
                if (self.selectIndexPath.section == 0) {
                    //最热
                    for (zkHomelModel *modelTwo in self.dataModel.replyList) {
                        if ([modelTwo.ID isEqualToString:mm.ID]) {
                            [modelTwo.replyList insertObject:mm atIndex:0];
                            break;
                        }
                        
                    }
                }else {
                    for (zkHomelModel *modelTwo in self.dataModel.hotReplyList) {
                        if ([modelTwo.ID isEqualToString:mm.ID]) {
                            [modelTwo.replyList addObject:mm];
                            break;
                        }
                        
                    }
                }
                
                [self.tableView reloadData];
            }
            [self.keyView.textView resignFirstResponder];
            self.keyView.placehodleStr = @" 评论主帖";
        }else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}
#pragma mark --- 点击cell点赞 ---
- (void)didClickZanRenYuanView:(zkPingLunWaiCell *)cell zanBt:(UIButton *)button index:(NSInteger)index {
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell];
    if (index == -1) {
        //点赞
        zkHomelModel * model = [[zkHomelModel alloc] init];
        if (indexPath.section == 0) {
            model = self.dataModel.hotReplyList[indexPath.row];
        }else {
            model = self.dataModel.replyList[indexPath.row];
        }
        if (model.supportFlag) {
            [SVProgressHUD showErrorWithStatus:@"不可以重复点赞"];
            return;
        }
        [self zanActionType:2 IndexPath:indexPath model:model];
        
    }
    
    
}

- (void)didClickPingLunTableView:(zkPingLunWaiCell *)cell indexPath:(NSIndexPath *)indexPath {
    
     NSIndexPath * indexPathTwo = [self.tableView indexPathForCell:cell];
   __block zkHomelModel *model = [[zkHomelModel alloc] init];
    if (indexPathTwo.section == 0) {
        model = self.dataModel.hotReplyList[indexPathTwo.row];
    }else {
        model = self.dataModel.replyList[indexPathTwo.row];
    }
    zkPingLunXiangQingTVC * vc =[[zkPingLunXiangQingTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
    vc.hidesBottomBarWhenPushed = YES;
    self.isPush = YES;
    __weak typeof(self) weakSelf = self;
    vc.sendPingLunModel = ^(zkHomelModel *neiModel) {
       
            //点击的最热里面的
            for ( zkHomelModel * mm  in weakSelf.dataModel.replyList) {
                if ([neiModel.ID isEqualToString:mm.ID]) {
                    mm.replyList = neiModel.replyList;
                    mm.supportFlag = neiModel.supportFlag;
                    //model = neiModel;
                    break;
                }
            }
        //最新评论
            for ( zkHomelModel * mm  in weakSelf.dataModel.hotReplyList) {
                if ([neiModel.ID isEqualToString:mm.ID]) {
                    mm.replyList = neiModel.replyList;
                    mm.supportFlag = neiModel.supportFlag;
                    //model = neiModel;
                    break;
                }
                
            }
       
         [weakSelf.tableView reloadData];
        
    };
    vc.sendPingLunAddCount = ^(NSInteger count) {
        weakSelf.getHomeModel.replyCount = [NSString stringWithFormat:@"%ld", ([weakSelf.getHomeModel.replyCount integerValue] + count)];
    };
    vc.pingLunID = model.ID;
    vc.nickName = model.createByNickName;
    [self.navigationController pushViewController:vc animated:YES];
    
}

//点击内部的人
- (void)didClickPingLunView:(zkPingLunWaiCell *)cell indexPath:(NSIndexPath *)indexPath isFirstName:(BOOL)isFirstName {
    NSIndexPath * indePathWai = [self.tableView indexPathForCell:cell];
    zkHomelModel * model = [[zkHomelModel alloc] init];
    self.isHuiFuZhuTie = NO;
    if (indePathWai.section == 0) {
        model = self.dataModel.hotReplyList[indePathWai.row];
    }else {
       model = self.dataModel.replyList[indePathWai.row];
    }
    
    
    
    
}

#pragma mark ---- 点击赞或者分享 代理----
- (void)didClickZanOrXiaDanOrShare:(NSInteger)index {
    if (index == 0) {
        //赞
         [self zanActionType:1 IndexPath:nil model:nil];
    }else if (index == 1) {
        //下单
         zkBiZhongDetailTVC* vc =[[zkBiZhongDetailTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        vc.hidesBottomBarWhenPushed = YES;
        zkBiModel * model = [[zkBiModel alloc] init];
        model.bitName = self.dataModel.coinName;
        vc.model = model;
        [self.navigationController pushViewController:vc animated:YES]; 
    }else if (index == 2) {
        //分享
        
    }else if (index == 3) {
        //点击头像
        zkOtherCerterTVC * vc =[[zkOtherCerterTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        vc.hidesBottomBarWhenPushed = YES;
        vc.userID = self.dataModel.createBy;
        [self.navigationController pushViewController:vc animated:YES]; 
    }else if (index == 100) {
        //点击的
        self.isHuiFuZhuTie = YES;
        self.keyView.placehodleStr = @" 评论主贴";
    }
    
    
}

- (void)didClickZanPeopleWithID:(NSString *)ID andIsAll:(BOOL)isall {
    if (isall) {
        zkMineFenSiTVC * vc =[[zkMineFenSiTVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.isZan = YES;
        vc.topicID = self.ID;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        
        zkOtherCerterTVC * vc =[[zkOtherCerterTVC alloc] initWithTableViewStyle:UITableViewStyleGrouped];
        vc.hidesBottomBarWhenPushed = YES;
        vc.userID = ID;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    
    
}


#pragma  mark --- 点赞操作 ---
- (void)zanActionType:(NSInteger)type IndexPath:(NSIndexPath *)indexPath model:(zkHomelModel *)model{
    if (![zkSignleTool shareTool].isLogin) {
        [self gotoLoginVC];
        return;
    }
    NSMutableDictionary * dict =@{}.mutableCopy;
    if (type == 1) {
       dict[@"topicId"] = self.ID;
    }else {
        dict[@"topicId"] = model.ID;
    }
    dict[@"type"] = @(type);
    [SVProgressHUD show];
    [zkRequestTool networkingPOST:[zkURL getAddZanURL] parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] == 200) {
             [SVProgressHUD dismiss];
            if (type == 1) {
                //帖子点赞
                self.dataModel.supportNickNames = [[zkSignleTool shareTool].userInfoModel.nickName stringByAppendingString:[NSString stringWithFormat:@",%@",self.dataModel.supportNickNames]];
                self.dataModel.supportUserIds =  [[zkSignleTool shareTool].userInfoModel.ID stringByAppendingString:[NSString stringWithFormat:@",%@",self.dataModel.supportNickNames]];
                self.dataModel.supportFlag = self.keyView.moreBtn.selected = YES;
                self.headV.model = self.dataModel;
                if (self.getHomeModel.supportNickNames.length == 0) {
                    self.getHomeModel.supportNickNames = [zkSignleTool shareTool].userInfoModel.nickName;
                    NSInteger  zanNumber = [self.getHomeModel.supportCount integerValue] + 1;
                    self.getHomeModel.supportCount = [NSString stringWithFormat:@"%ld",zanNumber];
                    self.getHomeModel.supportUserIds = [zkSignleTool shareTool].userInfoModel.ID;
                }else {
                    self.getHomeModel.supportNickNames = [[zkSignleTool shareTool].userInfoModel.nickName stringByAppendingString:[NSString stringWithFormat:@",%@",self.getHomeModel.supportNickNames]];
                    NSInteger  zanNumber = [self.getHomeModel.supportCount integerValue] + 1;
                    self.getHomeModel.supportCount = [NSString stringWithFormat:@"%ld",zanNumber];
                    self.getHomeModel.supportUserIds =  [[zkSignleTool shareTool].userInfoModel.ID stringByAppendingString:[NSString stringWithFormat:@",%@",self.getHomeModel.supportUserIds]];
                }
                
                self.headV.height = self.headV.headHeight;
                self.tableView.tableHeaderView = self.headV;
            }else {
                if (indexPath.section == 0) {
                    
                    for (zkHomelModel * mm  in self.dataModel.replyList) {
                        if ([mm.topicId  isEqualToString:model.ID]) {
                            //说明热门和最新有交集
                            NSInteger  zanNumber = [mm.supportCount integerValue] + 1;
                            mm.supportCount = [NSString stringWithFormat:@"%ld",zanNumber];
                            mm.supportFlag = YES;
                            break;
                        }
                    }
                    NSInteger  zanNumber = [model.supportCount integerValue] + 1;
                    model.supportCount = [NSString stringWithFormat:@"%ld",zanNumber];
                    model.supportFlag = YES;
                }else {
                    for (zkHomelModel * mm  in self.dataModel.hotReplyList) {
                        if ([mm.topicId  isEqualToString:model.ID]) {
                            //说明热门和最新有交集
                            NSInteger  zanNumber = [mm.supportCount integerValue] + 1;
                            mm.supportCount = [NSString stringWithFormat:@"%ld",zanNumber];
                            mm.supportFlag = YES;
                            break;
                        }
                    }
                    NSInteger  zanNumber = [model.supportCount integerValue] + 1;
                    model.supportCount = [NSString stringWithFormat:@"%ld",zanNumber];
                    model.supportFlag = YES;
                }
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
            }
        } else if ([[NSString stringWithFormat:@"%@",responseObject[@"code"]] integerValue] ==700){
            [self showAlertWithKey:[NSString stringWithFormat:@"%@",responseObject[@"code"]] message:@""];
        }else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",responseObject[@"message"]]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
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
