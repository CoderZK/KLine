//
//  zkPingLunDetailCell.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/27.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface zkPingLunDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *headBt;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UILabel *contentLB;
@property (weak, nonatomic) IBOutlet UILabel *zanLB;
@property (weak, nonatomic) IBOutlet UIImageView *zanImgV;
@property (weak, nonatomic) IBOutlet UIButton *zanBt;

@property(nonatomic,strong)NSString *parentId;
@property(nonatomic,strong)zkHomelModel *model;

@end
