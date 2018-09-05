//
//  zkSettingCell.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/16.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface zkSettingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftLB;
@property (weak, nonatomic) IBOutlet UILabel *rightLB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightCon;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageV;
@property (weak, nonatomic) IBOutlet UISwitch *swiftOn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLBCon;

@property(nonatomic,assign)BOOL hidenRightImgV;

@end
