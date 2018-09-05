//
//  zkSearchJiaoYiCell.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/19.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zkSearchModel.h"
//高度124

@interface zkSearchJiaoYiCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *headBt;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UILabel *buyOrSellLB;
@property (weak, nonatomic) IBOutlet UILabel *priceLB;
@property (weak, nonatomic) IBOutlet UILabel *numberLB;
@property (weak, nonatomic) IBOutlet UILabel *biZhongLB;
@property(nonatomic,strong)zkSearchModel *model;


@end
