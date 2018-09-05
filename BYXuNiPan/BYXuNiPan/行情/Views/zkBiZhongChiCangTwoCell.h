//
//  zkBiZhongChiCangTwoCell.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/20.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zkOneBtcChiCangModel.h"
@interface zkBiZhongChiCangTwoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *biZhongNameLB;
@property (weak, nonatomic) IBOutlet UILabel *jiaGeLB;//涨跌
@property (weak, nonatomic) IBOutlet UILabel *desLB;
@property (weak, nonatomic) IBOutlet UILabel *yingKuiLB;
@property (weak, nonatomic) IBOutlet UILabel *shiZhiLB;
@property (weak, nonatomic) IBOutlet UILabel *chiCangLB;
@property (weak, nonatomic) IBOutlet UILabel *cangWeiLB;
@property (weak, nonatomic) IBOutlet UILabel *shouYiLB;
@property (weak, nonatomic) IBOutlet UILabel *meiGuChengBenLB;
@property (weak, nonatomic) IBOutlet UILabel *numberLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UIButton *buyBt;
@property (weak, nonatomic) IBOutlet UIButton *sellBt;
@property (weak, nonatomic) IBOutlet UILabel *zhangDieFuLb;//涨跌幅
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *zhangDieCon;

@property(nonatomic,strong)zkOneBtcChiCangModel *model;

@end
