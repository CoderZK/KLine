//
//  zkChengJiaoLiShiCell.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/14.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zkBTCChiYouModel.h"
@interface zkChengJiaoLiShiCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *TypeLB;
@property (weak, nonatomic) IBOutlet UILabel *biZhongLB;
@property (weak, nonatomic) IBOutlet UILabel *weiTuoLB;
@property (weak, nonatomic) IBOutlet UILabel *numberLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property(nonatomic,strong)NSArray *titleArr;
@property(nonatomic,strong)zkBTCChiYouModel *model;
@end
