//
//  zkHangQingCell.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/16.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zkBiModel.h"
@interface zkHangQingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *rankingLB;
@property (weak, nonatomic) IBOutlet UILabel *biZhongLB;
@property (weak, nonatomic) IBOutlet UILabel *nowJiaGeLB;
@property (weak, nonatomic) IBOutlet UILabel *shiZhiLB;
@property (weak, nonatomic) IBOutlet UILabel *shiZhiTwoLB;
@property (weak, nonatomic) IBOutlet UIButton *earningBt;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rankingLBWidthCon;
@property(nonatomic,strong)zkBiModel *model;
@end
