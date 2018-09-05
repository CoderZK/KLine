//
//  zkSearchBiZhongCell.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/16.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zkBiModel.h"
@interface zkSearchBiZhongCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UIButton *rightBt;
@property(nonatomic,strong)zkBiModel *model;
@end
