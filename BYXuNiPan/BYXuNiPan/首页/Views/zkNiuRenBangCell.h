//
//  zkNiuRenBangCell.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/13.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "zkNiuRenBangModel.h"
#import "zkBtcRankModel.h"
@interface zkNiuRenBangCell : UITableViewCell

//@property(nonatomic,strong)zkNiuRenBangModel *model;
@property(nonatomic,strong)zkBtcRankModel *model;
@property(nonatomic,strong)UIButton *headBt;  //头像
@property(nonatomic,strong)UIImageView *imgV;  //头像排名
@property(nonatomic,strong)UILabel *titleLB; //昵称
@property(nonatomic,strong)UILabel *signLB;   //签名
@property(nonatomic,strong)UILabel *allEarningsLB; //总收益
@property(nonatomic,strong)UILabel *dayEarningsLB; //日收益
@property(nonatomic,strong)UILabel *weekEarningsLB; // 周收益
@property(nonatomic,strong)UILabel *dayOperationLB; // 日操作
@property(nonatomic,strong)UILabel *allCurrencyLB; //币种
@property(nonatomic,strong)UILabel *newsBuyLB; //最新买入

@end
