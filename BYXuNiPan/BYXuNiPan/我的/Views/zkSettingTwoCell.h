//
//  zkSettingTwoCell.h
//  BYXuNiPan
//
//  Created by zk on 2018/7/17.
//  Copyright © 2018年 kunzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface zkSettingTwoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImageV;
@property (weak, nonatomic) IBOutlet UIButton *headBt;
@property (weak, nonatomic) IBOutlet UILabel *leftLB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgVwidthCon;
@property (weak, nonatomic) IBOutlet UIImageView *rightImgV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLBRightCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headWidthCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headHeightCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgHeightCon;

@property (weak, nonatomic) IBOutlet UILabel *rightLB;
@property(nonatomic,assign)NSInteger type;

@end
