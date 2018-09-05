//
//  zkShowMingXiCell.m
//  BYXuNiPan
//
//  Created by zk on 2018/7/14.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import "zkShowMingXiCell.h"
#import "zkChiCangMingXiCell.h"
#import "zkWeiChengJiaoCell.h"
#import "zkChengJiaoLiShiCell.h"
#import "zkLishiWeiTuoCell.h"
@interface zkShowMingXiCell()<UITableViewDelegate,UITableViewDataSource>

/**  */
@property(nonatomic,strong)UIScrollView *scrollView;
/**  */
@property(nonatomic,strong)UITableView *tableView;
/**  */
@property(nonatomic,strong)NSArray *titleArr;

/** 蒙层 */
@property(nonatomic,strong)UIView *mView ,*backLinV;
/**  */
@property(nonatomic,strong)UILabel *dingYueLB;

@end

@implementation zkShowMingXiCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.titleArr = @[@[@"币种",@"持仓量 ( 比例 ) ",@"持仓价",@"当前价格",@"收益率"],@[@"类型",@"币种",@"状态",@"委托价格",@"数量",@"撤单"],@[@"类型",@"币种",@"委托价格",@"数量",@"成交时间"],@[@"类型",@"币种",@"状态",@"委托价格",@"数量",@"成交时间"]];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 200)];
        self.scrollView.contentSize = CGSizeMake(ScreenW, 0);
        self.scrollView.bounces = NO;
//        self.scrollView.backgroundColor = [UIColor greenColor];
        [self addSubview:_scrollView];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.contentSize.width, 0.01)];
        [self.scrollView addSubview:self.tableView];
        self.tableView.delegate= self;
        self.tableView.dataSource = self;
        self.tableView.scrollEnabled = NO;
        
       
        //持仓明细
        [self.tableView registerNib:[UINib nibWithNibName:@"zkChiCangMingXiCell" bundle:nil] forCellReuseIdentifier:@"zkChiCangMingXiCell"];
        //成交历史
        [self.tableView registerNib:[UINib nibWithNibName:@"zkChengJiaoLiShiCell" bundle:nil] forCellReuseIdentifier:@"zkChengJiaoLiShiCell"];
        //未成交
         [self.tableView registerNib:[UINib nibWithNibName:@"zkWeiChengJiaoCell" bundle:nil] forCellReuseIdentifier:@"zkWeiChengJiaoCell"];
        //历史委托
        [self.tableView registerNib:[UINib nibWithNibName:@"zkLishiWeiTuoCell" bundle:nil] forCellReuseIdentifier:@"zkLishiWeiTuoCell"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
       
        
        UIView * backV =[[UIView alloc] initWithFrame:CGRectMake(15, 200, ScreenW - 30, 0.6)];
        backV.backgroundColor = lineBackColor;
        self.backLinV = backV;
        [self addSubview:backV];
        
        UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(15, 201, ScreenW - 30, 38);
 
        [button setTitle:@"查看全部>" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:CharacterColor50 forState:UIControlStateNormal];
        button.layer.cornerRadius = 0;
        button.clipsToBounds = YES;
        [self addSubview:button];
        
        self.moreBt = button;

        self.mView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 240)];
        self.mView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.92];
        [self addSubview:self.mView];

        
        self.dingYueLB = [[UILabel alloc] initWithFrame:self.mView.bounds];
        self.dingYueLB.numberOfLines = 0;
        self.dingYueLB.font = kFont(16);
        self.dingYueLB.textColor = BlueColor;
        self.dingYueLB.textAlignment = NSTextAlignmentCenter;
        self.dingYueLB.text = @"订阅后查看详细交易记录并可\n\n收到即时动态推送消息\n\n50LXC";

        
        [self.mView addSubview:self.dingYueLB];
        
        self.mView.hidden = YES;
        
        
    }
    return self;
}

- (void)setType:(NSInteger)type {
    _type = type;
}

- (void)setModel:(zkOtherCenterModel *)model {
    _model = model;
    if ([model.followFlag integerValue] == 1 || [_model.myHome integerValue] == 1) {
        self.mView.hidden = YES;
    }else {
        self.mView.hidden = NO;
        self.tableView.mj_h = 240;
    }
    self.dingYueLB.text = [NSString stringWithFormat:@"订阅后查看详细交易记录并可\n\n收到即时动态推送消息\n\n%@  Lxc",model.supportHelper.lxcPrice];
    if (self.type == 0) {
        self.tableView.mj_h  = self.backLinV.mj_y=  model.holdingCoinList.count > 4 ? 200 :model.holdingCoinList.count*40+40;
        self.backLinV.hidden = self.moreBt.hidden = model.holdingCoinList.count > 4 ? NO:YES;
        self.moreBt.mj_y = model.holdingCoinList.count > 4 ? 200+1:model.holdingCoinList.count*40+40+1;
        if (model.holdingCoinList.count == 0) {
            self.tableView.mj_h = 0;
        }
    }else if (self.type == 1) {
        self.tableView.mj_h = self.backLinV.mj_y=  model.unPayTradeList.count > 4 ? 200:model.unPayTradeList.count*40+40;
        self.backLinV.hidden = self.moreBt.hidden = model.unPayTradeList.count > 4 ? NO:YES;
         self.moreBt.mj_y = model.unPayTradeList.count > 4 ? 200+1:model.unPayTradeList.count*40+40+1;
        if (model.unPayTradeList.count == 0) {
            self.tableView.mj_h = 0;
        }
    }else if (self.type == 2) {
        self.tableView.mj_h= self.backLinV.mj_y =  model.historyTradeList.count > 4 ? 200:model.historyTradeList.count*40+40;
        self.backLinV.hidden = self.backLinV.mj_x= self.moreBt.hidden = model.historyTradeList.count > 4 ? NO:YES;
         self.moreBt.mj_y = model.historyTradeList.count > 4 ? 200+1:model.historyTradeList.count*40+40+1;
        if (model.historyTradeList.count == 0) {
            self.tableView.mj_h = 0;
        }
    }else {
        self.tableView.mj_h = self.backLinV.mj_y= model.historyEntrustList.count > 4 ? 200:model.historyEntrustList.count*40+40;
        self.backLinV.hidden = self.moreBt.hidden = model.historyEntrustList.count > 4 ? NO:YES;
        self.moreBt.mj_y = model.historyEntrustList.count > 4 ? 200+1:model.historyEntrustList.count*40+40+1;
        if (model.historyEntrustList.count == 0) {
            self.tableView.mj_h = 0;
        }
    }
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    if (section == 0) {
        if (self.type == 0) {
            return self.model.holdingCoinList.count > 0 ? 1:0;
        }else if (self.type == 1) {
            return self.model.unPayTradeList.count > 0 ? 1:0;
        }else if (self.type == 2) {
            return self.model.historyTradeList.count > 0 ? 1:0;
        }else {
            return self.model.historyEntrustList.count > 0 ? 1:0;
        }
    }
    if (self.type == 0) {
        return self.model.holdingCoinList.count > 4 ? 4:self.model.holdingCoinList.count;
    }else if (self.type == 1) {
        return self.model.unPayTradeList.count > 4 ? 4:self.model.unPayTradeList.count;
    }else if (self.type == 2) {
        return self.model.historyTradeList.count > 4 ? 4:self.model.historyTradeList.count;
    }else {
        return self.model.historyEntrustList.count > 4 ? 4:self.model.historyEntrustList.count;
    }
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

//@property(nonatomic,strong)NSMutableArray<zkBTCChiYouModel *> *historyEntrustList; //历史委托
//@property(nonatomic,strong)NSMutableArray<zkBTCChiYouModel *> *historyTradeList;  //成交明细
//@property(nonatomic,strong)NSMutableArray<zkBTCChiYouModel *> *holdingCoinList; //持仓明细
//@property(nonatomic,strong)NSMutableArray<zkBTCChiYouModel *> *unPayTradeList; //未成交明细

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.type == 0) {
        //持仓明细
        zkChiCangMingXiCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkChiCangMingXiCell" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            cell.titleArr = self.titleArr[self.type];
            cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }else {
            
            cell.backgroundColor = WhiteColor;
            cell.model = self.model.holdingCoinList[indexPath.row];
        }
        return cell;
    }else if (self.type == 1) {
        //未成交
        zkWeiChengJiaoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkWeiChengJiaoCell" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            cell.titleArr = self.titleArr[self.type];
            cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }else {
            cell.backgroundColor = WhiteColor;
            cell.model = self.model.unPayTradeList[indexPath.row];
            cell.cheDanBt.tag = indexPath.row;
            [cell.cheDanBt addTarget:self action:@selector(cheDanAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;
    }else if (self.type == 2) {
        //成交历史
        zkChengJiaoLiShiCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkChengJiaoLiShiCell" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            cell.titleArr = self.titleArr[self.type];
            cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }else {
            cell.model = self.model.historyTradeList[indexPath.row];
            cell.backgroundColor = WhiteColor;
        }
        
        
        
        return cell;
    }
   
    zkLishiWeiTuoCell * cell =[tableView dequeueReusableCellWithIdentifier:@"zkLishiWeiTuoCell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.titleArr = self.titleArr[self.type];
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }else {
        cell.model = self.model.historyEntrustList[indexPath.row];
        cell.backgroundColor = WhiteColor;
    }
    return cell;
    
}

- (void)cheDanAction:(UIButton *)button {
    
    zkBTCChiYouModel * model = self.model.historyTradeList[button.tag];
    if ([zkSignleTool shareTool].isLogin && [model.userId isEqualToString:[zkSignleTool shareTool].userInfoModel.ID]) {
        if(self.delegete != nil && [self.delegete respondsToSelector:@selector(didSelectCell:indexPath:)]) {
            [self.delegete didSelectCheDanWithIndex:button.tag WithModel:model];
        }
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(self.delegete != nil && [self.delegete respondsToSelector:@selector(didSelectCell:indexPath:)]) {
        [self.delegete didSelectCell:self indexPath:indexPath];
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
