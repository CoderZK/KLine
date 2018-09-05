//
//  zkSystemNotificationCell.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/12.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zkMessageModel.h"
@interface zkSystemNotificationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property(nonatomic,strong)zkMessageModel *model;
@end
