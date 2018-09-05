//
//  zkOtherTwoCell.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/13.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zkOtherCenterModel.h"
@interface zkOtherTwoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *allRankingLB;
@property (weak, nonatomic) IBOutlet UILabel *allMoneyLB;
@property (weak, nonatomic) IBOutlet UILabel *allRatioLB;
@property (weak, nonatomic) IBOutlet UILabel *dayRankingLB;
@property (weak, nonatomic) IBOutlet UILabel *weekRankingLB;
@property (weak, nonatomic) IBOutlet UILabel *dayRationLB;
@property (weak, nonatomic) IBOutlet UILabel *weekRationLB;
@property (weak, nonatomic) IBOutlet UILabel *capitalNumberLB;
@property (weak, nonatomic) IBOutlet UILabel *dayOpcationLB;
@property(nonatomic,strong)zkUserInfoModel *model;
@property(nonatomic,strong)zkOtherCenterModel *modelTwo;
@end
