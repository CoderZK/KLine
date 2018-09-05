//
//  zkSearchTieZiCell.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/19.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zkSearchModel.h"
@interface zkSearchTieZiCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *headBt;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property(nonatomic,strong)zkSearchModel *model;
@end
