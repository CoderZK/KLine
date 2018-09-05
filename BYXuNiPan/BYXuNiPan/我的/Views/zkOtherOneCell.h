//
//  zkOtherOneCell.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/13.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zkOtherCenterModel.h"
@interface zkOtherOneCell : UITableViewCell
@property(nonatomic,strong)zkOtherCenterModel *model;
@property (weak, nonatomic) IBOutlet UIButton *headBt;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property (weak, nonatomic) IBOutlet UILabel *fensiLb;
@property (weak, nonatomic) IBOutlet UILabel *ziXuanLB;
@property (weak, nonatomic) IBOutlet UIButton *dingYueBt;
@property (weak, nonatomic) IBOutlet UIButton *fenSiBt;
@property (weak, nonatomic) IBOutlet UIButton *ziXuanBt;

@end
