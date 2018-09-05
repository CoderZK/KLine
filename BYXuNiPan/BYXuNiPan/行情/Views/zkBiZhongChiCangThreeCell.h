//
//  zkBiZhongChiCangThreeCell.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/20.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zkOneBtcChiCangModel.h"
@interface zkBiZhongChiCangThreeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *pointImgV;
@property (weak, nonatomic) IBOutlet UIImageView *timeImgeV;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UIView *viewUpV;
@property (weak, nonatomic) IBOutlet UIView *viewDownV;
@property(nonatomic,strong)zkOneBtcChiCangModel *model;

@end
