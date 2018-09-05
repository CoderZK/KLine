//
//  zkChiCangMingXiCell.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/14.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zkBTCChiYouModel.h"
@interface zkChiCangMingXiCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *biZhongLB;
@property (weak, nonatomic) IBOutlet UILabel *chiCangLB;
@property (weak, nonatomic) IBOutlet UILabel *chiCangJiaLB;
@property (weak, nonatomic) IBOutlet UILabel *nowJiaLB;
@property (weak, nonatomic) IBOutlet UILabel *earningsLB;

@property(nonatomic,strong)NSArray *titleArr;

@property(nonatomic,strong)zkBTCChiYouModel *model;

@end
