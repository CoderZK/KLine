//
//  zkWeiChengJiaoCell.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/14.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zkBTCChiYouModel.h"
@interface zkWeiChengJiaoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *TypeLB;
@property (weak, nonatomic) IBOutlet UILabel *biZhongLB;
@property (weak, nonatomic) IBOutlet UILabel *statusLB;
@property (weak, nonatomic) IBOutlet UILabel *weiTuoLB;
@property (weak, nonatomic) IBOutlet UILabel *nowJiaLB;
@property (weak, nonatomic) IBOutlet UILabel *revokeLB;
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)zkBTCChiYouModel *model;
@property (weak, nonatomic) IBOutlet UIButton *cheDanBt;

@end
